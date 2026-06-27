use strict;
use warnings;
use IO::Socket::INET;
require "./spanish_number.pl";

my $port = 3023;
my $server = IO::Socket::INET->new(LocalPort => $port, Type => SOCK_STREAM, Reuse => 1, Listen => 10) or die "No se pudo iniciar el servidor\\n";
print "Servidor Perl local en español ejecutándose en http://localhost:3023\\n";

while (my $client = $server->accept()) {
    my $request = <$client>;
    my $n = "";
    if ($request =~ /GET \/\?n=(-?\d+)/) { $n = $1; }

    my $body;
    if ($n eq "") {
        $body = "Debes enviar un número. Ejemplo: http://localhost:3023/?n=10";
    } else {
        my $espanol = numero_a_espanol($n); $body = "Número: $n\nResultado local: $espanol";
    }

    print $client "HTTP/1.1 200 OK\\r\\n";
    print $client "Content-Type: text/plain; charset=utf-8\\r\\n";
    print $client "Content-Length: " . length($body) . "\\r\\n";
    print $client "\\r\\n";
    print $client $body;
    close($client);
}
