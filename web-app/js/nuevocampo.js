function horaFechaInicio(){       
   //Función desabilitada dado que el campo se llenará manualmente
   /* var i=new Date();
                     
    hora=i.getHours();
    minuto=i.getMinutes();
    dia=i.getDate();
    mes=i.getMonth()+1;
    ano=i.getFullYear();
           
    if(minuto<=9){
        minuto="0"+minuto;
    }else
             
    if(hora<=9){
        hora="0"+hora;
    }
   
    document.fm.horaInicio.value=hora+":"+minuto;
    document.fm.fechaI.value=dia+"/"+mes+"/"+ano;   
   */ 
    document.fm.estadoMinuta.value = "Iniciada";
    document.getElementById('finalizarMinuta').disabled=false;
    document.getElementById('finalizarMinuta').style.display = 'inline';
    document.getElementById('inicioMinuta').disabled=true;   
    document.getElementById('inicioMinuta').style.display = "none"
   
}
    
function horaFechaFin(){
    //Función desabilitada dado que el campo se llenará manualmente
    /*        
    var f=new Date();
           
    hora=f.getHours();
    minuto=f.getMinutes();
    dia=f.getDate();
    mes=f.getMonth()+1;
    ano=f.getFullYear();
           
    if(minuto<=9){
        minuto="0"+minuto;
    }else
             
    if(hora<=9){
        hora="0"+hora;
    }
    if(dia<=9){
        dia="0"+dia;
    }
    if(mes<=9){
        mes="0"+mes;
    }
  
    document.fm.horaFin.value=hora+":"+minuto;
    document.fm.fechaF.value=dia+"/"+mes+"/"+ano;  
 
    */            
    
    document.fm.estadoMinuta.value = "Prefinalizada";
}  
/*=========Fin el código Javascript=================================== */ 
     
     
     
/*=============Inicio de JavaScript AgregarCampos Acuerdos=============*/
 
/* ============== FancyBox ======================= */ 
$(document).ready(function() {
     
    if ( $.browser.mozilla == true) {
        $("#correo").fancybox({
            type:'iframe',
            'minWidth':925,
            'minHeight':430
        });
        
        document.getElementById("objetivo").cols = 72;
        document.getElementById("tipoReunion").style.width = "165px";
        
    }else if(navigator.userAgent.toLowerCase().indexOf('chrome') > -1){
        $("#correo").fancybox({
            type:'iframe',
            'width':925,
            'height':400
        });
        document.getElementById("objetivo").cols = 81;
        
    } 
    else
    {
        
        $("#correo").fancybox({
            type:'iframe',
            'width':925,
            'height':400
        });
    }
});

/* ============== DatePicker ================== */ 
$(function(){
    $('.form-gerados').delegate('.campofecha','mouseenter',function(){
       
        $(this).datepicker({
            //showOn: 'both',
            //buttonImage: '/ControlDeReuniones/images/imagenesMinuta/ca.png',                     
            //buttonImageOnly: true,
            changeYear: true,
            numberOfMonths: 1,
            changeMonth: true,
            yearRange: '-90 :+100'
        });
        

    });
});

/* ============== MultiSelect Acuerdo ================== */ 
$(function(){
    $('.form-gerados').delegate('.seleccionarAcuerdo','focusin',function(){
        $(this).multiselect();  
        $(".selectDinamicos").multiselect({
            multiple:false,
            selectedList:1
        });
    });
});


   
/* ============== Fin MultiSelect Acuerdo ================== */ 

/* ========================================================= */ 
$(function(){
    
 
    $('.campofecha').datepicker({
        //showOn: 'both',
        //buttonImage: '/ControlDeReuniones/images/imagenesMinuta/ca.png',
        //buttonImageOnly: true,
        changeYear: true,
        numberOfMonths: 1,
        changeMonth: true,
        yearRange: '-90 :+100'
    });
});


function contar(obj){
    var numSeleccionarAcuerdo = "num"+obj.id;
    num=0;
    for(i=0; opt=obj.options[i]; i++)
        if(opt.selected) num++;
    document.getElementById(numSeleccionarAcuerdo).value = num;
}


function contarnumac(obj){
    var numSeleccionarAcuerdo = "num"+obj.id;
    num=0;
    for(i=0; opt=obj.options[i]; i++)
        if(opt.selected) num++;
    document.getElementById(numSeleccionarAcuerdo).value = num;
}

var posicionCampoAcuerdo=1;

function contadorAcuerdo(posicionCampoA)
{
    posicionCampoAcuerdo=posicionCampoA+1; 
}

function agregarCamposAcuerdos(){

    posicionCampoAcuerdo++;
    nuevaFila = document.getElementById("tablaAcuerdo").insertRow(-1);
    nuevaFila.id = posicionCampoAcuerdo;
    nuevaFila.className = "trAux";

    nuevaCelda = nuevaFila.insertCell(-1);
    nuevaCelda.className = "tdDatos";
    nuevaCelda.innerHTML = "<td><textarea onKeyUp='limpiarvacios(this)' onChange='limpiarvacios(this)' rows='3' cols='52' maxlength='950'  id='descripcion_"+posicionCampoAcuerdo+"' name='descripcionAcuerdo' ></textarea></td>";
    nuevaCelda = nuevaFila.insertCell(-1);
    nuevaCelda.className = "tdDatos";
    
    var campoAcuerdo = document.getElementById("seleccionarAcuerd").cloneNode(true);  
    
    campoAcuerdo.style.display = 'inline';
    campoAcuerdo.className = campoAcuerdo.id+"o"
    campoAcuerdo.id = campoAcuerdo.id+"o_"+posicionCampoAcuerdo;
    
    nuevaCelda.appendChild(campoAcuerdo);
    
    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    
    var fecha=new Date();
           
    
    dia=fecha.getDate();
    mes=fecha.getMonth()+1;
    ano=fecha.getFullYear();
           
    if(dia<=9){
        dia="0"+dia;
    }
    if(mes<=9){
        mes="0"+mes;
    }
    
    nuevaCelda.innerHTML="<input type='hidden' id='numseleccionarAcuerdo_"+posicionCampoAcuerdo+"' name='numUsuarioAcuerdo' value='0'><td align='center'><input type=´'text' size='10' name='fechaCompromiso' class='campofecha' value='"+dia+"/"+mes+"/"+ano+"' id='fecha_"+posicionCampoAcuerdo+"' readonly='readonly'/></td>";
    
    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";

    nuevaCelda.innerHTML = "<td> <select class='selectDinamicos'  id='estado_"+posicionCampoAcuerdo+"' name='estado' >\n\
                            <option value='Pendiente'>Pendiente</option>\n\
                            <option value='Parcial'>Parcial</option>\n\
                            <option value='Realizado'>Realizado</option>\n\
                            <option value='Delegado'>Delegado</option>\n\
                            <option value='Cancelado'>Cancelado</option>\n\
                            </select></td>";
    document.getElementById(campoAcuerdo.id).focus();

    
    
    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    nuevaCelda.innerHTML="<td><a href='#'><img src='/ControlDeReuniones/images/general/limpiar.png' id='"+posicionCampoAcuerdo+"' onclick='limpiar(id)' width='30'/></a></td>";


    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    nuevaCelda.innerHTML="<td><a onclick='eliminarUsuario(this)' href='#'><image src='/ControlDeReuniones/images/general/eliminar.png' width='30px' /></a></td>";
    document.getElementById("descripcion_"+posicionCampoAcuerdo).focus();
}


function limpiar(value){
    var descripcion = "descripcion_"+value;
    document.getElementById(descripcion).value = "";
    document.getElementById(descripcion).focus();
}

function eliminarUsuario(obj){

    var oTr = obj;

    while(oTr.nodeName.toLowerCase()!='tr'){

        oTr=oTr.parentNode;

    }

    var root = oTr.parentNode;

    root.removeChild(oTr);

}

/*=========Fin el código Javascript=================================== */ 

 
 
/*=========Inicio de JavaScript AgregarCampos Puntos a Tratar===========*/
 
var posicionCampoPuntos=2;

function contadorPunto(posicionCampo)
{
    posicionCampoPuntos=posicionCampo 
}

function agregarCamposPuntos(){

    posicionCampoPuntos++;
    nuevaFila = document.getElementById("tablaPuntos").insertRow(-1);

    nuevaFila.id=posicionCampoPuntos;
    nuevaFila.className="trAux";

    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";

    nuevaCelda.innerHTML="<td><textarea onKeyUp='limpiarvacios(this)' onChange='limpiarvacios(this)' rows='2' cols='79' maxlength='950'  id='pTratar_"+posicionCampoPuntos+"' name='pTratar'></textarea></td>";
    document.getElementById("pTratar_"+posicionCampoPuntos).focus();
    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    nuevaCelda.innerHTML="<td><a href='#'><img src='/ControlDeReuniones/images/general/limpiar.png' id='"+posicionCampoPuntos+"' onclick='limpiarPuntos(id)' width='30px'/></a></td>";


    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    nuevaCelda.innerHTML="<td><a onclick='eliminarPuntos(this)' href='#'><image src='/ControlDeReuniones/images/general/eliminar.png' width='30px' /></a></td>";

}

function limpiarPuntos(value){
    var pTratar = "pTratar_"+value;
  
    document.getElementById(pTratar).value = "";
    document.getElementById(pTratar).focus();
 
}

function eliminarPuntos(obj){

    var oTr = obj;

    while(oTr.nodeName.toLowerCase()!='tr'){

        oTr=oTr.parentNode;

    }

    var root = oTr.parentNode;

    root.removeChild(oTr);

}

/*=========Fin el código Javascript=================================== */ 




/*========Inicio de JavaScript AgregarCampos Participantes============*/

var posicionCampo=1;

$(function(){
    $('.tablaPart').delegate('.selectPartEstaticos','focusin',function(){
        $('.selectPartEstaticos').multiselect({
            multiple:false,
            selectedList:1
        }).multiselectfilter({
            label:"Buscar :",
            placeholder:""
        });   
    });
});

function agregarCamposParticipantes(){

    nuevaFila = document.getElementById("tablaParticipante").insertRow(-1);
    nuevaFila.id=posicionCampo;
    nuevaFila.className="trAux";
 
    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    var campo = document.getElementById("selecciona").cloneNode(true);
    campo.id = 'seleccionar_'+posicionCampo;
    campo.name= campo.name+"o"
    campo.style.display = 'inline';
    campo.className = "selectPartEstaticos"
    nuevaCelda.appendChild(campo);
    document.getElementById("seleccionar_"+posicionCampo).style.display = "inline";
    document.getElementById(campo.id).focus();
    //    nuevaCelda.innerHTML="<td><input type='text' size='20'  id='responsable_"+posicionCampoAcuerdo+"' name='usuario'></td>";

    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    nuevaCelda.innerHTML="<td><a onclick='eliminarParticipante(this)' href='#'><image src='/ControlDeReuniones/images/general/eliminar.png' width='30px' /></a></td>";
    posicionCampo++
    

}



function eliminarParticipante(obj){

    var oTr = obj;

    while(oTr.nodeName.toLowerCase()!='tr'){

        oTr=oTr.parentNode;

    }

    var root = oTr.parentNode;

    root.removeChild(oTr);

}

/*=========Fin el código Javascript=================================== */


/*========Inicio de JavaScript AgregarCampos Externo============*/

var posicionCampoExt=1;



function agregarCamposExterno(){

    nuevaFila = document.getElementById("tablaExterno").insertRow(-1);

    nuevaFila.id=posicionCampo;
    nuevaFila.className="trAux";    
    
    
    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    nuevaCelda.innerHTML="<td><input onKeyUp='limpiarvacios(this)' onChange='limpiarvacios(this)' type='text' size='20'  id='nombreExterno_"+posicionCampoAcuerdo+"' name='nombreExterno'></td>";
    
    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    nuevaCelda.innerHTML="<td><input onKeyUp='limpiarvacios(this),quitar(this)' onChange='limpiarvacios(this)' type='text' size='20'  id='emailExterno_"+posicionCampoAcuerdo+"' name='emailExterno'></td>";
    
    nuevaCelda=nuevaFila.insertCell(-1); 
    nuevaCelda.className="tdDatos";   
    nuevaCelda.innerHTML="<td><input onKeyUp='limpiarvacios(this)' onChange='limpiarvacios(this)' type='text' size='20'  id='organizacionExterno_"+posicionCampoAcuerdo+"' name='organizacionExterno'></td>";
    
    nuevaCelda=nuevaFila.insertCell(-1); 
    nuevaCelda.className="tdDatos";   
    nuevaCelda.innerHTML="<td><input onKeyUp='limpiarvacios(this)' onChange='limpiarvacios(this)' type='text' size='20'  id='puesto_"+posicionCampoAcuerdo+"' name='puesto'></td>";
   
    nuevaCelda=nuevaFila.insertCell(-1);
    nuevaCelda.className="tdDatos";
    nuevaCelda.innerHTML="<td><a onclick='eliminarParticipante(this)' href='#'><image src='/ControlDeReuniones/images/general/eliminar.png' width='30px' /></a></td>";
    posicionCampo++

}


function eliminarParticipante(obj){

    var oTr = obj;

    while(oTr.nodeName.toLowerCase()!='tr'){

        oTr=oTr.parentNode;

    }

    var root = oTr.parentNode;

    root.removeChild(oTr);

}

/*=========Fin el código Javascript=================================== */


/*=========Javascript formularioContinuar=================================== */

