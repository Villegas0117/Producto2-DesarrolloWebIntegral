import java.util.Map;

public class SpanishNumber {
    public static String numeroAEspanol(int n) {
        String[] u = {"cero","uno","dos","tres","cuatro","cinco","seis","siete","ocho","nueve"};
        Map<Integer,String> e = Map.ofEntries(Map.entry(10,"diez"),Map.entry(11,"once"),Map.entry(12,"doce"),Map.entry(13,"trece"),Map.entry(14,"catorce"),Map.entry(15,"quince"),Map.entry(16,"dieciséis"),Map.entry(17,"diecisiete"),Map.entry(18,"dieciocho"),Map.entry(19,"diecinueve"),Map.entry(20,"veinte"),Map.entry(21,"veintiuno"),Map.entry(22,"veintidós"),Map.entry(23,"veintitrés"),Map.entry(24,"veinticuatro"),Map.entry(25,"veinticinco"),Map.entry(26,"veintiséis"),Map.entry(27,"veintisiete"),Map.entry(28,"veintiocho"),Map.entry(29,"veintinueve"));
        Map<Integer,String> d = Map.of(30,"treinta",40,"cuarenta",50,"cincuenta",60,"sesenta",70,"setenta",80,"ochenta",90,"noventa");
        Map<Integer,String> c = Map.of(100,"cien",200,"doscientos",300,"trescientos",400,"cuatrocientos",500,"quinientos",600,"seiscientos",700,"setecientos",800,"ochocientos",900,"novecientos");
        if (n < 0) return "menos " + numeroAEspanol(Math.abs(n));
        if (n < 10) return u[n];
        if (n <= 29) return e.get(n);
        if (n < 100) { int dec = n/10*10, uni = n%10; return uni == 0 ? d.get(dec) : d.get(dec) + " y " + u[uni]; }
        if (n == 100) return "cien";
        if (n < 1000) { int cen = n/100*100, res = n%100; String base = cen == 100 ? "ciento" : c.get(cen); return res == 0 ? c.get(cen) : base + " " + numeroAEspanol(res); }
        if (n < 1000000) { int miles = n/1000, resto = n%1000; String texto = miles == 1 ? "mil" : numeroAEspanol(miles) + " mil"; return resto == 0 ? texto : texto + " " + numeroAEspanol(resto); }
        return "Número fuera de rango";
    }
}
