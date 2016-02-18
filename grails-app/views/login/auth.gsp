<!--
    Document   : auth
    Created on : 13/06/2012
    Author     : Josué Mtz.
    Description:
        Modificación de la vista del inicio de sesión.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
  <title>Control De Reuniones - Inicio de Sesión</title>

  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

  <link rel="stylesheet" href="${resource(dir: 'css', file: 'sesion.css')}" type="text/css">

</head>

<body>

  <form action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
    <div id="contenedorSesion">

      <div id="bannerSesion">

        <table border="0" style=" width: 100%; position: relative; top: 2px;">
          <tr>
            <td style="color: white; font-weight: bold">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              Control De Reuniones - Acceso
            </td>
            <td></td>
            <td align="right">
              <img src="${resource(dir:'images/general',file:'login.png')}" width="33px" height="33px" alt="">&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
          </tr>
        </table>

      </div>

      <g:if test='${flash.message}'>
        <div class='errors'>${flash.message}</div>
      </g:if>

      <div id="cuerpoSesion">
        <table width="94%" border="0" style="position: relative; left: 15px; top: 24px;">
          <tr>
            <td width="18%" align="right" style="color: #0B243B; font-weight: bold; font-size: 12px;">Usuario:</td>
            <td width="55%"><input name='j_username' id='username' type="text" value="" class="textSesion" size="20" tabindex="10"/></td>
            <td width="27%" rowspan="3">
              <div id="bInicioSesion" class="bIniSesion" onclick="entrar();">
                <span>Entrar</span>
              </div>
            </td>
          </tr>
          <tr>
            <td align="right" style="color: #0B243B; font-weight: bold; font-size: 12px;">Contraseña:</td>
            <td><input name='j_password' id='password' type="password" value="" class="textSesion" size="20" tabindex="20"/></td>
          </tr>
        </table>

      </div>

      <div id="pieSesion"></div>

    </div>
  </form>

<script type='text/javascript'>
	<!--
	(function() {
          document.forms['loginForm'].elements['j_username'].focus();
	})();
	// -->

        function entrar(){
          document.forms['loginForm'].submit();
        }

        document.onkeypress=function(e){
          var esIE=(document.all);
          var esNS=(document.layers);
          tecla=(esIE) ? event.keyCode : e.which;
          if(tecla==13){
            document.forms['loginForm'].submit();
          }
        }

</script>

</body>
</html>
