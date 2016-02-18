<%@ page import="ControlDeReuniones.Usuario", "ControlDeReuniones.UsuarioRol" %>


<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'nombre', 'error')} required">
        <g:hiddenField id="nombreup"  value="" name="nombre" required="" maxlength="100" />
</div>
  <div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'organizacion', 'error')} required">
        <g:hiddenField id="organizacionup"  name="organizacion" required="" maxlength="100" value="" />
</div>
  
  <div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'username', 'error')} required">
        <g:hiddenField id="usuernameup" name="username" maxlength="100" required="" value=""/>
</div>
<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'password', 'error')} required">
        <g:hiddenField type="password" id="passwordup" name="password" maxlength="100" required="" value=""/>
</div>
<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'puesto', 'error')} required">
        <g:hiddenField id="puestoup" name="puesto" required="" maxlength="100" value="" />
</div>
<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'correoElectronico', 'error')} required">
        <g:hiddenField id="emailup" type="email" name="correoElectronico" maxlength="100" required="" value="" />
</div>
<div class="fieldcontain ${hasErrors(bean: usuarioInstance, field: 'enabled', 'error')} ">
  <g:hiddenField name="enabled" value="true" />
</div>
  
<div class="fieldcontain ${hasErrors(bean: usuarioRolInstance, field: 'rol', 'error')} required">
  <g:hiddenField id="roup" name="rol.id" required="" value="1" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: usuarioRolInstance, field: 'tipo', 'error')} required">
  <input type="hidden" name="tipo" value="Interno"/>
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