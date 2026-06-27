use tiny_http::{Server, Response};
use url::Url;
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
    let port = 3073;
    let server = Server::http(format!("0.0.0.0:{}", port)).unwrap();
    println!("Servidor Rust local en español ejecutándose en http://localhost:3073");

    for request in server.incoming_requests() {
        let body = match obtener_n(request.url()) {
            Some(n) => { let espanol = spanish_number::numero_a_espanol(n); format!("Número: {}\nResultado local: {}", n, espanol) },
            None => format!("Debes enviar un número. Ejemplo: http://localhost:{}/?n=10", port)
        };
        let _ = request.respond(Response::from_string(body));
    }
}
