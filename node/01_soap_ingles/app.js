const express = require("express");
const { consultarSOAP } = require("./soapClient");
const app = express();
const PORT = 3001;

app.get("/", async (req, res) => {
    const n = Number(req.query.n);
    if (isNaN(n)) return res.type("text").send("Debes enviar un número. Ejemplo: http://localhost:3001/?n=10");
    try {
        const ingles = await consultarSOAP(n);
        res.type("text").send("SOAP inglés: " + ingles);
    } catch (e) {
        res.status(500).type("text").send("Error al consumir SOAP: " + e.message);
    }
});

app.listen(PORT, () => console.log("Servidor Node SOAP en inglés ejecutándose en http://localhost:" + PORT));
