using System.Net;
using System.Text;
using System.Text.RegularExpressions;

public static class SoapClientNumber
{
    public static async Task<string> ConsultarSOAP(int n)
    {
        var xml = $@"<?xml version=""1.0"" encoding=""utf-8""?>
<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
  <soap:Body>
    <NumberToWords xmlns=""http://www.dataaccess.com/webservicesserver/"">
      <ubiNum>{n}</ubiNum>
    </NumberToWords>
  </soap:Body>
</soap:Envelope>";

        using var http = new HttpClient();
        var content = new StringContent(xml, Encoding.UTF8, "text/xml");
        content.Headers.Add("SOAPAction", "http://www.dataaccess.com/webservicesserver/NumberToWords");

        var response = await http.PostAsync("https://www.dataaccess.com/webservicesserver/NumberConversion.wso", content);
        var body = await response.Content.ReadAsStringAsync();

        var match = Regex.Match(body, @"<m:NumberToWordsResult>(.*?)</m:NumberToWordsResult>|<NumberToWordsResult>(.*?)</NumberToWordsResult>");
        var result = match.Groups[1].Success ? match.Groups[1].Value : match.Groups[2].Value;
        return WebUtility.HtmlDecode(result).Trim();
    }
}
