#include <iostream>
#include <string>
#include <unistd.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include "soap_client.h"
#include "spanish_number.h"

int obtenerNumero(const std::string& request) {
    size_t pos = request.find("GET /?n=");
    if (pos == std::string::npos) return -999999;
    size_t inicio = pos + 8;
    size_t fin = request.find(" ", inicio);
    return std::stoi(request.substr(inicio, fin - inicio));
}

void responder(int cliente, const std::string& body) {
    std::string response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain; charset=utf-8\r\nContent-Length: " + std::to_string(body.size()) + "\r\n\r\n" + body;
    send(cliente, response.c_str(), response.size(), 0);
}

int main() {
    int puerto = 3062;
    int servidor = socket(AF_INET, SOCK_STREAM, 0);
    int opt = 1;
    setsockopt(servidor, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    sockaddr_in direccion{};
    direccion.sin_family = AF_INET;
    direccion.sin_addr.s_addr = INADDR_ANY;
    direccion.sin_port = htons(puerto);

    bind(servidor, (sockaddr*)&direccion, sizeof(direccion));
    listen(servidor, 10);

    std::cout << "Servidor C++ SOAP traducido ejecutándose en http://localhost:3062" << std::endl;

    while (true) {
        int cliente = accept(servidor, nullptr, nullptr);
        char buffer[4096] = {0};
        read(cliente, buffer, 4096);
        std::string request(buffer);
        int n = obtenerNumero(request);

        if (n == -999999) {
            responder(cliente, "Debes enviar un número. Ejemplo: http://localhost:3062/?n=10");
        } else {
            std::string ingles = consultarSOAP(n); std::string espanol = numeroAEspanol(n); responder(cliente, "SOAP inglés: " + ingles + "\nTraducción al español: " + espanol);
        }
        close(cliente);
    }
}
