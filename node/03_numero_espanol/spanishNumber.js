function numeroAEspanol(n) {
    const u = ["cero","uno","dos","tres","cuatro","cinco","seis","siete","ocho","nueve"];
    const e = {10:"diez",11:"once",12:"doce",13:"trece",14:"catorce",15:"quince",16:"dieciséis",17:"diecisiete",18:"dieciocho",19:"diecinueve",20:"veinte",21:"veintiuno",22:"veintidós",23:"veintitrés",24:"veinticuatro",25:"veinticinco",26:"veintiséis",27:"veintisiete",28:"veintiocho",29:"veintinueve"};
    const d = {30:"treinta",40:"cuarenta",50:"cincuenta",60:"sesenta",70:"setenta",80:"ochenta",90:"noventa"};
    const c = {100:"cien",200:"doscientos",300:"trescientos",400:"cuatrocientos",500:"quinientos",600:"seiscientos",700:"setecientos",800:"ochocientos",900:"novecientos"};
    if (n < 0) return "menos " + numeroAEspanol(Math.abs(n));
    if (n < 10) return u[n];
    if (n <= 29) return e[n];
    if (n < 100) { const dec = Math.floor(n/10)*10, uni = n%10; return uni === 0 ? d[dec] : d[dec] + " y " + u[uni]; }
    if (n === 100) return "cien";
    if (n < 1000) { const cen = Math.floor(n/100)*100, res = n%100; const base = cen === 100 ? "ciento" : c[cen]; return res === 0 ? c[cen] : base + " " + numeroAEspanol(res); }
    if (n < 1000000) { const miles = Math.floor(n/1000), resto = n%1000; const texto = miles === 1 ? "mil" : numeroAEspanol(miles) + " mil"; return resto === 0 ? texto : texto + " " + numeroAEspanol(resto); }
    return "Número fuera de rango";
}
module.exports = { numeroAEspanol };
