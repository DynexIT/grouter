# Go Router

Package `grouter` implements a request router based on the `gorilla/mux` package, in order to make sure you can bind controllers to the router in any order without endpoint URL conflicts.

## Install

You can go get the package with 
```sh
go get -u github.com/DynexIT/grouter
```

### Examples
```go
func main(){
	r := grouter.NewRouter()
	r.Bind("/path/{variable}/", func(w http.ResponseWriter, r *http.Request){
		//Some code to execute at the API endpoint here
	})
	log.Fatal(http.listenAndServe("localhost:8080", r.BuildMuxRouter()))
}
```

The bind function will pend the function for being handled by the router till the `BuildMuxRouter()` function has been called.
When the function is called, it will bind the endpoints in the correct order as to not have API conflicts.
This allows the endpoints to not know about each other and be handed off to controllers to have their functions bound.

URL's will also not be penalized for not having trailing or leading `/`'s and will have it reformatted to be a normalized URL for the router with expected behavior, as well as having mapped out the same function for URL's without the trailing `/`. 
