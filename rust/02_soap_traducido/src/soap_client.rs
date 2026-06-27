pub fn consultar_soap(n: i32) -> Result<String, Box<dyn std::error::Error>> {
    let xml = format!(r#"<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
      <ubiNum>{}</ubiNum>
    </NumberToWords>
  </soap:Body>
</soap:Envelope>"#, n);

    let body = reqwest::blocking::Client::new()
        .post("https://www.dataaccess.com/webservicesserver/NumberConversion.wso")
        .header("Content-Type", "text/xml; charset=utf-8")
        .header("SOAPAction", "http://www.dataaccess.com/webservicesserver/NumberToWords")
        .body(xml)
        .send()?
        .text()?;

    let re = regex::Regex::new(r"<m:NumberToWordsResult>(.*?)</m:NumberToWordsResult>|<NumberToWordsResult>(.*?)</NumberToWordsResult>")?;
    if let Some(caps) = re.captures(&body) {
        if let Some(m) = caps.get(1) { return Ok(m.as_str().trim().to_string()); }
        if let Some(m) = caps.get(2) { return Ok(m.as_str().trim().to_string()); }
    }
    Ok("Resultado no encontrado".to_string())
}
