<%@ page import="ControlDeReuniones.Usuario", "LoginController", "ControlDeReuniones.UsuarioRol"%>
<!doctype html>
<html>



  <head>

    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />

  <sec:ifNotLoggedIn>
<%
LC = new LoginController()
LC.index()
%>
  </sec:ifNotLoggedIn>

  <meta name="layout" content="main"></meta>
  <g:set var="entityName" value="${message(code: 'usuario.label', default: 'Usuario')}" />
  <title><g:message code="default.create.label" args="[entityName]" /></title>
  <g:javascript library="prototype" />
  <g:javascript src="JSCon.js"/>
  <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery-ui-1.8.21.custom.css')}" type="text/css"/>
  <link rel="stylesheet" href="${resource(dir: 'css/jQuery', file: 'jquery.multiselect.css')}" type="text/css"/>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery-1.7.2.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery-ui-1.8.21.custom.min.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.ui.datepicker-es.js')}"></script>
  <script type="text/javascript" src="${resource(dir: 'js/jQuery', file: 'jquery.multiselect.min.js')}"></script>

  <script type="text/javascript"> 
    var s;
    
    function ocultar(){
          document.getElementById('flasM').style.display = 'none';
          
       }
    
    function can(){
      setTimeout("${remoteFunction(controller: 'Usuario' , action:'create', update: 'sa')}",300);
    }
      
    
    function mostrarinf(){
      boton()
      var confelim = document.getElementById('elim2');
      var confadmin1 = document.getElementById('confAd');
      var confadmin2 = document.getElementById('confAdUp');
      var empy = document.getElementById('emp');
      if(confelim.className == 'mostrar'){
        confelim.className = 'ocultar';
      }
      if(empy.className == 'mostrar'){
        empy.className = 'ocultar';
      }
      if(confadmin1.className == 'mostrar'){
        confadmin1.className = 'ocultar';
      }
      if(confadmin2.className == 'mostrar'){
        confadmin2.className = 'ocultar';
      }
        
      window.scrollTo(0,0);
    }
    
    function ent(e){
      if(e.keyCode == 13){
        admin();
      }
    }
    
    function valemp(){
      var men = document.getElementById('emp');
      var mensaje = document.getElementById('correo');
      var nombre = document.getElementById('nombreup').value = document.getElementById('mosnom').value;
      var orga = document.getElementById('organizacionup').value = document.getElementById('mosorg').value;
      var userna = document.getElementById('usuernameup').value = document.getElementById('mosusu').value;
      var passw = document.getElementById('passwordup').value = document.getElementById('mospas').value;
      var puest = document.getElementById('puestoup').value = document.getElementById('mospue').value;
      var email = document.getElementById('emailup').value = document.getElementById('mosmail').value;
      var id = document.getElementById('idUsu').value = document.getElementById('id').value;
      var version = document.getElementById('versionUsu').value = document.getElementById('version').value;
      if(fields(nombre,email,passw,orga,puest,userna) == false){
        men.className = 'mostrar';
      }else{
        men.className = 'ocultar';
        mensaje.className = 'mostrar';
      }
    }
    
    function admin2()
    {
      var men = document.getElementById('confAdUp');
      var ma = document.getElementById('ma');
      var rol = document.getElementById('mosrol').value;
      if(valor(rol)){
          
          ma.className = 'ocultar';
          var mensa = document.getElementById('emp');
          var ma = document.getElementById('ma');
          var nombre = document.getElementById('nombreup').value = document.getElementById('mosnom').value;
          var orga = document.getElementById('organizacionup').value = document.getElementById('mosorg').value;
          var userna = document.getElementById('usuernameup').value = document.getElementById('mosusu').value;
          var passw = document.getElementById('passwordup').value = document.getElementById('mospas').value;
          var puest = document.getElementById('puestoup').value = document.getElementById('mospue').value;
          var email = document.getElementById('emailup').value = document.getElementById('mosmail').value;
          var id = document.getElementById('idUsu').value = document.getElementById('id').value;
          var version = document.getElementById('versionUsu').value = document.getElementById('version').value;
          if(fields(nombre,email,passw,orga,puest,userna) == false){
            mensa.className = 'mostrar';
          }else{
            mensa.className = 'ocultar';
            men.className = 'mostrar';
          }
        }else{
          men.className = 'ocultar';
        }
    }
    
    function admin(){
      var men = document.getElementById('confAd');
      var rol = document.getElementById('rol').value;
      if(cam() == false){
        
      }else{
        if(valor(rol)){
          men.className = 'mostrar';
          var ma = document.getElementById('ma');
          var nombre = document.getElementById('nombre').value = document.getElementById('nom').value;
          var orga = document.getElementById('organizacion').value = document.getElementById('org').value;
          var userna = document.getElementById('usuername').value = document.getElementById('usu').value;
          var passw = document.getElementById('password').value = document.getElementById('pas').value;
          var puest = document.getElementById('puesto').value = document.getElementById('pue').value;
          var email = document.getElementById('email').value = document.getElementById('mail').value;
        }else{
          men.className = 'ocultar';
        }
      }
    }
    
    function boton(){
      var btn1 = document.getElementById('btn');
      var btn2 = document.getElementById('btn2');
      var men = document.getElementById('confAd');
      var rol = document.getElementById('rol').value;
      if(rol){
          if(btn1 && btn2){
          if(rol == 1){
            btn1.className = 'ocultar';
            btn2.className = 'mostrar';
          }else{
            btn1.className = 'mostrar';
            btn2.className = 'ocultar';
            men.className = 'ocultar';
          }
        }
      }else{
        if(btn1 && btn2){
        if(rol == 1){
          btn1.className = 'ocultar';
          btn2.className = 'mostrar';
        }else{
          btn1.className = 'mostrar';
          btn2.className = 'ocultar';
          men.className = 'ocultar';
        }
      }
      }
      
    }
    
   
    function botonns(){
      var btn1 = document.getElementById('btned');
      var btn2 = document.getElementById('btned2');
      var men = document.getElementById('confAd');
      var rol = document.getElementById('mosrol').value;
      if(rol){
          if(btn1 && btn2){
          if(rol == 1){
            btn1.className = 'ocultar';
            btn2.className = 'mostrar';
          }else{
            btn1.className = 'mostrar';
            btn2.className = 'ocultar';
            men.className = 'ocultar';
          }
        }
      }else{
        if(btn1 && btn2){
        if(rol == 1){
          btn1.className = 'ocultar';
          btn2.className = 'mostrar';
        }else{
          btn1.className = 'mostrar';
          btn2.className = 'ocultar';
          men.className = 'ocultar';
        }
      }
      }
      
    }
    
    
    function cam(valor){
      var nom = document.getElementById('nom').value;
      var men = document.getElementById('emp');
      var mal = document.getElementById('ma');
      var trab = document.getElementById('correo');
      var confelim = document.getElementById('elim2');
      var org = document.getElementById('org').value;
      var usu = document.getElementById('usu').value;
      var pas = document.getElementById('pas').value;
      var pue = document.getElementById('pue').value;
      var mai = document.getElementById('mail').value;
      var ver = fields(nom,mai,pas,org,pue,usu);
      if(ver == false){
        men.className  = 'mostrar';
        confelim.className = 'ocultar';
        mal.className = 'ocultar';
        boton();
      }else{
        if(valor == 1){
          trab.className='mostrar';
        }
        men.className = 'ocultar';
        confelim.className = 'ocultar';
        boton();
      }
      return ver;
    }
    
    function verificar2(){
      var c2 = document.getElementById('mosmail').value;
      var ma = document.getElementById('ma');
      var buton = document.getElementById('edbuttons');
      var btned = document.getElementById('botton');
      var btned2 = document.getElementById('botton2')
      var men = document.getElementById('emp');
      var ver = document.getElementById('confAd');
     
      var s = verificarcorr(c2);
      if(s == false){
        btned.disabled = true;
        btned2.disabled = true;
        buton.className = 'boton';
        ma.className = 'mostrar';
        men.className = 'ocultar';
        ver.classsName = 'ocultar';
      }else{
        btned.disabled = false;
        btned2.disabled = false;
        buton.className = 'buttons';
        ma.className = 'ocultar';
        ver.classsName = 'ocultar';
      }
    }
    
    function verificar(){
      var c2 = document.getElementById('mail').value;
      var ma = document.getElementById('ma');
      var buton = document.getElementById('botones');
      var btn1 = document.getElementById('boton1');
      var btned = document.getElementById('botton');
      var btned2 = document.getElementById('botton2');
      var btn2 = document.getElementById('boton2');
      var men = document.getElementById('emp');
      var ver = document.getElementById('confAd');
     
      var s = verificarcorr(c2);
      if(s == false){
        btn1.disabled = true;
        btned.disabled = true;
        btned2.disabled = true;
        btn2.disabled = true;
        buton.className = 'boton';
        ma.className = 'mostrar';
        men.className = 'ocultar';
        ver.classsName = 'ocultar';
      }else{
        btn1.disabled = false;
        btn2.disabled = false;
        btned.disabled = false;
        btned2.disabled = false;
        buton.className = 'buttons';
        ma.className = 'ocultar';
        ver.classsName = 'ocultar';
      }
    }
    
    function mostrar(idusu){
        var confelim = document.getElementById('elim2');
        var men = document.getElementById('emp');
        var mal = document.getElementById('ma');
        
          
          men.className = 'ocultar';
          mal.className = 'ocultar';
        
        confelim.className = 'mostrar';
        s = idusu;
        var valor = document.getElementById('idh').value=s;
        window.scrollTo(0,0);
        if(document.getElementById('flasM').style.display != 'none')
          document.getElementById('flasM').style.display = 'none'
        
        var inf = document.getElementById('inf');
        inf.className = 'ocultar';
      }
      
      function principal()
      {
          setTimeout("ocultar();",3000);
      }

      window.onload = principal;
  </script>


</head>
<body >
  

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

        <h1 align="center">Control de Usuarios</h1>

        <div id="emp" class="ocultar">
          <div class="error" style="display: block; background-color: #fff3f3;">
            Se necesita llenar los campos que estan marcados con un asterisco (*).
          </div>
        </div>

        <div id="confAd" class="ocultar">
          <g:form name="conf" class="error" style="background-color: #fff3f3;" >
            <fieldset class="button" >
              <label>¿Seguro que desea asignarle los privilegios de administrador a este nuevo usuario?</label><g:render template="formconf"/>
              <g:actionSubmit class="delete" action="save" name="eliminar"  value="Confirmar"/> 
              <a href="${createLink(uri: '/usuario/create')}" class="cancel" aling="center"><g:message code="Cancelar"/></a>
            </fieldset>
          </g:form>
        </div>



        <div id="ma" class="ocultar">
          <div class="informacion" style="display: block; background-color: #fff3f3;">
            El formato de el correo electrónico es incorrecto.
          </div>
        </div>
        
        <g:if test="${params.id}" id="inf" class="mostrar">
          <div >
            <div class="informacion" style="display: block; background-color: #fff3f3;">
              Si asigna un nuevo administrador será sacado del sistema.
            </div>
          </div>
        </g:if>
        

        <div id="correo" class="ocultar">
          <div class="informacion" style="display: block; background-color: #fff3f3;">
            Por favor espere, se esta enviando un correo al usuario modificado.
          </div>
        </div>

        <div id="elim2" class="ocultar">
          <div class="advertencia" style="background-color: #fff3f3;" > 
            <g:form name="myForm" >
              <fieldset class="button" >
                <label>¿Seguro que desea eliminar el usuario?</label>
                <g:actionSubmit class="delete" action="delete" value="Confirmar"/>  
                <g:hiddenField id="idh" name="id" value=""/>
                <a href="${createLink(uri: '/usuario/create')}" class="cancel" aling="center"><g:message code="Cancelar"/></a>
              </fieldset>
            </g:form>
          </div>
        </div>

        <div id="confAdUp" class="ocultar">
          <g:form name="conf" class="error" style="background-color: #fff3f3;" >
            <g:hiddenField id="idUsu" name="id" value="" />
            <g:hiddenField id="versionUsu" name="version" value="" />
            <fieldset class="button" >
              <label>¿Seguro que desea asignarle los privilegios de administrador a este nuevo usuario?</label>
              <g:render template="formconf2"/>
              <g:actionSubmit class="delete" action="verup"  value="Confirmar"/> 
              <a href="${createLink(uri: '/usuario/create')}" class="cancel" aling="center"><g:message code="Cancelar"/></a>
            </fieldset>
          </g:form>
        </div>

        <g:if test="${flash.message == 'El usuario que intenta registrar ya existe.'}">
          <div id="flasM" class="advertencia" role="status" style="background-color: #fff3f3;" >
${flash.message}
          </div>
        </g:if>

        <g:elseif test="${flash.message == 'Se eliminó correctamente el usuario.'}">
          <div id="flasM" class="correcto" role="status" style="background-color: #fff3f3;" >
${flash.message}
          </div>
        </g:elseif>
        <g:elseif test="${flash.message == 'No se puede eliminar el usuario porque pertenece a una minuta o a un acuerdo.'}">
          <div id="flasM" class="error" role="status" style="background-color: #fff3f3;" >
${flash.message}
          </div>
        </g:elseif>
        <g:elseif test="${flash.message == 'Los datos se guardarón correctamente y se notificó via correo electrónico.'}">
          <div id="flasM" class="correcto" role="status" style="background-color: #fff3f3;" >
${flash.message}
          </div>
        </g:elseif>
        <g:elseif test="${flash.message == 'Se agregó correctamente el nuevo usuario.'}">
          <div id="flasM" class="correcto" role="status" style="background-color: #fff3f3;" >
${flash.message}
          </div>
        </g:elseif>
        <g:elseif test="${flash.message == 'No se puede eliminar al administrador.'}">
          <div id="flasM" class="error" role="status" style="background-color: #fff3f3;" >
${flash.message}
          </div>
        </g:elseif>
        <g:elseif test="${flash.message == 'El Administrador se modificó correctamente.'}">
          <div id="flasM" class="correcto" role="status" style="background-color: #fff3f3;" >
${flash.message}
          </div>
        </g:elseif>
        <g:elseif test="${flash.message == 'Los datos se guardarón correctamente, pero no se pudo enviar el correo.'}">
          <div id="flasM" class="advertencia" role="status" style="background-color: #fff3f3;" >
${flash.message}
          </div>
        </g:elseif>

        <div id="menuPrincipal">
          <br></br>
          <g:if test="${params.id}" >
            <div id="edit-usuario" class="content scaffold-edit" role="main">
              <h2>Editar Usuario</h2>
              <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
              </g:if>
              <g:hasErrors bean="${usuarioInstance}">
                <ul class="errors" role="alert">
                  <g:eachError bean="${usuarioInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                  </g:eachError>
                </ul>
              </g:hasErrors>
              <g:form method="post" >
                <g:hiddenField id="id" name="id" value="${usuarioInstance?.id}" />
                <g:hiddenField id="version" name="version" value="${usuarioInstance?.version}" />
                <g:render template="mostrarusu"/><br/>
                <fieldset class="buttons" id="edbuttons"  style="width:738px" >   
                  <div id="btned" class="mostrar">
                    <g:actionSubmit id="botton" onclick="valemp()" action="verup" class="save" value="Guardar" /> <a href="${createLink(uri: '/usuario/create')}" class="cancel" aling="center"><g:message code="Cancelar"/></a> 
                  </div>
                  <div id="btned2" class="ocultar">
                    <input type="button" id="botton2" value="Guardar" class="save" onclick="admin2()" /> <a href="${createLink(uri: '/usuario/create')}" class="cancel" aling="center"><g:message code="Cancelar"/></a>
                  </div>

                </fieldset>
              </g:form>
            </div>
          </g:if>
          <g:else>
            <div id="create-usuario" class="content scaffold-create" role="main">
              <h2>Agregar un nuevo usuario</h2><br/><br/>
              <g:hasErrors bean="${usuarioInstance}">
                <ul class="errors" role="alert">
                  <g:eachError bean="${usuarioInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                  </g:eachError>
                </ul>
              </g:hasErrors>
              <g:form action="save" name="usuario" >
                <g:render template="form"/><br/>
                <fieldset id="botones" class="buttons" style="width:738px" >
                  <div id="btn" class="mostrar">
                    <g:submitButton id="boton1" onclick="cam()" name="create" class="add" value="Agregar" />
                  </div>
                  <div id="btn2" class="ocultar">
                    <input type="button" id="boton2" value="Agregar" class="add" onclick="admin()" />
                  </div>
                </fieldset>
              </g:form>
            </div>

          </g:else>





          <div id="list-usuario" class="content scaffold-list" role="main">
            <g:form>
              <h2>Lista de usuarios</h2>
              <div style="overflow: auto; width: 760px;">

                <table width="100%" style="width: 745px" class="tablaDatos">
                  <thead>
                    <tr>

                  <g:sortableColumn class="tdEncabezado" colspan="1" property="username" title="${message(code: 'usuario.username.label', default: 'Nombre de usuario')}" />

                  <g:sortableColumn class="tdEncabezado" colspan="2" property="correoElectronico" title="${message(code: 'usuario.correoElectronico.label', default: 'Correo electrónico')}" />

                  <g:sortableColumn class="tdEncabezado" colspan="2" property="nombre" title="${message(code: 'usuario.nombre.label', default: 'Nombre')}" />

                  <g:sortableColumn class="tdEncabezado" colspan="2" property="organizacion" title="${message(code: 'usuario.organizacion.label', default: 'Organización')}" />

                  <g:sortableColumn class="tdEncabezado" colspan="2" property="puesto" title="${message(code: 'usuario.puesto.label', default: 'Puesto')}" />

                  <td class="tdEncabezado" colspan="2" >Eliminar</td>

                  </tr>
                  </thead>
                  <tbody>
                  <g:set id="contador" var="cont" value="${0}"/>
                  <g:each in="${usuarioInstanceList}" status="i" var="usuarioInstance">
                    <tr class="trAux" >

                      <td class="tdDatos" onclick="mostrarinf()"  ><center><g:link action="create" style="color:#0B615E;" id="${usuarioInstance.id}" update="create-usuario">${fieldValue(bean: usuarioInstance, field: "username")}</center></g:link></td>

                    <td class="tdDatos" colspan="2"><center>${fieldValue(bean: usuarioInstance, field: "correoElectronico")}</center></td>

                    <td class="tdDatos" colspan="2"><center>${fieldValue(bean: usuarioInstance, field: "nombre")}</center></td>

                    <td class="tdDatos" colspan="2"><center>${fieldValue(bean: usuarioInstance, field: "organizacion")}</center></td>

                    <td class="tdDatos" colspan="2"><center>${fieldValue(bean: usuarioInstance, field: "puesto")}</center></td>

                      <td class="tdDatos">
                        <center>
                          <a href='#'><img src='/ControlDeReuniones/images/general/eliminar.png' title="Eliminar elemento" alt="Eliminar elemento" onclick="mostrar(${usuarioInstance?.id})" width='30px'/></a>
                        </center>
                      </td>
                    </tr>
                    <g:hiddenField id="idebt" name="id" value="${usuarioInstance?.id}" /> 
                  </g:each>
                  </tbody>
                </table>
              </div>
            </g:form>
            <g:if test="${usuarioInstanceTotal > 10}">
              <div class="pagination" style="width: 745px">
                <g:paginate total="${usuarioInstanceTotal}"  />
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