public static class SpanishNumber
{
    public static string NumeroAEspanol(int n)
    {
        string[] u = {"cero","uno","dos","tres","cuatro","cinco","seis","siete","ocho","nueve"};
        var e = new Dictionary<int,string>{{10,"diez"},{11,"once"},{12,"doce"},{13,"trece"},{14,"catorce"},{15,"quince"},{16,"dieciséis"},{17,"diecisiete"},{18,"dieciocho"},{19,"diecinueve"},{20,"veinte"},{21,"veintiuno"},{22,"veintidós"},{23,"veintitrés"},{24,"veinticuatro"},{25,"veinticinco"},{26,"veintiséis"},{27,"veintisiete"},{28,"veintiocho"},{29,"veintinueve"}};
        var d = new Dictionary<int,string>{{30,"treinta"},{40,"cuarenta"},{50,"cincuenta"},{60,"sesenta"},{70,"setenta"},{80,"ochenta"},{90,"noventa"}};
        var c = new Dictionary<int,string>{{100,"cien"},{200,"doscientos"},{300,"trescientos"},{400,"cuatrocientos"},{500,"quinientos"},{600,"seiscientos"},{700,"setecientos"},{800,"ochocientos"},{900,"novecientos"}};
        if (n < 0) return "menos " + NumeroAEspanol(Math.Abs(n));
        if (n < 10) return u[n];
        if (n <= 29) return e[n];
        if (n < 100) { int dec = n / 10 * 10; int uni = n % 10; return uni == 0 ? d[dec] : $"{d[dec]} y {u[uni]}"; }
        if (n == 100) return "cien";
        if (n < 1000) { int cen = n / 100 * 100; int res = n % 100; string baseTexto = cen == 100 ? "ciento" : c[cen]; return res == 0 ? c[cen] : $"{baseTexto} {NumeroAEspanol(res)}"; }
        if (n < 1000000) { int miles = n / 1000; int resto = n % 1000; string texto = miles == 1 ? "mil" : NumeroAEspanol(miles) + " mil"; return resto == 0 ? texto : texto + " " + NumeroAEspanol(resto); }
        return "Número fuera de rango";
    }
}
