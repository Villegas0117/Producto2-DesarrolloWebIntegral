const axios = require("axios");

async function consultarSOAP(n) {
    const xml = `<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
      <ubiNum>${n}</ubiNum>
    </NumberToWords>
  </soap:Body>
</soap:Envelope>`;

    const response = await axios.post(
        "https://www.dataaccess.com/webservicesserver/NumberConversion.wso",
        xml,
        { headers: { "Content-Type": "text/xml; charset=utf-8", "SOAPAction": "http://www.dataaccess.com/webservicesserver/NumberToWords" } }
    );

    const match = response.data.match(/<m:NumberToWordsResult>(.*?)<\/m:NumberToWordsResult>|<NumberToWordsResult>(.*?)<\/NumberToWordsResult>/);
    return match ? (match[1] || match[2]).trim() : "Resultado no encontrado";
}
module.exports = { consultarSOAP };
