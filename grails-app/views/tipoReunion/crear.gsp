
<%@ page import="ControlDeReuniones.TipoReunion" %>
<!--  -->
<!doctype html>
<html>

  <sec:ifNotLoggedIn>
<%
LC = new LoginController()
LC.index()
%>
  </sec:ifNotLoggedIn>

  <head>
    <meta name="layout" content="main"></meta>
  <g:set var="entityName" value="${message(code: 'tipoReunion.label', default: 'TipoReunion')}" />
  <title>
    <g:message code="default.list.label" args="[entityName]" />
  </title>
  <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css"/>
  <g:javascript library="prototype" />
  <g:javascript src="JSCon.js"/>


  <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery-ui-1.8.21.custom.css')}" type="text/css"/>
  <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery.multiselect.css')}" type="text/css"/>

  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery-1.7.2.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery-ui-1.8.21.custom.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.ui.datepicker-es.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.multiselect.min.js')}"></script>


  <script type="text/javascript">
    
    function vacio(id){
      var x = false;
      if(document.getElementById(id).value != ""){
        x = true;
      }
      alert(x);
      return x;
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
          document.getElementById('flasM').style.display = 'none';
          
       }

      function principal()
      {
          setTimeout("ocultar();",3000);
         
         if(document.getElementById('flasM').className == 'error'){
           setTimeout("document.getElementById('flasM').style.display = 'none';", 3000);
         }
         
      }

      window.onload = principal;

  </script>


</head>
<body>

<% def variable= 1 %>
<g:hiddenField id="texto" name="texto" value="${variable}"/>

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

    <h1 align="center">Catálogo de Tipos de Reuniones</h1>

    <g:if test="${flash.message == 'No se puede eliminar el tipo de reunión por que pertenece a una minuta.'}">
      <div style="background-color: white;" id="flasM" class="error" role="status">${flash.message}</div>
    </g:if>

    <g:elseif test="${flash.message == 'El tipo de reunión se eliminó correctamente.'}">
      <div style="background-color: white;" id="flasM" class="correcto" role="status">${flash.message}</div>
    </g:elseif>

    <g:elseif test="${flash.message == 'No se encontró el tipo de reunión.'}">
      <div style="background-color: white;" id="flasM" class="error" role="status">${flash.message}</div>
    </g:elseif>

    <g:elseif test="${flash.message == 'Los datos se guardaron correctamente.'}">
      <div style="background-color: white;" id="flasM" class="correcto" role="status">${flash.message}</div>
    </g:elseif>

    <g:elseif test="${flash.message == 'No se pudo editar.'}">
      <div style="background-color: white;" id="flasM" class="error" role="status">${flash.message}</div>
    </g:elseif>

    <g:elseif test="${flash.message == 'Este tipo de reunión ya existe.'}">
      <div style="background-color: white;" id="flasM" class="error" role="status">${flash.message}</div>
    </g:elseif>

    <g:elseif test="${flash.message == 'El tipo de reunión se guardó correctamente.'}">
      <div style="background-color: white;" id="flasM" class="correcto" role="status">${flash.message}</div>
    </g:elseif>

    <g:hasErrors bean="${tipoReunionInstance}">
      <ul class="errors" role="alert">
        <g:eachError bean="${tipoReunionInstance}" var="error">
          <div style="background-color: white;" id="flasM" class="error" role="status">
            <g:if test="${error in org.springframework.validation.FieldError}"></g:if>Ingrese el nombre del tipo de reunión.
          </div>
        </g:eachError>
      </ul>
    </g:hasErrors>

    <div class="ocultar" id="mensaje" >
      <div style="background-color: white;" class="advertencia"> 
        <g:form name="myForm" >
          <fieldset class="button">
            <label>¿Seguro que desea eliminar el tipo de reunión?</label> 
            <g:actionSubmit class="delete" action="delete" value="Confirmar"/>  
            <g:hiddenField id="id" name="id" value=""/>
            <input type="button" value="Cancelar" class="cancel" onclick="cancelar('mensaje')"/>
          </fieldset>
        </g:form>
      </div>
    </div>


    <br/>
    <br/>

    <div id="menuPrincipal">

      <g:if test="${params.id}">
        <div id="edit-tipoReunion" class="content scaffold-create">
          <h2>Editar tipo de reunión</h2>
          <g:hasErrors bean="${tipoReunionInstance}">
            <ul class="errors" role="alert">
              <g:eachError bean="${tipoReunionInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
              </g:eachError>
            </ul>
          </g:hasErrors>
          <g:form action="save" name="guardar">
            <g:render template="mostrar"/>
            <br>
            <fieldset class="buttons" style="width:750px">
              <g:actionSubmit class="save" action="update" value="Editar" />
              <g:hiddenField id="id" name="id" value="${tipoReunionInstance?.id}"/>
              <a href="${createLink(uri: '/tipoReunion/crear')}" class="cancel" aling="center"><g:message code="Cancelar"/></a>
            </fieldset>
          </g:form>
        </div>
      </g:if>
      <g:else>
        <div id="create-tipoReunion" class="content scaffold-create">
          <h2>Agregar tipo de reunión</h2>
          <g:form action="save" name="guardar">
            <g:render template="form"/>
            <br>
            <fieldset class="buttons" style="width:750px">
              <g:submitButton name="create" class="add" value="Agregar" />
            </fieldset>
          </g:form>
        </div>
      </g:else>

      <br/>
      <br/>

      <div id="list-tipoReunion" class="content scaffold-list">

        <g:form name="form1">
          <h2>Listado de tipos de reunión</h2>

          <div style="overflow: auto; width: 760px;">

            <table width="750" class="tablaDatos">
              <thead>
                <tr>
              <g:sortableColumn width="30%" style="color: white;" class="tdEncabezado" property="nombre" title="${message(code: 'tipoReunion.nombre.label', default: 'Nombre')}" />
              <g:sortableColumn width="12%" class="tdEncabezado" property="estado" title="${message(code: 'tipoReunion.estado.label', default: 'Estado')}" />

              <g:sortableColumn width="46%" class="tdEncabezado" property="descripcion" title="${message(code: 'tipoReunion.descripcion.label', default: 'Descripción')}" />

              <td class="tdEncabezado" width="12%">Eliminar</td>

              </tr>
              </thead>
              <tbody>

              <g:each in="${tipoReunionInstanceList}" status="i" var="tipoReunionInstance">

                <tr class="trAux">

                  <td class="tdDatos"><g:link style="color:#0B615E;" action="crear" id="${tipoReunionInstance.id}" update="create-tipoReunion">${fieldValue(bean: tipoReunionInstance, field: "nombre")}</g:link></td>

                <td class="tdDatos">${fieldValue(bean: tipoReunionInstance, field: "estado")}</td>

                <td class="tdDatos">${fieldValue(bean: tipoReunionInstance, field: "descripcion")}</td>

                <td class="tdDatos">
                <center>
                  <a href='#'><img src='/ControlDeReuniones/images/general/eliminar.png' title="Eliminar elemento" alt="Eliminar elemento" onclick="mostrar('mensaje', ${tipoReunionInstance?.id})" width='30px'/></a>
                </center>
                </td>
                </tr>

              </g:each>

              </tbody>
            </table>  

          </div>

        </g:form>

        <g:if test="${tipoReunionInstanceTotal > 10}">
          <div class="pagination" style=" width: 746px;">
            <g:paginate total="${tipoReunionInstanceTotal}" />
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

</div>
</body>
</html>