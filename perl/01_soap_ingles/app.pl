use strict;
use warnings;
use IO::Socket::INET;
require "./soap_client.pl";

my $port = 3021;
my $server = IO::Socket::INET->new(LocalPort => $port, Type => SOCK_STREAM, Reuse => 1, Listen => 10) or die "No se pudo iniciar el servidor\\n";
print "Servidor Perl SOAP en inglés ejecutándose en http://localhost:3021\\n";

while (my $client = $server->accept()) {
    my $request = <$client>;
    my $n = "";
    if ($request =~ /GET \/\?n=(-?\d+)/) { $n = $1; }

    my $body;
    if ($n eq "") {
        $body = "Debes enviar un número. Ejemplo: http://localhost:3021/?n=10";
    } else {
        my $ingles = consultar_soap($n); $body = "SOAP inglés: $ingles";
    }

    print $client "HTTP/1.1 200 OK\\r\\n";
    print $client "Content-Type: text/plain; charset=utf-8\\r\\n";
    print $client "Content-Length: " . length($body) . "\\r\\n";
    print $client "\\r\\n";
    print $client $body;
    close($client);
}
