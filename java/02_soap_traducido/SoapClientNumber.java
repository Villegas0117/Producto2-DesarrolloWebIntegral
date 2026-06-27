import java.net.URI;
import java.net.http.*;
import java.util.regex.*;

public class SoapClientNumber {
    public static String consultarSOAP(int n) throws Exception {
        String xml = """
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
      <ubiNum>%d</ubiNum>
    </NumberToWords>
  </soap:Body>
</soap:Envelope>
""".formatted(n);

        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("https://www.dataaccess.com/webservicesserver/NumberConversion.wso"))
            .header("Content-Type", "text/xml; charset=utf-8")
            .header("SOAPAction", "http://www.dataaccess.com/webservicesserver/NumberToWords")
            .POST(HttpRequest.BodyPublishers.ofString(xml))
            .build();

        HttpResponse<String> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofString());
        Matcher m = Pattern.compile("<m:NumberToWordsResult>(.*?)</m:NumberToWordsResult>|<NumberToWordsResult>(.*?)</NumberToWordsResult>").matcher(response.body());
        if (m.find()) return (m.group(1) != null ? m.group(1) : m.group(2)).trim();
        return "Resultado no encontrado";
    }
}
