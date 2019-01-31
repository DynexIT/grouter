package grouter

import (
	"fmt"
	"github.com/gorilla/mux"
	"net/http"
	"strings"
)

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
	routes    []*Route
}

func NewRouter() *Router {
	return &Router{
		MuxRouter: mux.NewRouter(),
	}
}
func (r *Router) BuildMuxRouter() *mux.Router {
	sortedRoutes := r.routes
	for i := range sortedRoutes {
		for j := i; j > 0; j-- {
			if sortedRoutes[j-1].comparePriorityTo(sortedRoutes[j]) > 0 {
				sortedRoutes[j-1], sortedRoutes[j] = sortedRoutes[j], sortedRoutes[j-1]
			}
		}
	}
	fmt.Println("Binding Controllers:")
	for _, route := range sortedRoutes {
		muxRoute := r.MuxRouter.HandleFunc(*route.path, func(w http.ResponseWriter, r2 *http.Request) {
			f := *route.function
			if route.optionsMiddleWare {
				if strings.ToLower(r2.Method) == "options" {
					w.WriteHeader(200)
					return
				}
				f(w, r2)
			} else {
				f(w, r2)
			}
		})
		lessTrailingSlashURL := *route.path
		lessTrailingSlashURL = lessTrailingSlashURL[:len(lessTrailingSlashURL)-1]
		if len(route.methods) != 0 {
			muxRoute.Methods(route.methods...)
		}
		muxRoute = r.MuxRouter.HandleFunc(lessTrailingSlashURL, *route.function)
		if len(route.methods) != 0 {
			muxRoute.Methods(route.methods...)
		}
		fmt.Println(*route.path)
	}
	return r.MuxRouter
}
func (r *Router) Bind(path string, function func(w http.ResponseWriter, r *http.Request)) *Route {
	path = normalizePath(path)
	route := &Route{
		path:          &path,
		function:      &function,
		variableCount: 0,
	}
	r.routes = append(r.routes, route)
	return route
}
