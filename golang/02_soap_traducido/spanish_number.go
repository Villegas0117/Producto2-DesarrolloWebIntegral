package main

func numeroAEspanol(n int) string {
    u := []string{"cero","uno","dos","tres","cuatro","cinco","seis","siete","ocho","nueve"}
    e := map[int]string{10:"diez",11:"once",12:"doce",13:"trece",14:"catorce",15:"quince",16:"dieciséis",17:"diecisiete",18:"dieciocho",19:"diecinueve",20:"veinte",21:"veintiuno",22:"veintidós",23:"veintitrés",24:"veinticuatro",25:"veinticinco",26:"veintiséis",27:"veintisiete",28:"veintiocho",29:"veintinueve"}
    d := map[int]string{30:"treinta",40:"cuarenta",50:"cincuenta",60:"sesenta",70:"setenta",80:"ochenta",90:"noventa"}
    c := map[int]string{100:"cien",200:"doscientos",300:"trescientos",400:"cuatrocientos",500:"quinientos",600:"seiscientos",700:"setecientos",800:"ochocientos",900:"novecientos"}
    if n < 0 { return "menos " + numeroAEspanol(-n) }
    if n < 10 { return u[n] }
    if n <= 29 { return e[n] }
    if n < 100 { dec := n/10*10; uni := n%10; if uni == 0 { return d[dec] }; return d[dec] + " y " + u[uni] }
    if n == 100 { return "cien" }
    if n < 1000 { cen := n/100*100; res := n%100; base := c[cen]; if cen == 100 { base = "ciento" }; if res == 0 { return c[cen] }; return base + " " + numeroAEspanol(res) }
    if n < 1000000 { miles := n/1000; resto := n%1000; texto := "mil"; if miles > 1 { texto = numeroAEspanol(miles) + " mil" }; if resto == 0 { return texto }; return texto + " " + numeroAEspanol(resto) }
    return "Número fuera de rango"
}
