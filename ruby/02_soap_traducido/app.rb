require "webrick"
require_relative "soap_client"
require_relative "spanish_number"
port = 3012
server = WEBrick::HTTPServer.new(Port: port)
server.mount_proc "/" do |req, res|
  n = req.query["n"]
  if n.nil? || n !~ /^-?\d+$/
    res.body = "Debes enviar un número. Ejemplo: http://localhost:3012/?n=10"
  else
    numero = n.to_i
    res.body = "SOAP inglés: #{consultar_soap(numero)}\nTraducción al español: #{numero_a_espanol(numero)}"
  end
end
trap("INT") { server.shutdown }
puts "Servidor Ruby SOAP traducido ejecutándose en http://localhost:3012"
server.start
