require "webrick"
require_relative "spanish_number"
port = 3013
server = WEBrick::HTTPServer.new(Port: port)
server.mount_proc "/" do |req, res|
  n = req.query["n"]
  if n.nil? || n !~ /^-?\d+$/
    res.body = "Debes enviar un número. Ejemplo: http://localhost:3013/?n=10"
  else
    numero = n.to_i
    res.body = "Número: #{numero}\nResultado local: #{numero_a_espanol(numero)}"
  end
end
trap("INT") { server.shutdown }
puts "Servidor Ruby local en español ejecutándose en http://localhost:3013"
server.start
