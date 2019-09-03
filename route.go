package grouter

import (
	"net/http"
	"strings"
)

type Route struct {
	path          *string
	function      *func(w http.ResponseWriter, r *http.Request)
	variableCount int
	methods       []string
}

func (a *Route) Methods(methods ...string) *Route {
	a.methods = append(a.methods, methods...)
	return a
}

func (a *Route) comparePriorityTo(bind *Route) int {
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
