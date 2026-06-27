use tiny_http::{Server, Response};
use url::Url;
mod soap_client;
mod spanish_number;

fn obtener_n(path: &str) -> Option<i32> {
    let url = format!("http://localhost{}", path);
    let parsed = Url::parse(&url).ok()?;
    for (k, v) in parsed.query_pairs() {
        if k == "n" { return v.parse::<i32>().ok(); }
    }
    None
}

fn main() {
    let port = 3072;
    let server = Server::http(format!("0.0.0.0:{}", port)).unwrap();
    println!("Servidor Rust SOAP traducido ejecutándose en http://localhost:3072");

    for request in server.incoming_requests() {
        let body = match obtener_n(request.url()) {
            Some(n) => { let ingles = match soap_client::consultar_soap(n) { Ok(t) => t, Err(e) => format!("Error SOAP: {}", e) }; let espanol = spanish_number::numero_a_espanol(n); format!("SOAP inglés: {}\nTraducción al español: {}", ingles, espanol) },
            None => format!("Debes enviar un número. Ejemplo: http://localhost:{}/?n=10", port)
        };
        let _ = request.respond(Response::from_string(body));
    }
}
