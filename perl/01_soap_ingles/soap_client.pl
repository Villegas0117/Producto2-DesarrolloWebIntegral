use HTTP::Tiny;

sub consultar_soap {
    my ($n) = @_;
    my $xml = <<"XML";
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
      <ubiNum>$n</ubiNum>
    </NumberToWords>
  </soap:Body>
</soap:Envelope>
XML
    my $http = HTTP::Tiny->new();
    my $response = $http->post("https://www.dataaccess.com/webservicesserver/NumberConversion.wso", {
        headers => {"Content-Type" => "text/xml; charset=utf-8", "SOAPAction" => "http://www.dataaccess.com/webservicesserver/NumberToWords"},
        content => $xml
    });
    my $body = $response->{content};
    if ($body =~ /<m:NumberToWordsResult>(.*?)<\/m:NumberToWordsResult>|<NumberToWordsResult>(.*?)<\/NumberToWordsResult>/) {
        return defined $1 ? $1 : $2;
    }
    return "Resultado no encontrado";
}
1;
