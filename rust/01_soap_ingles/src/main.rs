use tiny_http::{Server, Response};
use url::Url;
mod soap_client;

fn obtener_n(path: &str) -> Option<i32> {
    let url = format!("http://localhost{}", path);
    let parsed = Url::parse(&url).ok()?;
    for (k, v) in parsed.query_pairs() {
        if k == "n" { return v.parse::<i32>().ok(); }
    }
    None
}

fn main() {
    let port = 3071;
    let server = Server::http(format!("0.0.0.0:{}", port)).unwrap();
    println!("Servidor Rust SOAP en inglés ejecutándose en http://localhost:3071");

    for request in server.incoming_requests() {
        let body = match obtener_n(request.url()) {
            Some(n) => { match soap_client::consultar_soap(n) { Ok(ingles) => format!("SOAP inglés: {}", ingles), Err(e) => format!("Error al consumir SOAP: {}", e) } },
            None => format!("Debes enviar un número. Ejemplo: http://localhost:{}/?n=10", port)
        };
        let _ = request.respond(Response::from_string(body));
    }
}
