package grouter

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
