var audio2 = new Audio('./audio/tecla2.mp3')
var audio1 = new Audio('./audio/tecla1.mp3')
var audio_espera = new Audio('./audio/marcando.mp3')
var t = document.getElementById("tel")
var t = document.getElementById("tel")
var tel = document.getElementById("tel")
var fun = document.getElementById("fun")
var llamando = document.getElementById("llamando")
var botones = document.getElementsByClassName("tecla")

const numero=(n)=>{
    var aux = t.getAttribute("value")
    t.setAttribute("value",aux+n)
    beep(n)
    console.log(t)
}
const borrar=()=>{
    var aux = t.getAttribute("value")
    var out = aux.replace(aux.charAt(aux.length-1),"")
    t.setAttribute("value",out)
    console.log(out)
}

const beep=(n)=>{
    var arr = "2580"
    if(arr.includes(n)){
        
        audio2.play()
        console.log("audio2")
    }else{
        
        audio1.play()
        console.log("audio1")
    }
}

const accion=()=>{
    //aca va la llamada
    console.log("llamando a: "+tel.getAttribute("value"))

    if(fun.getAttribute("value") == "espera"){
        fun.setAttribute("value","llamando")
        audio_espera.loop=true
        audio_espera.play()
        fun.style.backgroundColor = "red"
        fun.style.zIndex= 2;
        llamando.style.height = 330+"px"
        llamando.style.paddingTop = 20+"px"
        llamando.innerHTML = "Llamando..."
        botones.style.zIndex = "-"+1

    }else if(fun.getAttribute("value") == "llamando"){
        llamando.innerHTML = ""
        t.setAttribute("value","")
        fun.setAttribute("value","espera")
        audio_espera.loop=false
        fun.style.backgroundColor = "green"
        llamando.style.paddingTop = 0+"px"
        llamando.style.height = 0+"px";
        botones.style.zIndex = 0
    }
}