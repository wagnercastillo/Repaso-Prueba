// Colgado
// 1. Se genera un sonido de colgado, el telefono a central, Msg: Ha colgado
// 2. Se genera un sonido de llamada, la centralita a telefono, Msg: Hay una llamada entrante, sonido de llamada
// Descolgado
// 3. La centralita a telefono, Msg: Hay señal, sonido de tono
// 4. Telefono a centralita, Msg: A marcado un numero y a colgado
// 5. Hay sonido de tono de llamada(pii-pii), La centralita debe comunicar al telefono, Msg: Sonido de tono de llamada propio
// 6. Esta hablando con la persona X, La centralita a Telefono, Msg, Conectado al otro extremo, sonido de hablar (Hablando)

/* 
    Aqui necesito hacer uso del case del cliente 

    actions: {
        id, numero marcado
        Si es de Telefono a Centralita hay 2 casos:
            1. Espera lo suficiente por 10 segundos y se escucha sonido de colgado
            2. Se marca y luego cuelga el telefono 

        Cosas Adicionales: 
            1. En el telefono tiene que generarse la llamada mientras que otro recibir la llamada
                 y verse por pantalla
                }
    
    Case {
        Mandar la función a erlang mediante una coneción del socket con net probablemente


    }
    
*/


