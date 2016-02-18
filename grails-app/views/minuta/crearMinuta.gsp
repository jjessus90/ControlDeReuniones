<!doctype html>
<%@ page import="ControlDeReuniones.Minuta" %>
<%@ page import="ControlDeReuniones.PuntoTratar" %>
<%@ page import="ControlDeReuniones.Acuerdo" %>
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

    <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery.fancybox.css')}" type="text/css">
    <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.fancybox.js')}"></script>

  <g:javascript src="nuevocampo.js"/>



  <script type="text/javascript">
    
     $(function(){
    $('.selectEstaticos').multiselect({
      multiple:false,
      selectedList:1
    });   
    $('.selectFiltroEstaticos').multiselect({
      multiple:false,
      selectedList:1
    }).multiselectfilter({
            label:"Bucar:",
            placeholder:""
        }); 
 });
      
      function clonar(){
      var campo=document.getElementBy('seleccionar').cloneNode(true);
        campo=document.appendChild("division")
      }
      
 jQuery(function(){

   //Cuando el sitio carga, aplica el siguiente proceso para las pestañas...
   $(".tab_content").hide(); //Esconde todo el contenido
   $("ul.tabs li:first").addClass("active").show(); //Activa la primera tab
   $(".tab_content:first").show(); //Muestra el contenido de la primera tab

   //On Click Event
   $("ul.tabs li").click(function() {
       $("ul.tabs li").removeClass("active"); //Elimina las clases activas
       $(this).addClass("active"); //Agrega la clase activa a la tab seleccionada
       $(".tab_content").hide(); //Esconde todo el contenido de la tab
       var activeTab = $(this).find("a").attr("href"); //Encuentra el valor del atributo href para identificar la tab activa + el contenido
       $(activeTab).fadeIn(); //Agrega efecto de transiciÃ³n (fade) en el contenido activo
       return false;
   });
});
//Fin de proceso de pestañas

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
       
       
    
     if(x == "La minuta se guardó correctamente."){
       document.getElementById('flasM').className = 'correcto';        
     }
     if(x == "El participante externo no pudo ser guardado, por que falto ingresar algunos campos o el correo era invalido."){
       document.getElementById('flasM').className = 'error';        
     }
       if(x == "Ingrese el identificador de la minuta."){
       document.getElementById('flasM').className = 'error';
     }
     document.getElementById('oc').className = 'mostrar';
     setTimeout("ocultar();",5000);
   }
    
   function recargar(){
       
           location.reload(true);
   }
   
   function limpiarvacios(obj){
     var verif = obj.value;
     verif = verif.replace(/ /g,"");
     if(verif == "")
       {
         obj.value="";
       }
   }
   window.onload = principal;
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

      <g:hasErrors bean="${minutaInstance}">
        <ul class="error" style="display: block; background-color:white;" role="alert">
          <g:eachError bean="${minutaInstance}" var="error">
            <g:message error="${error}"/><br>
          </g:eachError>
        </ul>
      </g:hasErrors>

      <!-- De aquí en adelante se pondrá el contenido del GSP -->

      <g:form name="fm"  action="save" >

        <g:render template="formulario"/>


      </g:form>

      <!-- Fin del contenido del GSP -->        
    </div>


    <div id="pie">
      <div align="center" style="margin-right: 25px;">
        <img style="margin-top:4px;" height="35px" src="${resource(dir:'images/general',file:'CDS.png')}" width="60px"/><p>&nbsp;</p>
      </div>
    </div>
  </div>

</body>
</html>


