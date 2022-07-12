const net = require('net')
require('buffer').Buffer

// const buf1 = Buffer.from('Ingrese numero:');
var client = new net.Socket();

client.connect(8093, '127.0.0.1', function () {
    console.log('Connected');
    client.write('Connected');
});


client.on('data', function (data) {
    console.log('Received: ' + data);
    process.stdout.write("Ingrese numero: ");
    
    process.stdin.on('data', (data) => {
        console.log(data.toString());
        
       
            switch (data.toString()) {
                case "1":
                    process.stdout.write(" Se genera un sonido de colgado, el telefono a central, Msg: Ha colgado");
                    break;
                case "2":
                    process.stdout.write("Se genera un sonido de llamada, la centralita a telefono, Msg: Hay una llamada entrante, sonido de llamada");
                    break;
                case "3":
                    process.stdout.write("La centralita a telefono, Msg: Hay señal, sonido de tono");
                    break;
                case "4":
                    process.stdout.write("Telefono a centralita, Msg: A marcado un numero y a colgado");
                    break;
                case "5":
                    process.stdout.write("Hay sonido de tono de llamada(pii-pii), La centralita debe comunicar al telefono, Msg: Sonido de tono de llamada propio");
                    break;
                case "6":
                    process.stdout.write("Esta hablando con la persona X, La centralita a Telefono, Msg, Conectado al otro extremo, sonido de hablar (Hablando)");
                    break;
                case "0":
                    process.stdout.write("Gracias!");
                    break;
                default:
                    process.stdout.write("0pción no valida");
                    break;
    
            }      
       
    })
});

// client.on('close', function () {
//     console.log('Connection closed');
// });