


<!-- De aquí en adelante se pondrá el contenido del GSP -->

<p>&nbsp;</p>
<ul class="tabs">
  <li><a href="#tab1" onclick="">Datos generales</a></li>
  <li><a href="#tab2" onclick="">Participantes</a></li>
  <li><a href="#tab3" onclick="">Puntos a tratar</a></li>
  <li><a href="#tab4" onclick="">Acuerdos</a></li>
  <li><a href="#tab5" onclick="">Archivos</a></li>
</ul>

<!--==========================Datos Generales===================================-->
<div class="tab_container">
  <div id="tab1" class="tab_content"  style="display: block">



    <table class="tablaDatos" align="center">

      <tr>
        <td class="tdEncabezado" colspan="4">Datos generales de la minuta</td>
      </tr>    
      <tr>
        <td class="tdTipoDatos" width="200px" >
          <label for="Responsable">
            <g:message code="minuta.responsable.label" default="Responsable de reunión:" />
          </label>
        </td>
        <td class="tdDatos trAux" >
      <g:hiddenField name="responsable.id" id="responsable" value="${responsableInstance.id}"/>
      <g:textField name="nombreResponsable" readOnly="readOnly" value="${responsableInstance}"/>
      </td>

      <td class="tdTipoDatos" width="200px">
        <label for="identificador">
          <g:message code="minuta.identificador.label" default="Identificador:" />
          <span class="required-indicator">*</span>
        </label>
      </td>
      <td  class="tdDatos trAux" > 
      <g:textField onChange="limpiarvacios(this)" name="identificador" size="20px" value="${minutaInstance?.identificador}"/>
      <g:hiddenField name="estadoMinuta" value="Creada"/>
      </td>
      </tr>
      <tr>
        <td class="tdTipoDatos" width="200px">
          <label for="tipoReunion">
            <g:message code="minuta.tipoReunion.label" default="Tipo reunión:" />
            <span class="required-indicator">*</span>
          </label>
        </td>
        <td  class="tdDatos trAux">       

            <g:select class="selectEstaticos" style="width:140px" id="tipoReunion"  name="tipoReunion.id" from="${tipoReunionInstance}" optionKey="id"  value="${minutaInstance?.tipoReunion?.id}"/>
        </td>
        <td class="tdTipoDatos" width="200px">
          <label for="lugar">
            <g:message code="minuta.lugar.label" default="Lugar:" />
          </label>
        </td>
        <td  class="tdDatos trAux">    
            <g:textField onKeyPress="limpiarvacios(this)" onChange="limpiarvacios(this)" maxlength="250"  size="20px" name="lugar" value="${minutaInstance?.lugar}"/>        
        </td>              
      </tr>
      <tr>
        <td class="tdTipoDatos" width="200px"> 
          <label for="objetivo">
            <g:message code="minuta.objetivo.label" default="Objetivo:" />
          </label>
        </td>
        <td  class="tdDatos trAux" colspan="4">
      <g:textArea onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" maxlength="950" rows="2" cols="80" id="objetivo" name="objetivo" value="${minutaInstance?.objetivo}"/>
      </td>
      </tr>
      <tr>
        <td class="tdTipoDatos" width="200px">
          <label for="fechaInicio">
            <g:message code="minuta.fechaInicio.label" default="Fecha inicio:" />
          </label> 
        </td>
        <td class="tdDatos trAux"><g:textField name="fechaI" class='campofecha' value="" readonly="readonly"/></td>

      <td class="tdTipoDatos" width="200px">
        <label for="horaInicio">
          <g:message code="minuta.horaInicio.label" default="Hora inicio:" />
        </label>
      </td>
      <td class="tdDatos trAux"><g:textField name="horaInicio" value="" readonly="readonly"/></td>

      </tr>

      <tr>
        <td   class="tdTipoDatos" width="200px">
          <label for="fechaFin">
            <g:message code="minuta.fechaFin.label" default="Fecha fin:" />
          </label> 
        </td>
        <td class="tdDatos trAux"><g:textField name="fechaF" class='campofecha' value="" /></td>
      <td class="tdTipoDatos" width="200px">
        <label for="horaFin">
          <g:message code="minuta.horaFin.label" default="Hora fin:" />
        </label>
      </td>
      <td class="tdDatos trAux"><g:textField name="horaFin" value="" readonly="readonly"/></td>
      </tr>
    </table>

  </div>
  <!--=============================Fin==========================================-->

  <!--==========================Participantes===================================-->

  <div id="tab2" class="tab_content">
    <table class="tablaPart tablaDatos" id="tablaParticipante" align="center" style="text-align:center;" width="300px">
      <tr class="trAux">
        <td class="tdEncabezado" width="185"><g:select class="selectFiltroEstatico" style="display:none; width:300px;" id="selecciona" optionKey="id" name="usuari" from="${usuarioInstance}" value=""></g:select>Participantes</td>     
      <td class="tdEncabezado" aling="left">
        <a  onClick="agregarCamposParticipantes()" value="agregarusuario"><image src="/ControlDeReuniones/images/general/agregar.png" width="20px"/></a>            
      </td>
      </tr>  

      <tr class="trAux">
        <td class="tdDatos">
          <select class="selectFiltroEstaticos" style="width:300px;" id="seleccionar" disabled="true" name="usuario">
            <g:each in="${usuarioInstance}" status="i" var="usuario">
              <g:if test="${responsableInstance.id == usuarioInstance[i].id}">
                <option value="${usuarioInstance[i].id}" selected="selected">${usuarioInstance[i].nombre}</option>
              </g:if>
              <g:else>
                <option value="${usuarioInstance[i].id}">${usuarioInstance[i].nombre}</option>
              </g:else>
            </g:each>
          </select>
      <g:hiddenField name="usuario" id="responsable" value="${sec.loggedInUserInfo(field:'id')}" readonly="readonly"/>
      </td>   
      <td class="tdDatos"></td>
      </tr>
    </table>


    <div style="height:50px">   
    </div>

    <table class="tablaDatos" id="tablaExterno" align="center" style="text-align: center">
      <tr class="trAux">

        <td class="tdEncabezado" width="175">Nombre del externo</td>
        <td class="tdEncabezado" width="175">Correo electrónico</td>
        <td class="tdEncabezado" width="175">Organización</td>
        <td class="tdEncabezado" width="175">Puesto</td>
        <td class="tdEncabezado">
          <a  onClick="agregarCamposExterno()" value="agregarusuario"><image src="/ControlDeReuniones/images/general/agregar.png" width="20px"/></a> 
        </td>
      </tr>
    </table>

  </div>
  <!--=============================Fin==========================================-->

  <!--==========================Puntos a Tratar=================================-->


  <div id="tab3" class="tab_content">
    <table id="tablaPuntos" class="tablaDatos" align="center" style="text-align: center; width:500px; ">
      <tr >
        <td class="tdEncabezado" width="175">Puntos a tratar</td>
        <!--<td class="tdEncabezado" width="100">Eliminar</td>-->
        <td class="tdEncabezado" width="100"></td> 
        <td class="tdEncabezado" aling="left">
          <a  onClick="agregarCamposPuntos()" value="agregarusuario"><image src="/ControlDeReuniones/images/general/agregar.png" width="20px"/></a>            
        </td>
      </tr>

      <tr class="trAux">
        <td class="tdDatos"> <g:textArea onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" rows="2" cols="79" maxlength="950" size="15" id="pTratar_0" name="pTratar" value="${fieldValue(bean: puntoTratar, field: "puntoTratar")}"/> </td>
      <td class="tdDatos"><a href='#'><img src='/ControlDeReuniones/images/general/limpiar.png' id='0' onclick='limpiarPuntos(id)' width='30px'/></a></td>
      <td class="tdDatos"></td>
      </tr>
    </table>
    <br>
    <br>
  </div>
  <br>
  
  <!--=============================Fin==========================================-->


  <!--===========================Acuerdo========================================-->
  <div id="tab4" class="tab_content">
    <table id="tablaAcuerdo" class="form-gerados tablaDatos" >
      <tr>
        <td class="tdEncabezado" width="200">Descripción</td>
        <td class="tdEncabezado" width="200">Responsable</td>
        <td class="tdEncabezado" width="200">Fecha de compromiso</td>
        <td class="tdEncabezado" width="194">Estado</td>
        <td class="tdEncabezado" style="display:none" width="200px">Correo</td>
        <td class="tdEncabezado"></td>
      </tr>
    </table>


    <fieldset style="text-align:center">
      <p>Para agregar acuerdos, primero tiene que guardar la minuta.</p>
    </fieldset> 
  
  </div>
 <!--==========================Archivos==============================-->

    <div id="tab5" class="tab_content">
      <fieldset style="text-align:center">
        <p>Para agregar archivos, primero tiene que guardar la minuta.</p>
      </fieldset>    
    </div>

 <!--========================FIN ARCHIVOS==============================-->
 
  <p>&nbsp;</p>

  <fieldset class="buttons">
    <g:submitButton name="crear" class="save" value="Guardar"/>
    <input id="inicioMinuta" style="display:inline;" class="iniMinuta" type="button" name="inicio" value="Iniciar minuta" onclick="horaFechaInicio()" />
    <g:actionSubmit class="finMinuta" name="fin"  value="Finalizar minuta"  controller="minuta" action="save" onclick="horaFechaFin(),validar(fm)" id="finalizarMinuta" style="display: none;"/>
    <a href="${createLink(uri: '/Minuta/list')}" class="list" aling="center"><g:message code="Ir a gestión de minutas"/></a>
  </fieldset>

  </div>
  
<!--=============================Fin==========================================-->

<!-- Fin del contenido del GSP -->
