<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="ControlDeReuniones.Minuta" %>

<html>
  <sec:ifNotLoggedIn>
<%
LC = new LoginController()
LC.index()
%>
  </sec:ifNotLoggedIn>
  <head>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css"/>
    <script type="text/javascript">
     function ocultar(){
        document.getElementById('flasF').style.display = 'none';
     }
     
     function mostrar(){
        document.getElementById('flaso').style.display = 'block';
     }

    function principal()
    {        
      document.getElementById('flasc').style.display = 'block';
        setTimeout("ocultar();",7000);
          
    }
    function cerrar()
    {
      parent.$.fancybox.close()
    }

    window.onload = principal;
      
    </script>

  </head>
  <body style="width:900px; 
        height: auto;
        background:#D8D8D8;
        margin-top:2px;"
        >

    <br>
    <h1 align="center">Seguimiento de Acuerdos</h1>

  <g:if test="${!correoUsuario2}" >
    <div style="background-color: white; width:95%; display: none " id="flasc" class="error" role="status">Seleccione el responsable del acuerdo.</div> 
  </g:if> 
  <g:if test="${flash.message == 'Falló el envío de correo(s). Revise que los correos ingresados estén escritos correctamente o inténtelo más tarde.'}">
    <div style="background-color: white; width:95%;" id="flasF" class="error" role="status">${flash.message}</div>
  </g:if>  
  <g:elseif test="${flash.message == 'Mensaje enviado.'}">
    <div style="background-color: white; width:95%;" id="flasF" class="correcto" role="status">${flash.message}</div>        
    <script type="text/javascript">setTimeout("cerrar();",2000);</script>
  </g:elseif>

  <div style="background-color: white; width:95%; display: none " id="flaso" class="informacion" role="status">Por favor espere, su correo se está enviando...</div>
  <br>

  <g:form method="post" >        
    <table width="600" class="tablaDatos" style="position: relative;" >
      <tr>
        <td style="color: white;" class="tdEncabezado" colspan="2">Envío de correo para el seguimiento de acuerdos abiertos.</td>
      </tr>
      <tr>
      <div >
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:message code="Para: " /></td>
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:textField name="para" value="${correoUsuario2}" size="100" readonly="readonly"  disabled="true"/></td>
      </div>
      </tr>
      <tr>
      <div >
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:message code="CC: " /></td>
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:textField name="cc" value="${correo}, " size="100" /></td>
      </div>
      </tr>
      <tr>
      <div >
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:message code="CCO: " /></td>
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:textField name="cco" value="" size="100" /></td>
      </div>
      </tr>
      <tr>
      <div >
        <td valign="middle" class="tdTipoDatos" style="width:30%; height: 30px;" >&nbsp;</td>
        <td valign="top" class="tdTipoDatos" style="width:30%; font-size: 9px; font-weight: bold;" ><g:message code="En los campos CC y CCO, debe separar los correos por una coma." /></td>
      </div>
      </tr>

      <g:hiddenField name="correo" value="${correo}" />
      <tr>
      <div>
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:message code="Asunto:" /></td>
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:textField name="asuntos" value="${asunto}" readonly="readonly" size="100" disabled="true" /></td>
      </div>
      </tr>
      <tr>
      <div>
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:message code="Mensaje:" /></td>
        <td valign="middle" class="tdTipoDatos" style="width:30%;" ><g:textArea name="mensajes" rows="5" cols="101" value="${msj}" tabindex="1" style="resize: none; overflow: auto;"/></td>
      </div>
      </tr>
      <tr>
      <div>
        <td colspan="2">
          <fieldset class="buttons">
            <g:actionSubmit type="submit"  value="Enviar" tabindex="2" controller="Correo" onclick="mostrar()" action="correoEnviado" class="forward" />
            <g:hiddenField name="id" id="acuerdo" value="${id}"/>
          </fieldset></td>
      </div>
      </tr>
    </table>
  </g:form>
</body>
</html>
