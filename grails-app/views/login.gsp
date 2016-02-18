<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'sesion.css')}" type="text/css">

    <title>Inicio de Sesión - Control De Reuniones</title>
    
  </head>
  <body>
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

      <div id="cuerpoSesion">
        <table width="94%" border="0" style="position: relative; left: 15px; top: 24px;">
          <tr>
            <td width="18%" align="right" style="color: #0B243B; font-weight: bold; font-size: 12px;">Usuario:</td>
            <td width="55%"><input type="text" value="" class="textSesion" size="20" tabindex="10"/></td>
            <td width="27%" rowspan="3">
              <div id="bInicioSesion" class="bIniSesion">
                <span>Entrar</span>
              </div>
            </td>
          </tr>
          <tr>
            <td align="right" style="color: #0B243B; font-weight: bold; font-size: 12px;">Contraseña:</td>
            <td><input type="password" value="" class="textSesion" size="20" tabindex="20"/></td>
          </tr>
        </table>

      </div>
      
      <div id="pieSesion"></div>

    </div>

  </body>

</html>
