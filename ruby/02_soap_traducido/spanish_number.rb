def numero_a_espanol(n)
  unidades = %w[cero uno dos tres cuatro cinco seis siete ocho nueve]
  especiales = {10=>"diez",11=>"once",12=>"doce",13=>"trece",14=>"catorce",15=>"quince",16=>"dieciséis",17=>"diecisiete",18=>"dieciocho",19=>"diecinueve",20=>"veinte",21=>"veintiuno",22=>"veintidós",23=>"veintitrés",24=>"veinticuatro",25=>"veinticinco",26=>"veintiséis",27=>"veintisiete",28=>"veintiocho",29=>"veintinueve"}
  decenas = {30=>"treinta",40=>"cuarenta",50=>"cincuenta",60=>"sesenta",70=>"setenta",80=>"ochenta",90=>"noventa"}
  centenas = {100=>"cien",200=>"doscientos",300=>"trescientos",400=>"cuatrocientos",500=>"quinientos",600=>"seiscientos",700=>"setecientos",800=>"ochocientos",900=>"novecientos"}
  return "menos #{numero_a_espanol(n.abs)}" if n < 0
  return unidades[n] if n < 10
  return especiales[n] if n <= 29
  if n < 100
    d = (n / 10) * 10
    u = n % 10
    return u == 0 ? decenas[d] : "#{decenas[d]} y #{unidades[u]}"
  end
  return "cien" if n == 100
  if n < 1000
    c = (n / 100) * 100
    r = n % 100
    base = c == 100 ? "ciento" : centenas[c]
    return r == 0 ? centenas[c] : "#{base} #{numero_a_espanol(r)}"
  end
  if n < 1_000_000
    miles = n / 1000
    resto = n % 1000
    texto = miles == 1 ? "mil" : "#{numero_a_espanol(miles)} mil"
    return resto == 0 ? texto : "#{texto} #{numero_a_espanol(resto)}"
  end
  "Número fuera de rango"
end
