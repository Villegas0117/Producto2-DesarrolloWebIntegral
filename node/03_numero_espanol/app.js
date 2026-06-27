const express = require("express");
const { numeroAEspanol } = require("./spanishNumber");
const app = express();
const PORT = 3003;

app.get("/", (req, res) => {
    const n = Number(req.query.n);
    if (isNaN(n)) return res.type("text").send("Debes enviar un número. Ejemplo: http://localhost:3003/?n=10");
    res.type("text").send("Número: " + n + "\nResultado local: " + numeroAEspanol(n));
});

app.listen(PORT, () => console.log("Servidor Node local en español ejecutándose en http://localhost:" + PORT));
