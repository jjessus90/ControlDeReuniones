<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import = "LoginController" %>


<html>

  <sec:ifNotLoggedIn>
    <%
      LC = new LoginController()
      LC.index()
    %>
  </sec:ifNotLoggedIn>


  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Menú Principal - Control De Reuniones</title>

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
    <!--[if IE]>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'ie.css')}" type="text/css">
    <![endif]-->
    

    <script type='text/javascript'>
      function flechas(acc, obj){
        if(acc == 1){
          document.getElementById('flecha_0').style.display = 'none';
          for(var a = 1; a <=3; a++){
            if(a != obj){
              document.getElementById('flecha_'+a).style.display = 'none';
            }else{
              document.getElementById('flecha_'+a).style.display = 'block';
            }

          }
        }else{
          document.getElementById('flecha_0').style.display = 'block';
          for(var a = 1; a <=3; a++){
            document.getElementById('flecha_'+a).style.display = 'none';
          }
        }
        
      }
    </script>


  </head>
  <body>

    <div id="contenedorGral">

      <div id="banner">
       <div id="logoUtez"><img src="${resource(dir:'images/general',file:'Logo-Gubernatura.png')}" width="185px"/></div>
        <div id="titulo" style="color: white; font-weight: bold; font-size: 26px;">Control De Reuniones</div>
      </div>

      <div id="cuerpoPrincipalMenus">
        <div id="subBanner">
        <table border="0" style="margin-left: auto; color:white; font-weight: bold; font-size: 12px;">
          <tr>
            <td style="padding-right:50px;"><b><sec:loggedInUserInfo field="username"/></b></td>

            <td style="padding-right:60px;">
          <g:link controller="Logout">
            <img alt="" title="Cerrar sesión" src="${resource(dir:'images/general',file:'logOutCDR.png')}" width="16px" height="16px"/>
          </g:link>
          </td>
          </tr>
        </table> 
      </div>

      <!--[if IE]>
      
      <div id="subBannerIE">
        <table border="0" style="margin-left: auto; color:white; font-weight: bold; font-size: 12px;" align="right">
          <tr>
            <td style="padding-right:50px;"><b><sec:loggedInUserInfo field="username"/></b></td>

            <td style="padding-right:60px;">
          <g:link controller="Logout">
            <img alt="" title="Cerrar sesión" src="${resource(dir:'images/general',file:'logOutCDR.png')}" width="16px" height="16px"/>
          </g:link>
          </td>
          </tr>
        </table> 
      </div>
      
      <![endif]-->
        
        <ul id="menuPrincipal">

        <img  src="${resource(dir:'images/menu',file:'prueba.png')}" alt="" id="prueba">

        <img  src="${resource(dir:'images/menu',file:'flechaCero.png')}" alt="" id="flecha_0">

        <img  src="${resource(dir:'images/menu',file:'flechaA.png')}" alt="" id="flecha_1">

        <img  src="${resource(dir:'images/menu',file:'flechaDer22.png')}" alt="" id="flecha_2">
             
        <img  src="${resource(dir:'images/menu',file:'flechaIzq2.png')}" alt="" id="flecha_3">

           <!-- De aquí en adelante se pondrá el contenido del GSP -->
        <br>
        
          
          
          <li class="regMinutasr" onmouseover="flechas(1, 1);"  onmouseout="flechas(0, 1);">
          <g:link url="[action:'list',controller:'minuta']"><b>
                <span class="opcMenu">Registro de Minutas</span>
                <br><br>
                <span class="descMenu">Registro de las minutas para las reuniones.</span></b>
          </g:link>
          </li>
          <li class="segAcuerdosr" onmouseover="flechas(1, 3);"  onmouseout="flechas(0, 3);">
          <g:link url="[action:'list',controller:'SeguimientoMinuta']"><b>
                <span class="opcMenu">Seguimiento de Acuerdos</span>
                <br><br>
                <span class="descMenu">Seguimiento de acuerdos definidos en las minutas.</span></b>
          </g:link>
          </li>
          <li class="historialr" onmouseover="flechas(1, 2);"  onmouseout="flechas(0, 2);">
          <g:link url="[action:'lista',controller:'Historial']"><b>
                <span class="opcMenu">Historial de Minutas</span>
                <br><br>
                <span class="descMenu">Consulta del histórico de las minutas registradas.</span></b>
          </g:link>
          </li>
        </ul>

        <div id="descripciones">
          <table cellpadding="0" cellspacing="0" width="100%" border="0">
            <tr><td align="left">Menú</td></tr>
            <tr><td align="right">Principal</td></tr></table>
        </div>

        <div id="apoyo"></div>

        <!-- Fin del contenido del GSP -->
        
      </div>

      <div id="pie">
        <div align="center" style="margin-right: 25px;">
          <img style="margin-top:4px;" height="35px" src="${resource(dir:'images/general',file:'CDS.png')}" width="60px"/>
        </div>
      </div>

    </div>

  </body>
</html>
