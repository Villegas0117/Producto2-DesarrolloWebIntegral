pub fn numero_a_espanol(n: i32) -> String {
    let u = ["cero","uno","dos","tres","cuatro","cinco","seis","siete","ocho","nueve"];
    if n < 0 { return format!("menos {}", numero_a_espanol(-n)); }
    if n < 10 { return u[n as usize].to_string(); }
    let e = [(10,"diez"),(11,"once"),(12,"doce"),(13,"trece"),(14,"catorce"),(15,"quince"),(16,"dieciséis"),(17,"diecisiete"),(18,"dieciocho"),(19,"diecinueve"),(20,"veinte"),(21,"veintiuno"),(22,"veintidós"),(23,"veintitrés"),(24,"veinticuatro"),(25,"veinticinco"),(26,"veintiséis"),(27,"veintisiete"),(28,"veintiocho"),(29,"veintinueve")];
    for (k,v) in e { if n == k { return v.to_string(); } }
    let d = [(30,"treinta"),(40,"cuarenta"),(50,"cincuenta"),(60,"sesenta"),(70,"setenta"),(80,"ochenta"),(90,"noventa")];
    if n < 100 {
        let dec = n / 10 * 10;
        let uni = n % 10;
        let texto = d.iter().find(|x| x.0 == dec).unwrap().1;
        if uni == 0 { return texto.to_string(); }
        return format!("{} y {}", texto, u[uni as usize]);
    }
    let c = [(100,"cien"),(200,"doscientos"),(300,"trescientos"),(400,"cuatrocientos"),(500,"quinientos"),(600,"seiscientos"),(700,"setecientos"),(800,"ochocientos"),(900,"novecientos")];
    if n == 100 { return "cien".to_string(); }
    if n < 1000 {
        let cen = n / 100 * 100;
        let res = n % 100;
        let texto = if cen == 100 { "ciento" } else { c.iter().find(|x| x.0 == cen).unwrap().1 };
        if res == 0 { return c.iter().find(|x| x.0 == cen).unwrap().1.to_string(); }
        return format!("{} {}", texto, numero_a_espanol(res));
    }
    if n < 1000000 {
        let miles = n / 1000;
        let resto = n % 1000;
        let texto = if miles == 1 { "mil".to_string() } else { format!("{} mil", numero_a_espanol(miles)) };
        if resto == 0 { return texto; }
        return format!("{} {}", texto, numero_a_espanol(resto));
    }
    "Número fuera de rango".to_string()
}
