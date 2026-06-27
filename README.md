# Number Conversion Server Side

Proyecto académico con implementaciones en Ruby, Perl, Node.js, .NET 10, Golang, Java, C++ y Rust.

Cada lenguaje contiene tres versiones:

1. `01_soap_ingles`: aplicación web que consume el servicio SOAP público y muestra el resultado en inglés.
2. `02_soap_traducido`: aplicación web que consume el servicio SOAP público y muestra el resultado en inglés y en español.
3. `03_numero_espanol`: aplicación web que convierte localmente el número a letras en español.

Servicio SOAP utilizado:

```text
https://www.dataaccess.com/webservicesserver/NumberConversion.wso?WSDL
```

El número se recibe desde la URL mediante el parámetro `n`.

Ejemplo:

```text
http://localhost:3001/?n=10
```

## Nota

Las versiones traducidas usan una librería local incluida dentro de cada lenguaje para generar la equivalencia en español del número recibido. Esto permite que el proyecto sea fácil de probar sin depender de servicios externos de traducción.
