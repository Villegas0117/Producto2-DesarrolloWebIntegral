require "net/http"
require "uri"

def consultar_soap(n)
  uri = URI("https://www.dataaccess.com/webservicesserver/NumberConversion.wso")
  xml = <<~XML
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
          <ubiNum>#{n}</ubiNum>
        </NumberToWords>
      </soap:Body>
    </soap:Envelope>
  XML
  request = Net::HTTP::Post.new(uri)
  request["Content-Type"] = "text/xml; charset=utf-8"
  request["SOAPAction"] = "http://www.dataaccess.com/webservicesserver/NumberToWords"
  request.body = xml
  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(request) }
  match = response.body.match(/<m:NumberToWordsResult>(.*?)<\/m:NumberToWordsResult>|<NumberToWordsResult>(.*?)<\/NumberToWordsResult>/)
  match ? (match[1] || match[2]).strip : "Resultado no encontrado"
end
