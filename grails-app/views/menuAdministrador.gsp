<!--
    Document   : auth
    Created on : 15/06/2012
    Author     : Josué Mtz.
    Description:
        Creación del menú del administrador de la aplicación.
-->

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
        for(var a = 1; a <=5; a++){
          if(a != obj){
            document.getElementById('flecha_'+a).style.display = 'none';
          }else{
            document.getElementById('flecha_'+a).style.display = 'block';
          }

        }
      }else{
        document.getElementById('flecha_0').style.display = 'block';
        for(var a = 1; a <=5; a++){
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

        <img  src="${resource(dir:'images/menu',file:'flechaIS.png')}" alt="" id="flecha_2">

        <img  src="${resource(dir:'images/menu',file:'flechaDS.png')}" alt="" id="flecha_3">

        <img  src="${resource(dir:'images/menu',file:'flechaDI.png')}" alt="" id="flecha_4">

        <img  src="${resource(dir:'images/menu',file:'flechaII.png')}" alt="" id="flecha_5">

        <!-- De aquí en adelante se pondrá el contenido del GSP -->
        <!-- <br>
         <g:link url="[action:'plantilla',controller:'general']">Plantilla Ejemplo</g:link><br>
         <g:link url="[action:'listaControladores',controller:'general']">Index</g:link>
    
            <br></br>
            <br></br>-->
        <li class="regUsuarios" onmouseover="flechas(1, 1);"  onmouseout="flechas(0, 1);">
        <g:link url="[action:'create',controller:'usuario']">
          <b>
            <span class="opcMenu">Administración de Usuarios</span>
            <br><br>
            <span class="descMenu">Registro de los participantes de minutas, así como asignar un usuario y contraseña en caso de ser responsables de minutas.</span></b>
        </g:link>
        </li>
        <!-- <li class="roles" onmouseover="flechas(1, 7);"  onmouseout="flechas(0, 7);">
           <g:link url="[action:'list',controller:'rol']">
           <b>
               <span class="opcMenu">Administración de Roles</span>
               <br><br>
               <span class="descMenu">Registro de los roles a asignar a en la administración de usuarios.</span>
           </b>
           </g:link>
         </li>
         <li id="liPermisos" class="permisos" onmouseover="flechas(1, 2);"  onmouseout="flechas(0, 2);">
           <g:link url="[action:'list',controller:'permiso']"><b>
               <span class="opcMenu">Administración de Permisos</span>
               <br><br>
               <span class="descMenu">Asignación de los permisos de acceso para los roles.</span></b>
           </g:link>
         </li>-->
        <li class="tipoReuniones" onmouseover="flechas(1, 2);"  onmouseout="flechas(0, 2);">
        <g:link url="[action:'crear',controller:'tipoReunion']"><b>
            <span class="opcMenu">Catálogo de Tipo de Reuniones</span>
            <br><br>
            <span class="descMenu">Catálogo del tipo de reuniones para definir en la minuta.</span></b>
        </g:link>
        </li>
        <li class="regMinutas" onmouseover="flechas(1, 3);"  onmouseout="flechas(0, 3);">
        <g:link url="[action:'list',controller:'minuta']"><b>
            <span class="opcMenu">Registro de Minutas</span>
            <br><br>
            <span class="descMenu">Registro de las minutas para las reuniones.</span></b>
        </g:link>
        </li>
        <li class="segAcuerdos" onmouseover="flechas(1, 5);"  onmouseout="flechas(0, 5);">
        <g:link url="[action:'list',controller:'SeguimientoMinuta']"><b>
            <span class="opcMenu">Seguimiento de Acuerdos</span>
            <br><br>
            <span class="descMenu">Seguimiento de acuerdos definidos en las minutas.</span></b>
        </g:link>
        </li>
        <li class="historial" onmouseover="flechas(1, 4);"  onmouseout="flechas(0, 4);">
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
          <tr><td align="right">Principal</td></tr>
        </table>
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
