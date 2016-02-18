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
    <meta name="layout" content="main">
  <g:set var="entityName" value="Detalle de Participantes" />
  <title>Detalle de participantes</title>
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

      <h1 align="center">Detalle de participantes</h1>
      <br>
      <div id="menuPrincipal">




        <div id="list-usuario" class="content scaffold-list" role="main">			
          <br/>
          <h2>${minutaInstance}</h2>
          <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
          </g:if>
          <table width="750" class="tablaDatos">
            <thead>
              <tr>

            <g:sortableColumn class="tdEncabezado" style="color: white;"  property="nombre" title="${message(code: 'usuario.nombre.label', default: 'Nombre')}" />

            <g:sortableColumn class="tdEncabezado" property="organizacion" title="${message(code: 'usuario.organizacion.label', default: 'Organización')}" />

            <g:sortableColumn class="tdEncabezado" property="puesto" title="${message(code: 'usuario.puesto.label', default: 'Puesto')}" />

            <g:sortableColumn class="tdEncabezado" property="correoElectronico" title="${message(code: 'usuario.correoElectronico.label', default: 'Correo electrónico')}" />





            </tr>
            </thead>
            <tbody>
            <g:each in="${nuevo}" status="i" var="usuarioInstance">
              <tr class="trAux">

                <td class="tdDatos">${fieldValue(bean: usuarioInstance, field: "nombre")}</td>

                <td class="tdDatos">${fieldValue(bean: usuarioInstance, field: "organizacion")}</td>

                <td class="tdDatos">${fieldValue(bean: usuarioInstance, field: "puesto")}</td>

                <td class="tdDatos" align="center">${fieldValue(bean: usuarioInstance, field: "correoElectronico")}</td>



              </tr>
            </g:each>
            </tbody>
          </table>
          <fieldset class="buttons" style=" width: 746px;">
            <a href="${createLink(uri: '/SeguimientoMinuta/list')}" class="list" aling="center"><g:message code="Ir a seguimiento de acuerdos"/></a>
          </fieldset>


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
