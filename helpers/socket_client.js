const net = require('net')
require('buffer').Buffer

const buf1 = Buffer.from('Ingrese numero:');

var client = new net.Socket();
client.connect(8080, '127.0.0.1', function() {
	console.log('Connected');
	client.write("registrar");
});

client.on('data', function(data) {
	console.log('Received: ' + data);
	if (data.equals(buf1)) {
		client.write("12345")
	}else{
	//client.destroy();
} // kill client after server's response
});

client.on('close', function() {
	console.log('Connection closed');
});