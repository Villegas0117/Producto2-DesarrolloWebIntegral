package main
import ("fmt"; "net/http"; "strconv")
func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        n, err := strconv.Atoi(r.URL.Query().Get("n"))
        if err != nil { fmt.Fprint(w, "Debes enviar un número. Ejemplo: http://localhost:3043/?n=10"); return }
        fmt.Fprintf(w, "Número: %d\nResultado local: %s", n, numeroAEspanol(n))
    })
    fmt.Println("Servidor Go local en español ejecutándose en http://localhost:3043")
    http.ListenAndServe(":3043", nil)
}
