var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", async (HttpContext context) =>
{
    var nText = context.Request.Query["n"].ToString();
    if (!int.TryParse(nText, out int n)) return Results.Text("Debes enviar un número. Ejemplo: http://localhost:3032/?n=10");
    var ingles = await SoapClientNumber.ConsultarSOAP(n);
    var espanol = SpanishNumber.NumeroAEspanol(n);
    return Results.Text($"SOAP inglés: {ingles}\nTraducción al español: {espanol}");
});

Console.WriteLine("Servidor .NET 10 SOAP traducido ejecutándose en http://localhost:3032");
app.Run("http://localhost:3032");
