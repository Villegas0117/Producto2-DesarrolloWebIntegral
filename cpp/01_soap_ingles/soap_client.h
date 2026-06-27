#include <string>
#include <cstdio>
#include <array>
#include <regex>

std::string ejecutarComando(const std::string& comando) {
    std::array<char, 256> buffer;
    std::string resultado;
    FILE* pipe = popen(comando.c_str(), "r");
    if (!pipe) return "No se pudo ejecutar curl";
    while (fgets(buffer.data(), buffer.size(), pipe) != nullptr) resultado += buffer.data();
    pclose(pipe);
    return resultado;
}

std::string consultarSOAP(int n) {
    std::string xml =
        "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
        "<soap:Body><NumberToWords xmlns=\"http://www.dataaccess.com/webservicesserver/\">"
        "<ubiNum>" + std::to_string(n) + "</ubiNum>"
        "</NumberToWords></soap:Body></soap:Envelope>";

    std::string comando =
        "curl -s -X POST "
        "-H 'Content-Type: text/xml; charset=utf-8' "
        "-H 'SOAPAction: http://www.dataaccess.com/webservicesserver/NumberToWords' "
        "--data '" + xml + "' "
        "https://www.dataaccess.com/webservicesserver/NumberConversion.wso";

    std::string body = ejecutarComando(comando);
    std::regex patron("<m:NumberToWordsResult>(.*?)</m:NumberToWordsResult>|<NumberToWordsResult>(.*?)</NumberToWordsResult>");
    std::smatch match;
    if (std::regex_search(body, match, patron)) {
        if (match[1].matched) return match[1].str();
        return match[2].str();
    }
    return "Resultado no encontrado";
}
