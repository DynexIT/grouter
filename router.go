package grouter

import (
	"fmt"
	"github.com/gorilla/mux"
	"net/http"
	"strings"
)

type APIBind struct {
	path          *string
	function      *func(w http.ResponseWriter, r *http.Request)
	variableCount int
}

func (a *APIBind) comparePriorityTo(bind *APIBind) int {
	selfPath := *a.path
	targetPath := *bind.path
	selfSplit := strings.Split(selfPath, "/")
	targetSplit := strings.Split(targetPath, "/")
	if len(selfSplit) > len(targetSplit) {
		return 1
	} else if len(targetSplit) < len(selfSplit) {
		return -1
	}
	for i := 0; i < len(selfSplit) && i < len(targetSplit); i++ {
		if !isPathVariable(selfSplit[i]) && isPathVariable(targetSplit[i]) {
			return -1
		} else if isPathVariable(selfSplit[i]) && !isPathVariable(targetSplit[i]) {
			return 1
		}
	}
	return 0
}

func isPathVariable(text string) bool {
	if len(text) == 0 {
		return false
	}
	if text[0] == '{' && text[len(text)-1] == '}' {
		return true
	}
	return false
}

type Router struct {
	MuxRouter *mux.Router
	apiBinds  []*APIBind
}

func NewRouter() *Router {
	return &Router{
		MuxRouter: mux.NewRouter(),
	}
}
func (r *Router) BuildMuxRouter() *mux.Router {
	sortedApiBinds := r.apiBinds
	for i := range sortedApiBinds {
		for j := i; j > 0; j-- {
			if sortedApiBinds[j-1].comparePriorityTo(sortedApiBinds[j]) > 0 {
				sortedApiBinds[j-1], sortedApiBinds[j] = sortedApiBinds[j], sortedApiBinds[j-1]
			}
		}
	}
	fmt.Println("Binding Controllers:")
	for _, apiBind := range sortedApiBinds {
		r.MuxRouter.HandleFunc(*apiBind.path, *apiBind.function)
		lessTrailingSlashURL := *apiBind.path
		lessTrailingSlashURL = lessTrailingSlashURL[:len(lessTrailingSlashURL)-1]
		r.MuxRouter.HandleFunc(lessTrailingSlashURL, *apiBind.function)
		fmt.Println(*apiBind.path)
	}
	return r.MuxRouter
}
func (r *Router) Bind(path string, function func(w http.ResponseWriter, r *http.Request)) {
	path = normalizePath(path)
	r.apiBinds = append(r.apiBinds, &APIBind{
		&path,
		&function,
		0,
	})
}
func normalizePath(path string) string {
	if len(path) == 0 {
		return path
	}
	if path[0] != '/' {
		path = "/" + path
	}
	if path[len(path)-1] != '/' {
		path += "/"
	}
	return path
}
