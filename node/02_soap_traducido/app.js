const express = require("express");
const { consultarSOAP } = require("./soapClient");
const { numeroAEspanol } = require("./spanishNumber");
const app = express();
const PORT = 3002;

app.get("/", async (req, res) => {
    const n = Number(req.query.n);
    if (isNaN(n)) return res.type("text").send("Debes enviar un número. Ejemplo: http://localhost:3002/?n=10");
    try {
        const ingles = await consultarSOAP(n);
        const espanol = numeroAEspanol(n);
        res.type("text").send("SOAP inglés: " + ingles + "\nTraducción al español: " + espanol);
    } catch (e) {
        res.status(500).type("text").send("Error: " + e.message);
    }
});

app.listen(PORT, () => console.log("Servidor Node SOAP traducido ejecutándose en http://localhost:" + PORT));
