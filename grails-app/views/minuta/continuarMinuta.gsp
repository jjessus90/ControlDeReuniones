<!doctype html>
<%@ page import="ControlDeReuniones.Minuta" %>
<%@ page import = "LoginController" %>

<html>
  <sec:ifNotLoggedIn>
<%
LC = new LoginController()
LC.index()
%>
  </sec:ifNotLoggedIn>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Control De Reuniones</title>

    <style type="text/css">
      .validar { 
        border:1px solid red;
      }

    </style>




    <link rel="stylesheet" href="${resource(dir: 'css', file: 'sesion.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'pestanias.css')}" type="text/css">

    <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery-ui-1.8.21.custom.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery.fancybox.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery.multiselect.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery.multiselect.filter.css')}" type="text/css">
    <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery-1.7.2.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery-ui-1.8.21.custom.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.ui.datepicker-es.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.fancybox.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.multiselect.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.multiselect.filter.js')}"></script>
  <g:javascript src="nuevocampo.js"/>



  <script type="text/javascript">
  $(function(){
    $('.selectEstaticos').multiselect({
      multiple:false,
      selectedList:1
    });
    $('.selectFiltroEstatico').multiselect({
      multiple:false,
      selectedList:1
    }).multiselectfilter({
            label:"Buscar :",
            placeholder:""
        }); 
    $('.seleccionarAcuerdo').multiselect();
  });

jQuery(function(){

  //Cuando el sitio carga, aplica el siguiente proceso para las pestañas...
   if('${minutaInstance.estadoMinuta}' == 'Finalizada'){
     $(".tab_content").hide(); //Esconde todo el contenido
     $("ul.tabs li").removeClass("active");
     $("ul.tabs li:#four").addClass("active").show(); //Activa la primera tab
     $(".tab_content:#tab4").show(); //Muestra el contenido de la primera tab
    }
   else{
     $(".tab_content").hide(); //Esconde todo el contenido
     $("ul.tabs li").removeClass("active");
     $("ul.tabs li:first").addClass("active").show(); //Activa la primera tab
     $(".tab_content:first").show(); //Muestra el contenido de la primera tab
       
   }
       
     //On Click Event
     $("ul.tabs li").click(function() {
         $("ul.tabs li").removeClass("active"); //Elimina las clases activas
         $(this).addClass("active"); //Agrega la clase activa a la tab seleccionada
         $(".tab_content").hide(); //Esconde todo el contenido de la tab
         var activeTab = $(this).find("a").attr("href"); //Encuentra el valor del atributo href para identificar la tab activa + el contenido
         $(activeTab).fadeIn(); //Agrega efecto de transiciÃ³n (fade) en el contenido activo
         return false;
     });
   
//Fin de proceso de pestañas

});
 
function mostrarmont()
{
 document.getElementById('falso').style.display = 'block';  
}
 
function quitar(obj){
 document.getElementById(obj.id).className='vacioL';
}
 
function mont(){
 setTimeout("mostrarmont();",3000)
}
 
function cancelar(id){
          var elemento = document.getElementById(id);
          if(elemento.className == 'mostrar'){
            elemento.className = 'ocultar';
          }
      }   
function mostrar(id, numero){
        var elemento = document.getElementById(id);
        if(elemento.className == 'ocultar'){
          elemento.className = 'mostrar';
        }
        document.getElementById("id").value = numero;
            
    if(document.getElementById('flasM').style.display != 'none'){
    document.getElementById('flasM').style.display = 'none'    
  }
}
    
 function ocultar(){
        var elemento = document.getElementById('oc');
        if(elemento.className == 'mostrar'){
          elemento.className = 'ocultar';
        }
}    
    
 function principal(){
   x = document.getElementById('text').value;
       
   if(x == "Los cambios se realizaron correctamente."){
     document.getElementById('flasM').className = 'correcto';
   }else if(x== "Falta agregar acuerdos y puntos a tratar."){
     document.getElementById('flasM').className = 'informacion';
   }else if(x== "Ingrese el lugar en datos generales."){
     document.getElementById('flasM').className = 'error';
     document.getElementById('lugar1').className='validar';
   }else if(x== "Ingrese el objetivo en datos generales."){
     document.getElementById('flasM').className = 'error';
     document.getElementById('objetivo').className='validar';
   }else if(x== "Ingrese  puntos a tratar."){
     document.getElementById('flasM').className = 'error';
     document.getElementById('pTratar_1').className='validar';
   }else if(x== "Ingrese la descripción en acuerdos."){
     document.getElementById('flasM').className = 'error';
     document.getElementById('descripcion_1').className='validar';
   } else if(x == "Seleccione un responsable del acuerdo."){ 
     document.getElementById('flasM').className = 'error';
   }else if(x =="Por favor espere, su correo se esta enviando."){ 
     document.getElementById('flasM').className = 'informacion';
   }else if(x =="Se enviado un correo a todos los participantes con la información de la minuta."){ 
     document.getElementById('flasM').className = 'correcto';
   }else if(x =="Uno o varios participantes no pueden ser eliminados, porque estan asignados a un acuerdo."){ 
     document.getElementById('flasM').className = 'informacion';
   }else if(x =="El participante externo no pudo ser guardo, por que falto ingresar algunos campos o el correo era incorrecto."){ 
     document.getElementById('flasM').className = 'error';
   }else if(x =="Uno o varios acuerdos no tiene asignado un responsable."){ 
     document.getElementById('flasM').className = 'error';
   }else if(x =="La minuta no puede ser finalizado hasta que ingrese un acuerdo."){ 
     document.getElementById('flasM').className = 'error';
   }else if(x =="Mientras usted editaba, otro usuario ha actualizado su Minuta."){ 
     document.getElementById('flasM').className = 'error';
   }
   document.getElementById('oc').className = 'mostrar';
   setTimeout("ocultar();",5000);
 }
    
 function recargar(){
       
         location.reload(true);
 }
     
 window.onload = principal;
   
   
function ocultarColumna(num,ver) {
    dis= ver ? '' : 'none';
    fila=document.getElementById('tablaAcuerdo').getElementsByTagName('tr');
    for(i=0;i<fila.length;i++)
    fila[i].getElementsByTagName('td')[num].style.display=dis;
}
function limpiarvacios(obj){
   var verif = obj.value;
   verif = verif.replace(/ /g,"");
   if(verif == "")
     {
       obj.value="";
     }
 }
  
  </script>


</head>
<body>


  <div id="contenedorGral">

    <div id="banner">
    <div id="logoUtez"><img src="${resource(dir:'images/general',file:'Logo-Gubernatura.png')}" width="185px"/></div>
      <div id="titulo" style="color: white; font-weight: bold; font-size: 26px;">Control De Reuniones</div>
    </div>

    <div id="cuerpoPrincipal">

      <div id="subBanner">
        <table border="0" style="margin-left: auto; color:white; font-weight: bold; font-size: 12px;">
          <tr>
            <td style="padding-right:50px;"><b><sec:loggedInUserInfo field="username"/></b></td>

            <td style="padding-right:35px;"><a class="salir" href="${createLink(uri: '/')}">
                <img alt="" title="Menu" src="${resource(dir:'images/general',file:'homeCDR.png')}" width="16px" height="16px"/>
              </a></td>
            <td style="padding-right:60px;">
          <g:link controller="Logout">
            <img alt="" title="Cerrar sesión" src="${resource(dir:'images/general',file:'logOutCDR.png')}" width="16px" height="16px"/>
          </g:link>
          </td>
          </tr>
        </table> 
      </div>
      <h1 align="center">Registro de Minuta</h1>

      <div id="oc" class="ocultar">
        <g:if test="${flash.message}">
          <div id="flasM" class="correcto" role="status" style='background-color:white;'>
            <div style="max-width: 800px; margin: 0 auto;">${flash.message}
              <g:hiddenField id="text" name="text" value="${flash.message}"/></div>
          </div>
        </g:if>
      </div>

      <div style="background-color: white; width:95%; display:none  " id="falso" class="informacion" role="status">Por favor espere, su correo se esta enviando...</div>    

      <div class="ocultar" id="mensaje" >
        <div class='error' style='background-color:white;'>            
          <g:form>
            <fieldset class="button">¿Seguro que desea eliminar la minuta?
              <g:actionSubmit class="delete" action="eliminarMinuta" value="Confirmar" />  
              <g:hiddenField id="id" name="id" value=""/>
              <input type="button" value="Cancelar" class="cancel" onclick="cancelar('mensaje')"/></fieldset>
          </g:form>         
        </div>               
      </div>


      <g:hasErrors bean="${minutaInstance}">
        <ul class="error" style='background-color:white;' role="alert">
          <g:eachError bean="${minutaInstance}" var="error">
            <g:if test="${error in org.springframework.validation.FieldError}"></g:if><g:message error="${error}"/><script></script>
          </g:eachError>
        </ul>
      </g:hasErrors>


      <g:form name="fm"  action="save">

        <g:hiddenField name="id" value="${minutaInstance?.id}" />
        <g:hiddenField name="version" value="${minutaInstance?.version}" />
        <g:render template="formContinuar"/>

      </g:form>


      <!-- Fin del contenido del GSP -->
      <br/>
    </div>
    <div id="pie">
      <div align="center" style="margin-right: 25px;">
        <img alt="" style="margin-top:4px;" height="35px" src="${resource(dir:'images/general',file:'CDS.png')}" width="60px"/><p>&nbsp;</p>
      </div>
    </div>
  </div>
</body>
</html>
