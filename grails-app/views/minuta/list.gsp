<%@ page import="ControlDeReuniones.Minuta" %>
<%@ page import="ControlDeReuniones.Usuario" %>
<!doctype html>
<html>
  <sec:ifNotLoggedIn>
    <%
      LC = new LoginController()
      LC.index()
    %>
  </sec:ifNotLoggedIn>
  <head>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <title>Control De Reuniones</title>  

    <script type="text/javascript">
    
       function cancelar(id){
                var elemento = document.getElementById(id);
                if(elemento.className == 'mostrar'){
                  elemento.className = 'ocultar';
                }
            }   
    
      function ocultar(){

              var elemento = document.getElementById('oc');
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
    
    
    
       function principal(){
         x = document.getElementById('text').value;
       
         if(x == "La minuta se elimino correctamente"){
           document.getElementById('flasM').className = 'correcto';        
         }
         document.getElementById('oc').className = 'mostrar';
         setTimeout("ocultar();",5000);
       
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

        <h1 align="center">Gestión de Minutas </h1> 

        <div id="oc" class="ocultar">
          <g:if test="${flash.message}">
            <div id="flasM" class="correcto" role="status" style='background-color:white;'>${flash.message}
              <g:hiddenField id="text" name="text" value="${flash.message}"/>
            </div>         
          </g:if>
        </div>

        <div class="ocultar" id="mensaje" >
          <div class='error' style='background-color:white;'>            
            <g:formRemote name="myForm" method="POST"
                          action="${createLink(controller: 'Minuta', action: 'eliminarMinuta')}"
                          url="[controller: 'Minuta', action:'eliminarMinuta']">
              <fieldset class="button"><label>¿Seguro que desea eliminar la minuta?</label>

                <g:actionSubmit class="delete" action="eliminarMinuta" value="Confirmar" />  
                <g:hiddenField id="id" name="id" value=""/>
                <input type="button" value="Cancelar" class="cancel" onclick="cancelar('mensaje')"/></fieldset>
            </g:formRemote>         
          </div>               
        </div>   
        <br>
        <div class="button" style="width:150px; margin-left:60px; "> <g:link class="add" action="create">Crear minuta</g:link></div>
        <br>


        <div align="center"> 
          <table class="tablaDatos" id="cuerpoTabla" style="text-align: center; width:750px">
            <thead>
              <tr>

            <g:sortableColumn class="tdEncabezado" property="identificador" title="${message(code: 'minuta.identificador.label', default: 'Identificador')}" />           

            <g:sortableColumn class="tdEncabezado" property="fechaInicio" title="${message(code: 'minuta.fechaInicio.label', default: 'Fecha inicio')}" />



            <g:sortableColumn class="tdEncabezado" property="horaInicio" title="${message(code: 'minuta.horaInicio.label', default: 'Hora inicio')}" />

            <td class="tdEncabezado">Participantes</td>

            <td class="tdEncabezado">Eliminar</td>

            </tr>
            </thead>
            <tbody>

            <g:each in="${listar}" status="i" var="minutaInstance">
              <tr class="${(i % 2) == 0 ? 'even' : 'odd'} trAux">

                <td class="tdDatos"><g:link style="color:#0B615E;" action="continuarMinuta" id="${minutaInstance.id}">${fieldValue(bean: minutaInstance, field: "identificador")}</g:link></td>         


              <td class="tdDatos"><g:formatDate format="dd/MM/yyyy" date="${minutaInstance.fechaInicio}" /></td>

              <td class="tdDatos">${fieldValue(bean: minutaInstance, field: "horaInicio")}</td>

              <td class="tdDatos">



              <g:each in="${listar[i].usuario}" status="j" var="minutaInstancia">
${listar[i].usuario.nombre[j]}<g:if test="${(listar[i].usuario.size())-1!=j}">,</g:if>
              </g:each>
              </td>
              <td class="tdDatos">              
             <!--<input type="button" value="Eliminar" onclick="mostrar('mensaje', ${minutaInstance?.id})"/>-->
                <a href='#'><img src='/ControlDeReuniones/images/general/eliminar.png' title="Eliminar elemento" alt="Eliminar elemento" onclick="mostrar('mensaje', ${minutaInstance?.id})" width='30px'/></a>
              </td>

              </tr>
            </g:each>
            </tbody>
          </table>
        </div>
        <g:if test="${minutaInstanceTotal > 10}"> 
          <div class="pagination"  style="width:750px; margin:0 auto; ">
            <g:paginate max="9" total="${minutaInstanceTotal}" />
          </div>
          <br>
        </g:if>  
      </div>

      <div id="pie">
        <div align="center" style="margin-right: 25px;">
          <img style="margin-top:4px;" height="35px" src="${resource(dir:'images/general',file:'CDS.png')}" width="60px"/><p>&nbsp;</p>
        </div>
      </div>

    </div>
  </body>
</html>