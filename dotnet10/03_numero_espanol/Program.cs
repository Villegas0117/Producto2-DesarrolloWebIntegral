var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", (HttpContext context) =>
{
    var nText = context.Request.Query["n"].ToString();
    if (!int.TryParse(nText, out int n)) return Results.Text("Debes enviar un número. Ejemplo: http://localhost:3033/?n=10");
    return Results.Text($"Número: {n}\nResultado local: {SpanishNumber.NumeroAEspanol(n)}");
});

Console.WriteLine("Servidor .NET 10 local en español ejecutándose en http://localhost:3033");
app.Run("http://localhost:3033");
