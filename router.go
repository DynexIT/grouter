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
	MuxRouter        *mux.Router
	routes           []*Route
	middlewares      []mux.MiddlewareFunc
	RespondToOptions bool
}

func NewRouter() *Router {
	return &Router{
		MuxRouter:        mux.NewRouter(),
		routes:           make([]*Route, 0),
		RespondToOptions: false,
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
		muxRoute := r.MuxRouter.HandleFunc(*route.path, *route.function)
		lessTrailingSlashURL := *route.path
		lessTrailingSlashURL = lessTrailingSlashURL[:len(lessTrailingSlashURL)-1]
		if len(route.methods) != 0 {
			if r.RespondToOptions {
				route.methods = append(route.methods, "OPTIONS")
			}
			muxRoute.Methods(route.methods...)
		}
		muxRoute = r.MuxRouter.HandleFunc(lessTrailingSlashURL, *route.function)
		if len(route.methods) != 0 {
			if r.RespondToOptions {
				route.methods = append(route.methods, "OPTIONS")
			}
			muxRoute.Methods(route.methods...)
		}
		fmt.Println(*route.path)
	}
	if r.RespondToOptions {
		r.middlewares = append(r.middlewares, func(next http.Handler) http.Handler {
			return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				if strings.ToLower(r.Method) == "options" {
					w.WriteHeader(http.StatusOK)
					return
				}
				next.ServeHTTP(w, r)
			})
		})
	}
	if len(r.middlewares) > 0 {
		r.MuxRouter.Use(r.middlewares...)
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
func (r *Router) RespondOKToOptions(respond bool) {
	r.RespondToOptions = respond
}
func (r *Router) Use(mwf ...mux.MiddlewareFunc) {
	r.middlewares = mwf
}
