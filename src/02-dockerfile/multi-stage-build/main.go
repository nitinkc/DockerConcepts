package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, "Hello from a multi-stage Docker build!")
	})
	fmt.Println("Listening on :8080")
	_ = http.ListenAndServe(":8080", nil)
}
