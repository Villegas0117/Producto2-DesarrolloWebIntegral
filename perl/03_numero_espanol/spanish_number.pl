sub numero_a_espanol {
    my ($n) = @_;
    my @u = qw(cero uno dos tres cuatro cinco seis siete ocho nueve);
    my %e = (10=>"diez",11=>"once",12=>"doce",13=>"trece",14=>"catorce",15=>"quince",16=>"dieciséis",17=>"diecisiete",18=>"dieciocho",19=>"diecinueve",20=>"veinte",21=>"veintiuno",22=>"veintidós",23=>"veintitrés",24=>"veinticuatro",25=>"veinticinco",26=>"veintiséis",27=>"veintisiete",28=>"veintiocho",29=>"veintinueve");
    my %d = (30=>"treinta",40=>"cuarenta",50=>"cincuenta",60=>"sesenta",70=>"setenta",80=>"ochenta",90=>"noventa");
    my %c = (100=>"cien",200=>"doscientos",300=>"trescientos",400=>"cuatrocientos",500=>"quinientos",600=>"seiscientos",700=>"setecientos",800=>"ochocientos",900=>"novecientos");
    return "menos " . numero_a_espanol(abs($n)) if $n < 0;
    return $u[$n] if $n < 10;
    return $e{$n} if $n <= 29;
    if ($n < 100) { my $dec = int($n/10)*10; my $uni = $n%10; return $uni == 0 ? $d{$dec} : "$d{$dec} y $u[$uni]"; }
    return "cien" if $n == 100;
    if ($n < 1000) { my $cen = int($n/100)*100; my $res = $n%100; my $base = $cen == 100 ? "ciento" : $c{$cen}; return $res == 0 ? $c{$cen} : "$base " . numero_a_espanol($res); }
    if ($n < 1000000) { my $miles = int($n/1000); my $resto = $n%1000; my $texto = $miles == 1 ? "mil" : numero_a_espanol($miles) . " mil"; return $resto == 0 ? $texto : "$texto " . numero_a_espanol($resto); }
    return "Número fuera de rango";
}
1;
