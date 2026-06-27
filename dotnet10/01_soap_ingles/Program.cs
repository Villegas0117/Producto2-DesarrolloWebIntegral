var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", async (HttpContext context) =>
{
    var nText = context.Request.Query["n"].ToString();
    if (!int.TryParse(nText, out int n)) return Results.Text("Debes enviar un número. Ejemplo: http://localhost:3031/?n=10");
    var ingles = await SoapClientNumber.ConsultarSOAP(n);
    return Results.Text("SOAP inglés: " + ingles);
});

Console.WriteLine("Servidor .NET 10 SOAP en inglés ejecutándose en http://localhost:3031");
app.Run("http://localhost:3031");
