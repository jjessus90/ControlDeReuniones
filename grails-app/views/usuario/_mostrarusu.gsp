<%@ page import="ControlDeReuniones.Usuario", "ControlDeReuniones.UsuarioRol" %>

<table style="width:745px;" border="0" class="tablaDatos">
  <tr>
    <td style="color: white;" class="tdEncabezado" colspan="4">Crear un nuevo usuario</td>
  </tr>
  
  <tr><div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'nombre', 'error')} required">
  <td class="tdTipoDatos" style="width:10%;"><label for="nombre">
		<g:message code="usuario.nombre.label" default="Nombre:" />
		<span class="required-indicator">*</span>
	</label></td>
        <td class="tdDatos trAux"><g:textField  id="mosnom" name="nombre" required="" maxlength="100" value="${usuarioInstance?.nombre}" onkeypress="return let(event)"/></td>
</div>
  
  <div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'organizacion', 'error')} required">
  <td class="tdTipoDatos" style="width:10%;"><label for="organizacion">
		<g:message code="usuario.organizacion.label" default="Organización:" />
		<span class="required-indicator">*</span>
	</label></td>
        <td class="tdDatos trAux"><g:textField id="mosorg"  name="organizacion" required=""  maxlength="100" value="${usuarioInstance?.organizacion}" onkeypress="return let2(event)"/></td>
</div></tr>

<tr> 
  
  <div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'username', 'error')} required">
	<td class="tdTipoDatos" style="width:10%;"><label for="username:">
          <g:message code="usuario.username.label" default="Usuario" />
          <span class="required-indicator">*</span>
	</label></td>
        <td class="tdDatos trAux"><g:textField  id="mosusu" name="username" onkeypress="return enter(event)" onchange="return let3(event)" maxlength="100" required="" value="${usuarioInstance?.username}"/></td>
</div>
  


<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'password', 'error')} required">
	<td class="tdTipoDatos" style="width:10%;"><label for="password:">
          <g:message code="usuario.password.label" default="Contraseña" />
		<span class="required-indicator">*</span>
	</label></td>
        <td class="tdDatos trAux"> <g:field  type="password" id="mospas" onkeypress="return enter(event)" name="password"  required="" value=""/></td>
</div></tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'puesto', 'error')} required">
  <td class="tdTipoDatos" style="width:10%;"><label for="puesto">
		<g:message code="usuario.puesto.label" default="Puesto:" />
		<span class="required-indicator">*</span>
	</label></td>
        <td class="tdDatos trAux"><g:textField id="mospue"  name="puesto" onkeypress="return enter(event)" onblur="boton()" required="" maxlength="100" value="${usuarioInstance?.puesto}" onkeypress="return soloLetras(event)"/></td>
</div>
<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'correoElectronico', 'error')} required">
  <td class="tdTipoDatos" style="width:15%;"><label for="correoElectronico">
		<g:message code="usuario.correoElectronico.label" default="Correo electrónico:" />
		<span class="required-indicator">*</span>
	</label></td>
        <td class="tdDatos trAux"><g:field id="mosmail"  type="email" onkeypress="return enter(event)" name="correoElectronico"  maxlength="100" required="" value="${usuarioInstance?.correoElectronico}" onchange="verificar2()" /></td>
</div></tr>

<tr>
<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'enabled', 'error')} ">
  <td class="tdTipoDatos" style="width:13%;"><label for="enabled">
		<g:message code="usuario.enabled.label" default="Cuenta activa:" />
		
	</label></td>
        <td class="tdDatos trAux"><g:checkBox id="mosena"  name="enabled" onkeypress="return enter(event)"  value="${usuarioInstance?.enabled}" /></td>
</div>




<div class="fieldcontain ${hasErrors(bean: usuarioRolInstance, field: 'rol', 'error')} required">
  <td class="tdTipoDatos" style="width:10%;"><label for="rol">
		<g:message code="usuarioRol.rol.label" default="Rol:" />
		<span class="required-indicator">*</span>
	</label></td>
        <td class="tdDatos trAux"><g:select  id="mosrol" name="rol.id" onkeypress="return enter(event)"  from="${ControlDeReuniones.Rol.list()}" onchange="botonns()" optionValue="${{it.authority.getAt(5..it.authority.length()-1)}}"optionKey="id" required="" value="${rolInstance}" class="many-to-one"/></td>
</div></tr>



  
</table>

<div class="fieldcontain ${hasErrors(bean: usuarioRolInstance, field: 'tipo', 'error')} required">
  <input type="hidden" name="tipo" value="Interno"></input>
</div>

<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'accountLocked', 'error')} ">

        <g:hiddenField name="accountLocked" value="false" />
</div>


<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'accountExpired', 'error')} ">
         <g:hiddenField name="accountExpired" value="false" />
</div>



<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'passwordExpired', 'error')} ">
          <g:hiddenField name="passwordExpired" value="false" />
</div>