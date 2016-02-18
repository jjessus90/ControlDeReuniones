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
   <!--<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">-->
  <g:set var="entityName" value="Historial" />
  <title>Historial</title>
  <g:javascript library="prototype" />
  <g:javascript src="JSCon.js"/>


  <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery-ui-1.8.21.custom.css')}" type="text/css"/>
  <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery.multiselect.css')}" type="text/css"/>

  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery-1.7.2.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery-ui-1.8.21.custom.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.ui.datepicker-es.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.multiselect.min.js')}"></script>

  <script>
    
    function limpiar(){

      
      
    }
    
$(document).ready(function(){
     
})

function ocultar(){
              document.getElementById('flasM').style.display = 'none';
           }
           
         

          function principal()
          {
              setTimeout("ocultar();",3000);
          }

          window.onload = principal
  </script>
</head>
<body>


  <div id="contenedorGral">

    <div id="banner">
      <div id="logoUtez" ><img src="${resource(dir:'images/general',file:'UTEZ.png')}" width="140px"/></div>
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

      <h1 align ="center">Historial de Minutas:</h1>
      <g:if test="${!params.offset && !params.sort}">
        <g:if test="${flash.message == 'Se encontraron ' + results + ' resultados.'}">
          <div style="background-color: #fff3f3" id="flasM" class="informacion" role="status">${flash.message} </div>
        </g:if>

        <g:if test="${flash.message == 'No se pueden hacer búsquedas de fechas posteriores a la de hoy.'}">
          <div id="flasM" style="background-color: #fff3f3" class="error" role="status">${flash.message} </div>
        </g:if>

        <g:if test="${flash.message == 'El rango de fechas es inválido.'}">
          <div id="flasM" style="background-color: #fff3f3" class="error" role="status">${flash.message} </div>
        </g:if>


        <g:if test="${flash.message == 'Debe seleccionar por lo menos un tipo de reunion.'}">
          <div id="flasM" style="background-color: #fff3f3" class="error" role="status">${flash.message} </div>
        </g:if>

        <g:if test="${flash.message == 'Debe seleccionar tambien una de fecha de inicio.'}">
          <div id="flasM" style="background-color: #fff3f3" class="error" role="status">${flash.message} </div>
        </g:if>

        <g:if test="${flash.message == 'Todavia no ha asignado una fecha válida.'}">
          <div id="flasM" style="background-color: #fff3f3" class="error" role="status">${flash.message} </div>
        </g:if>
      </g:if>
      <div id="menuHistorial">

        <br/><br/>


        <g:form style="width: 720px" name="myForm" action="lista"

                <div name="fecha">
            <g:hiddenField name="contador" id="con" value="${0}"/>
            <h2>Búsqueda de minutas</h2>
            <table style="width:750px;" border="0" class="tablaDatos">
              <tr>
                <td style="color: white;" class="tdEncabezado" colspan="4">
                  Búsqueda de minutas por:
                </td>
              </tr>
              <tr>
                <td valign="middle" class="tdTipoDatos" style="width:20%;" >
                  <label>Fecha inicial:</label>
                </td>
                <td class="tdDatos">

                  <input type="text" readonly="readonly" name="fechaInicio" id="inicio" value="${fechaDeInicio}"/>

                </td>

                <td valign="middle" class="tdTipoDatos" style="width:20%;" > 
                  <label>Tipo de reunión:</label>
                </td>
                <td class="tdDatos">
              <g:select name="tipo" style="width: 310px;" noSelection="['':'Selecciona']" from="${ControlDeReuniones.TipoReunion.list().nombre}" value="${tipoDeReunion}"/>
              </td>
              </tr>
              <tr>
                <td valign="middle" class="tdTipoDatos" style="width:20%;" >
                  <label>Fecha final: </label>
                </td>
                <td class="tdDatos">
                  <input type="text" readonly="readonly" name="fechaFinal" id="final" value="${fechaDeFin}"/>
                </td>
              </tr>
            </table>

            <br/>

            <fieldset class="buttons" style="width:103%;">
              <g:submitButton name="create" class="find" value="Buscar" />
              <g:link  action="limpiar"><input type="button" value="Limpiar campos" name="limpiar" class="clean"/></g:link>
            </fieldset>

          </div>

        </g:form>

        <br></br>


        <div id="menuHistorial">



          <div id="list-minuta" class="content scaffold-list" role="main">

            <g:form name="form1">

              <div style="overflow: auto; width: 760px;">

                <table style="width: 750px;" class="tablaDatos">
                  <tr> <h2> Resultado de la búsqueda:</h2></tr>
                  <thead>
                    <tr class="celdasEncabezado">

                  <g:sortableColumn class="tdEncabezado" titleKey="listar.identificador" params="${params}" width="10%" property="identificador" title="${message(code: 'minuta.identificador.label', default: 'Identificador')}" />           




                  <g:sortableColumn class="tdEncabezado" property="objetivo"  params="${params}" title="${message(code: 'minuta.fechaInicio.label', default: 'Objetivo')}" />          

                  <g:sortableColumn class="tdEncabezado" property="fechaInicio" params="${params}" title="${message(code: 'minuta.fechaInicio.label', default: 'Fecha inicio')}" />

                  <g:sortableColumn class="tdEncabezado" property="tipoReunion" params="${params}" title="${message(code: 'minuta.horaInicio.label', default: 'Tipo de reunión')}" />

                  </tr>

                  </thead>

                  <tbody>

                  <g:each in="${listar}" status="i" var="minutaInstance">
                    <tr class="trAux">
                      <td class="tdDatos"><g:link action="verMinuta" id="${minutaInstance.id}" style="color:#0B615E;">${fieldValue(bean: minutaInstance, field: "identificador")}</g:link></td>          

                    <td class="tdDatos">${fieldValue(bean: minutaInstance, field: "objetivo")}</td>

                    <td class="tdDatos"><g:formatDate format="dd/MM/yyyy" date="${minutaInstance.fechaInicio}" /></td>   

                    <td class="tdDatos">${fieldValue(bean: minutaInstance, field: "tipoReunion")}</td>

                    </tr>
                  </g:each>
                  </tbody>
                </table>

              </div>

            </g:form>

            <g:if test="${minutaInstanceTotal > 10}">
              <div class="pagination" style=" width: 746px;">
                <g:paginate params="[tipo: params.tipo, fechaInicio: params.fechaInicio, fechaFinal: params.fechaFinal,inicioFecha:params.inicioFecha]" total="${minutaInstanceTotal}" />
              </div>
            </g:if>

          </div>

        </div>

      </div>
      <div id="pie">
        <div align="center" style="margin-right: 25px;">
          <img style="margin-top:4px;" height="35px" src="${resource(dir:'images/general',file:'CDS.png')}" width="60px"/>
        </div>
      </div>
      </body> 

      </html>

