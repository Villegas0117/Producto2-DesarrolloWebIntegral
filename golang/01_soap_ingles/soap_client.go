package main

import (
    "bytes"
    "fmt"
    "io"
    "net/http"
    "regexp"
    "strings"
)

func consultarSOAP(n int) (string, error) {
    xml := fmt.Sprintf(`<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <NumberToWords xmlns="http://www.dataaccess.com/webservicesserver/">
      <ubiNum>%d</ubiNum>
    </NumberToWords>
  </soap:Body>
</soap:Envelope>`, n)

    req, err := http.NewRequest("POST", "https://www.dataaccess.com/webservicesserver/NumberConversion.wso", bytes.NewBufferString(xml))
    if err != nil { return "", err }
    req.Header.Set("Content-Type", "text/xml; charset=utf-8")
    req.Header.Set("SOAPAction", "http://www.dataaccess.com/webservicesserver/NumberToWords")

    resp, err := http.DefaultClient.Do(req)
    if err != nil { return "", err }
    defer resp.Body.Close()

    body, _ := io.ReadAll(resp.Body)
    re := regexp.MustCompile(`<m:NumberToWordsResult>(.*?)</m:NumberToWordsResult>|<NumberToWordsResult>(.*?)</NumberToWordsResult>`)
    match := re.FindStringSubmatch(string(body))
    if len(match) >= 3 {
        if match[1] != "" { return strings.TrimSpace(match[1]), nil }
        return strings.TrimSpace(match[2]), nil
    }
    return "Resultado no encontrado", nil
}
