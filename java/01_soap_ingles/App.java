import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;

public class App {
    public static void main(String[] args) throws Exception {
        int port = 3051;
        HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);
        server.createContext("/", exchange -> {
            try {
                String query = exchange.getRequestURI().getQuery();
                if (query == null || !query.startsWith("n=")) {
                    responder(exchange, "Debes enviar un número. Ejemplo: http://localhost:3051/?n=10");
                    return;
                }
                int n = Integer.parseInt(query.replace("n=", ""));
                String ingles = SoapClientNumber.consultarSOAP(n); responder(exchange, "SOAP inglés: " + ingles);
            } catch (Exception e) {
                responder(exchange, "Error: " + e.getMessage());
            }
        });
        System.out.println("Servidor Java SOAP en inglés ejecutándose en http://localhost:3051");
        server.start();
    }

    static void responder(com.sun.net.httpserver.HttpExchange exchange, String texto) throws IOException {
        byte[] data = texto.getBytes(StandardCharsets.UTF_8);
        exchange.getResponseHeaders().add("Content-Type", "text/plain; charset=utf-8");
        exchange.sendResponseHeaders(200, data.length);
        exchange.getResponseBody().write(data);
        exchange.close();
    }
}
