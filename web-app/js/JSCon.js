/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
  
function clic(){
    alert("aesfsd");
}

function valor(idrol){
    var flag = false;
    if(idrol == 1){
        flag = true;    
    }
    return flag;    
}

function fields(na,ma,pas,org,pues,us){
    var flag = false;
    if(na != "" && ma != "" && pas != "" & org != "" && pues != "" && us != ""){
        flag = true;
    }
    return flag;
}

function verificarcorr(correo){
    var email = /[\w-\.]{3,}@([\w-]{2,}\.)*([\w-]{2,}\.)[\w]{2,4}$/;
    return email.test(correo);
}

function enter(e){ 
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "áéíóú´abcdefghijklmnñopqrstuvwxyz1234567890!#$%&/()=?¡'¿°|¬@.,;:-_{}[]+*~<>/";
    especiales = [32,130,160,164,165,239,8,9];
    tecla_especial = false;
    for(var i in especiales){
        if(key == especiales[i]){
            tecla_especial = true;
            break;
        }
    }
    
    if(letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
}

function let3(e){
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "abcdefghijklmnñopqrstuvwxyz1234567890!#$%&/()=?'¡¿|°¬.:,;-_{}[]¨~+*<>@";
    especiales = [32,130,160,164,165,239,8,9];
    tecla_especial = false;
    for(var i in especiales){
        if(key == especiales[i]){
            tecla_especial = true;
            break;
        }
    }
}

function let2(e){
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "áéíóú´abcdefghijklmnñopqrstuvwxyz1234567890";
    especiales = [32,130,160,164,165,239,8,9];
    tecla_especial = false;
    for(var i in especiales){
        if(key == especiales[i]){
            tecla_especial = true;
            break;
        }
    }
}

function let(e){
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = "áéíóú´abcdefghijklmnñopqrstuvwxyz";
    especiales = [32,130,160,164,165,239,8,9];
    tecla_especial = false;
    for(var i in especiales){
        if(key == especiales[i]){
            tecla_especial = true;
            break;
        }
    }
    
    if(letras.indexOf(tecla) == -1 && !tecla_especial)
        return false;
}

function soloLetras(e, obj){
       
    var verif = obj.value;
    verif = verif.replace(/ /g,"");
    if(verif == "")
    {
        obj.value="";
    }
       
    key = e.keyCode || e.which;
    tecla = String.fromCharCode(key).toLowerCase();
    letras = " áéíóúabcdefghijklmnñopqrstuvwxyz1234567890'";
    especiales = [8,40,41,45,46,9];

    tecla_especial = false
    for(var i in especiales){
        if(key == especiales[i]){
            tecla_especial = true;
            break;
        } 
    }
    
    
    if(letras.indexOf(tecla)==-1 && !tecla_especial)
        return false;
    
}

function descipcion(numero){
    
    if(document.getElementById(numero).value == " "){
        
}
}


function asignar(numero){
    
    document.getElementById("idEliminar").value = numero;
}

function cancelarM(numero){
    
    document.getElementById("id").value = numero;
  
}

//function asignar(numero){
//    
//   document.getElementById("hidecontador").value = numero;
//   var x = document.getElementById("hidecontador").value;
//
//}