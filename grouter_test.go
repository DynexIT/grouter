package grouter

import (
	"net/http"
	"testing"
)

func TestGrouter(t *testing.T) { //Minimal test just to see that everything compiles upon building
	router := NewRouter()
	router.Bind("/test", func(w http.ResponseWriter, r *http.Request) {

	})
}
