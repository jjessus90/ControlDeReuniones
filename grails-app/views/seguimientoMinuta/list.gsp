
<%@ page import="ControlDeReuniones.Minuta" %>
<!doctype html>
<html>
  <sec:ifNotLoggedIn>
    <%
      LC = new LoginController()
      LC.index()
    %>
  </sec:ifNotLoggedIn>
  <head>
    <meta name="layout" content="main">
  <g:set var="entityName" value="${message(code: 'minuta.label', default: 'Seguimiento de acuerdos')}" />
  <title>Seguimiento de Acuerdos</title>

  <g:javascript src="JSCon.js"/>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
  <script type="text/javascript">
   function ocultar(){
           var elemento = document.getElementById('oc');
           if(elemento.className == 'mostrar'){
             elemento.className = 'ocultar';
           }
           
   }
   function cancelar(id){

           var elemento = document.getElementById(id);
           if(elemento.className == 'mostrar'){
             elemento.className = 'ocultar';
           }
           
   }
   
   function ocultarCorreo(){
     var elemento = document.getElementById('correo');
           if(elemento.className == 'mostrar'){
             elemento.className = 'ocultar';
             correo();
           }
   }
     
   function correo(){
       x = document.getElementById('text').value;
     if(x == "Usted no tiene minutas a su cargo."){
       document.getElementById('flasM').className = 'informacion';
       document.getElementById('oc').className = 'mostrar';
     }
     
   }
   
   function mensaje(id){
      var elemento = document.getElementById(id);
           if(elemento.className == 'ocultar'){
             elemento.className = 'mostrar';
           }
   }
   
   function mostrar(id, numero){

           var elemento = document.getElementById(id);
           if(elemento.className == 'ocultar'){
             elemento.className = 'mostrar';
           }
           document.getElementById("id").value = numero;
   }
   
   function principal(){     
     
       setTimeout("document.getElementById('flasF').style.display = 'none';",5000);
       setTimeout("document.getElementById('flasW').style.display = 'none';",3000);
     
       x = document.getElementById('text').value;
       if(x == "Usted no tiene minutas a su cargo."){
       document.getElementById('flasM').className = 'informacion';
       document.getElementById('oc').className = 'mostrar';
        }
     
       
       m = document.getElementById('msj').value;
       
       if(m == "La minuta se ha cancelado satisfactoriamente y se ha notificado <br/> por correo electrónico a sus participantes."){
         document.getElementById('flasMcorreo').className = 'correcto';
         document.getElementById('correo').className = 'mostrar';
         setTimeout("ocultarCorreo();",5000);
       }            
     }
    
     function recargar(){       
             location.reload(true);
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

      <h1 align="center">Seguimiento de Acuerdos</h1>

      <div class="ocultar" id="mensaje" >
          <div class='advertencia' style='background-color: white;'>            
            <g:formRemote name="myForm" method="POST"
                          action="${createLink(controller: 'SeguimientoMinuta', action: 'cancelar')}"
                          url="[controller: 'SeguimientoMinuta', action: 'cancelar']">
              <fieldset class="button">
              <label>¿Seguro que desea cancelar la minuta?</label> 

              <g:actionSubmit class="delete" action="cancelar" value="Confirmar" onclick="mensaje('mensa')"/>              
              <g:hiddenField id="id" name="id" value=""/>
              <input type="button" class="cancel" value="Cancelar" onclick="cancelar('mensaje')"/>
              <div class="ocultar" id="mensa">Por favor espere, su correo se esta enviando...</div>
              </fieldset>
            </g:formRemote>            
          </div>                
        </div>          

      <div id="oc" class="ocultar">
        <g:if test="${flash.message}">
          <div id="flasM" class="advertencia" role="status" style='background-color: white;'>${flash.message}              
            <g:hiddenField id="text" name="text" value="${flash.message}"/>
          </div>
        </g:if>
      </div>     
      <g:if test="${!params.offset}">
        <g:if test="${flash.message == 'Falló al enviar correo(s). Inténtelo mas tarde.'}">
          <div id="flasF" style="width:95%; background-color: #fff3f3;" class="error" role="status">${flash.message} </div>
        </g:if>

        <g:elseif test="${flash.mensaje == 'La minuta se ha cancelado satisfactoriamente y se ha notificado <br/> por correo electrónico a sus participantes.'}">
          <div id="correo" class="ocultar" >
            <div id="flasMcorreo" class="informacion" role="status" style='background-color: white;' ><div>${flash.mensaje}</div>             
              <g:hiddenField id="msj" name="msj" value="${flash.mensaje}"/>
            </div>       
          </div>
        </g:elseif>

        <g:elseif test="${flash.mensaje == 'La minuta se ha cancelado satisfactoriamente y se ha notificado <br/> por correo electrónico a sus participantes.'}">
        <div id="correo" class="ocultar" >
          <div id="flasMcorreo" class="informacion" role="status" style='background-color: white;' ><div>${flash.mensaje}</div>             
              <g:hiddenField id="msj" name="msj" value="${flash.mensaje}"/>
            </div>       
        </div>
      </g:elseif> 
      </g:if>
      <br/>

      <div id="menuPrincipal">
        <br /> 
        <br />

        <div id="list-minuta" class="content scaffold-list" role="main">


          <div style=" width: 760px; overflow: auto; " >
            <table width="750" class="tablaDatos">
              <thead>
                <tr class="celdasEncabezado">


              <g:sortableColumn class="tdEncabezado" property="identificador" title="${message(code: 'minuta.identificador.label', default: 'Identificador')}" />

              <g:sortableColumn class="tdEncabezado" property="objetivo" title="${message(code: 'minuta.objetivo.label', default: 'Objetivo de minuta')}" />

              <g:sortableColumn class="tdEncabezado" property="fechaInicio" title="${message(code: 'minuta.fechaInicio.label', default: 'Fecha')}" />

              <g:sortableColumn class="tdEncabezado" property="tipoReunion" title="${message(code: 'minuta.htipoReunion.label', default: 'Tipo de reunión')}" />

              <td class="tdEncabezado">Cancelar minuta</td>

              <td class="tdEncabezado">Participantes</td>

              </tr>
              </thead>
              <tbody>              
              <g:each in="${minutaInstanceList}" status="i" var="minutaInstance">
                <tr  class="trAux">

                  <td class="tdDatos" width="150"><g:link style="color:#0B615E;" action="minutaEdit" id="${minutaInstance.id}">${fieldValue(bean: minutaInstance, field: "identificador")}</g:link></td>


                <td class="tdDatos" width="200">${fieldValue(bean: minutaInstance, field: "objetivo")}</td>

                <td width="100" class="tdDatos" align="center"><g:formatDate format="yyyy-MM-dd" date="${minutaInstance?.fechaInicio}"/> </td>     

                <td class="tdDatos" width="150" align="center">${fieldValue(bean: minutaInstance, field: "tipoReunion")}</td>


                <td align="center" class="tdDatos" width="100">                 
                  <a href='#'><img src='/ControlDeReuniones/images/general/cancelar.png' onclick="mostrar('mensaje', ${minutaInstance?.id})" width='30px'/></a>

                </td>

                <td align="center" class="tdDatos" width="50">               

                <g:remoteLink action="parti2" id="${minutaInstance.id}" ><img src="/ControlDeReuniones/images/imagenesMinuta/participante.png" width="30"  /> </g:remoteLink>

                </td>
                </tr>
              </g:each>
              </tbody>
            </table>
          </div>

          <g:if test="${minutaInstanceTotal > 10}">
            <div class="pagination" style="width: 149%;">
              <g:paginate total="${minutaInstanceTotal}" />
            </div>
          </g:if>

        </div>
         
      </div>
        <fieldset class="buttons">
          <table>
            <tr>
              <td>
                <g:link action="reporte">
                  <img style="margin-top:4px;" height="35px" src="${resource(dir:'images/general',file:'excel.png')}" width="40px"/>
                </g:link>
              </td>
              <td>Reporte
              </td>
            </tr>
        </table>
        </fieldset>
      </div>
    
   
    <div id="pie">
      <div align="center" style="margin-right: 25px;">
        <img style="margin-top:4px;" height="35px" src="${resource(dir:'images/general',file:'CDS.png')}" width="60px"/>
      </div>
    </div>
  </div>  
</body>
</html>
