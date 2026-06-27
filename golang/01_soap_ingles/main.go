package main
import ("fmt"; "net/http"; "strconv")
func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        n, err := strconv.Atoi(r.URL.Query().Get("n"))
        if err != nil { fmt.Fprint(w, "Debes enviar un número. Ejemplo: http://localhost:3041/?n=10"); return }
        ingles, err := consultarSOAP(n)
        if err != nil { fmt.Fprint(w, "Error al consumir SOAP: ", err); return }
        fmt.Fprint(w, "SOAP inglés: ", ingles)
    })
    fmt.Println("Servidor Go SOAP en inglés ejecutándose en http://localhost:3041")
    http.ListenAndServe(":3041", nil)
}
