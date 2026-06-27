package main
import ("fmt"; "net/http"; "strconv")
func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        n, err := strconv.Atoi(r.URL.Query().Get("n"))
        if err != nil { fmt.Fprint(w, "Debes enviar un número. Ejemplo: http://localhost:3042/?n=10"); return }
        ingles, err := consultarSOAP(n)
        if err != nil { fmt.Fprint(w, "Error al consumir SOAP: ", err); return }
        fmt.Fprintf(w, "SOAP inglés: %s\nTraducción al español: %s", ingles, numeroAEspanol(n))
    })
    fmt.Println("Servidor Go SOAP traducido ejecutándose en http://localhost:3042")
    http.ListenAndServe(":3042", nil)
}
