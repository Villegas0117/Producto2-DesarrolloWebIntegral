require "webrick"
require_relative "soap_client"
port = 3011
server = WEBrick::HTTPServer.new(Port: port)
server.mount_proc "/" do |req, res|
  n = req.query["n"]
  if n.nil? || n !~ /^-?\d+$/
    res.body = "Debes enviar un número. Ejemplo: http://localhost:3011/?n=10"
  else
    res.body = "SOAP inglés: #{consultar_soap(n.to_i)}"
  end
end
trap("INT") { server.shutdown }
puts "Servidor Ruby SOAP en inglés ejecutándose en http://localhost:3011"
server.start
