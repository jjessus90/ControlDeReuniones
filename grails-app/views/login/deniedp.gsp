<head>
<meta name='layout' content='main' />
 <link rel="stylesheet" href="${resource(dir: 'css', file: 'sesion.css')}" type="text/css">
<title><g:message code="springSecurity.denied.title" /></title>
</head>

<body>

  
  <div id="contenedorSesion">

      <div id="bannerSesion">

        <table border="0" style=" width: 100%; position: relative; top: 2px;">
          <tr>
            <td style="color: white; font-weight: bold; font-size: 20px;">
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              -Acceso Denegado-
            </td>
           
          </tr>
        </table>

      </div>


      <div id="cuerpoSesion">
        <table width="94%" border="0" style="position: relative; left: 15px; top: 24px;">
          <tr>
            <td style="font-size: 18px;"><center><g:message code="Lo sentimos. Usted no puede entrar a esta área, no tiene control alguno dentro del sistema" />
            <g:formRemote name="regresar" url="[controller:'logout']" 
                          update="[success: 'message', failure: 'error']">
             <input type="submit" value="regresar"></input>
            </g:formRemote></td>
          </center>
            </tr>
        </table>

      </div>
    
  <div id="pieSesion"></div>
</body>
