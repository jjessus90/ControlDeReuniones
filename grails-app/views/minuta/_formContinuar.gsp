<%String Path=request.getRealPath("//");%>


<!-- De aquí en adelante se pondrá el contenido del GSP -->


<p>&nbsp;</p>
<ul class="tabs">
  <li><a href="#tab1" onclick="">Datos generales</a></li>
  <li><a href="#tab2" onclick="">Participantes</a></li>
  <li><a href="#tab3" onclick="">Puntos a tratar</a></li>
  <li id="four"><a href="#tab4" onclick="">Acuerdos</a></li>
  <li><a href="#tab5" onclick="">Archivos</a></li>
</ul>
<!--///////////////////////////////Inicio/////////////////////////////////////--> 
<g:if test="${minutaInstance.estadoMinuta == "Finalizada" ||minutaInstance.estadoMinuta == "Cerrada" ||minutaInstance.estadoMinuta == "Cancelada"}" >

  <div class="tab_container">
    <div id="tab1" class="tab_content"  style="display: block">

      <table class="tablaDatos" align="center">

        <tr>
          <td class="tdEncabezado"  colspan="4">Datos generales de la minuta</td>
        </tr> 
        <tr>
          <td class="tdTipoDatos" width="200px" >  
        <g:message code="minuta.responsable.label" default="Responsable de reunión:" />
        </td>
        <td class="tdDatos trAux">
        <g:textField name="responsable.nombre" id="responsable"  value="${minutaInstance.responsable}"  disabled="true"/>
        <g:hiddenField name="responsable.id" id="responsable" value="${minutaInstance.responsable.id}"/>
        </td>
        <td class="tdTipoDatos" width="200px" >
        <g:message code="minuta.identificador.label" default="Identificador:" />
        <span class="required-indicator">*</span>
        </td>
        <td class="tdDatos trAux">
        <g:textField name="identificador" value="${minutaInstance?.identificador}" disabled="true"/>
        <g:hiddenField name="identificador" value="${minutaInstance?.identificador}"/>
        <g:hiddenField name="estadoMinuta" value="${minutaInstance?.estadoMinuta}"/>
        </td>
        </tr>       
        <tr>
          <td class="tdTipoDatos" width="200px" >
        <g:message code="minuta.tipoReunion.label" default="Tipo reunión:" />
        <span class="required-indicator">*</span>
        </td>
        <td class="tdDatos">
        <g:select class="selectEstaticos" style="width:140px" id="tipoReunion" name="tipoReunion.id" from="${ControlDeReuniones.TipoReunion.list()}" optionKey="id" value="${minutaInstance?.tipoReunion?.id}" disabled="true" />
        <g:hiddenField name="tipoReunion.id" value="${minutaInstance?.tipoReunion?.id}"/>
        </td>
        <td class="tdTipoDatos" width="200px">
        <g:message code="minuta.lugar.label" default="Lugar:" />
        </td> 
        <td class="tdDatos trAux">
        <g:textField name="lugar" value="${minutaInstance?.lugar}" disabled="true"/>
        <g:hiddenField name="lugar" value="${minutaInstance?.lugar}"/>
        </td>            
        </tr>
        <tr>
          <td class="tdTipoDatos" width="200px">
        <g:message  code="minuta.objetivo.label" default="Objetivo:" />
        </td>
        <td colspan="3" class="tdDatos trAux">
        <g:textArea rows="2" cols="72" name="objetivo"  value="${minutaInstance?.objetivo}" disabled="true"/>
        <g:hiddenField name="objetivo" value="${minutaInstance?.objetivo}"/>
        </td>
        </tr>
        <tr>
          <td class="tdTipoDatos" width="200px" >       
        <g:message code="minuta.fechaInicio.label" default="Fecha inicio:" />
        </td>
        <td class="tdDatos trAux">
        <g:textField name="fechaI" value="${minutaInstance?.fechaInicio.format("dd/MM/yyyy")}" disabled="true" />
        <g:hiddenField name="fechaI" value="${minutaInstance?.fechaInicio.format("dd/MM/yyyy")}"/>
        </td>
        <td class="tdTipoDatos" width="200px" >
        <g:message code="minuta.horaInicio.label" default="Hora inicio:" />
        </td>
        <td class="tdDatos trAux">
        <g:textField name="horaInicio" value="${minutaInstance?.horaInicio}" disabled="true" />
        <g:hiddenField name="horaInicio" value="${minutaInstance?.horaInicio}"/>
        </td>
        </tr>
        <tr>
          <td class="tdTipoDatos" width="200px" >
        <g:message code="minuta.fechaFin.label" default="Fecha fin:" />
        </td>
        <td class="tdDatos trAux">
        <g:textField name="fechaF" value="${minutaInstance?.fechaFin.format("dd/MM/yyyy")}" disabled="true" /> 
        <g:hiddenField name="fechaF" value="${minutaInstance?.fechaFin.format("dd/MM/yyyy")}"/>
        </td>
        <td class="tdTipoDatos" width="200px">
        <g:message code="minuta.horaFin.label" default="Hora fin:" />
        </td>
        <td class="tdDatos trAux">
        <g:textField name="horaFin" value="${minutaInstance?.horaFin}" disabled="true" />
        <g:hiddenField name="horaFin" value="${minutaInstance?.horaFin}"/>
        </td>    
        </tr>
      </table>
      <br>
      <br>
    </div>
    <!--===========================Fin========================================-->

    <!--===========================Participantes==============================-->
    <div id="tab2" class="tab_content" align="center">
      <table class="tablaDatos" id="tablaParticipante" style="text-align: center">
        <tr class="tdEncabezado">
          <td width="175" class="tdEncabezado">Participantes</td>
        </tr> 

        <g:each in="${usuarioInstance}" status="i" var="usuario">
          <g:if test="${usuarioInstance.tipo[i]=="Interno"}">
            <tr class="trAux">
              <td class="tdDatos">
            <g:select style="width:300px" class="selectEstaticos" id="seleccionar" optionKey="id" name="usuario" from="${usuarioInternoInstance}" value="${usuarioInstance.id[i]}" disabled="true"/>
            <g:hiddenField name="usuario" id="responsable" value="${usuarioInstance.id[i]}" readonly="readonly"/>
            </td>
            <td class="tdDatos">
            </td>
            </tr>     
          </g:if>
        </g:each>
      </table>
      <div style="height:50px">   
      </div>
      <table class="tablaDatos" id="tablaExterno" align="center" style="text-align: center">
        <tr >
          <td class="tdEncabezado" width="175">Nombre del externo</td>
          <td class="tdEncabezado" width="175">Correo electrónico</td>
          <td class="tdEncabezado" width="175">Organización</td>
          <td class="tdEncabezado" width="175">Puesto</td> 
        </tr>
        <g:each in="${usuarioInstance}" status="i" var="usuario">
          <g:if test="${usuarioInstance.tipo[i]=="Externo"}">
            <tr class="trAux">
              <td class="tdDatos">
                <input type="text" size="20" name="nombreExterno" disabled="true" value="${usuarioInstance.nombre[i]}">
            <g:hiddenField name="nombreExterno"  value="${usuarioInstance.nombre[i]}" readonly="readonly"/>
            </td>
            <td class="tdDatos">
              <input type="text" size="20"   name="emailExterno" disabled="true" value="${usuarioInstance.correoElectronico[i]}">
            <g:hiddenField name="emailExterno" id="responsable" value="${usuarioInstance.correoElectronico[i]}" readonly="readonly"/>
            </td>
            <td class="tdDatos">
              <input type="text" size="20"  disabled="true" name="organizacionExterno" value="${usuarioInstance.organizacion[i]}">
            <g:hiddenField name="organizacionExterno" id="organizacionExterno_${i}" value="${usuarioInstance.organizacion[i]}" readonly="readonly"/>
            </td>
            <td class="tdDatos"> 
              <input type="text" size="20"   disabled="true" name="puesto" value="${usuarioInstance.puesto[i]}">
            <g:hiddenField name="puesto" id="puesto_${i}" value="${usuarioInstance.puesto[i]}" readonly="readonly"/>
            </td>         
            </tr>     
          </g:if>
        </g:each>
      </table>
    </div>
    <!--===========================Fin===================================-->


    <!--=======================Puntos a Tratar==========================-->
    <div id="tab3" name="tab3" class="tab_content">
      <table id="tablaPuntos" class="tablaDatos" align="center" style="text-align: center">
        <tr>
          <td class="tdEncabezado"  width="175">Puntos a tratar</td>
        </tr>
        <g:each in="${puntosTratarInstance}" status="i" var="puntoTratar">
          <tr class="trAux">
            <td class="tdDatos"><g:textArea onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" rows="2" cols="79" id="pTratar_${i+1}" name="pTratar" value="${puntosTratarInstance[i].puntoTratar}" disabled="true"/>
              <g:hiddenField name="pTratar" value="${puntosTratarInstance[i].puntoTratar}"/>
              <script type="text/javascript">contadorPunto(${i+1})</script>
            </td>
          
          </tr>
        </g:each>
      </table>
    </div>
    <div id="tab4" class="tab_content">
      <!--===========================Fin========================================-->
      
      <!--===========================Acuerdos===================================-->
      <table id="tablaAcuerdo" class="form-gerados tablaDatos" align="center" style="text-align: center">
        <tr>
          <td class="tdEncabezado" width="400px">Descripción</td>
          <td class="tdEncabezado" width="170px">Responsable(s)</td>
          <td class="tdEncabezado" width="170px">Corresponsables</td>
          <td class="tdEncabezado" width="80px">Fecha de compromiso</td>
          <td class="tdEncabezado" width="80px">Estado</td>
          <td class="tdEncabezado" width="30px">Correo</td>
        <!--
          <td class="tdEncabezado" width="445px">Descripción</td>
          <td class="tdEncabezado" width="195px">Responsable(s)</td>
          <td class="tdEncabezado" width="195px">Corresponsables</td>
          <td class="tdEncabezado" width="90px">Fecha de compromiso</td>
          <td class="tdEncabezado" width="90px">Estado</td>
          <td class="tdEncabezado" width="40px">Correo</td>-->
        </tr>

        <g:each in="${acuerdoInstance}" status="i" var="acuerdo">
          <tr class="trAux" >
            <td class="tdDatos">
              <g:textArea onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" rows="3" cols="50" id='descripcion_${i}' disabled="true" name='descripcionAcuerdo' value="${acuerdoInstance[i].descripcionAcuerdo}"/>
              <g:hiddenField name="descripcionAcuerdo" id="responsable" value="${acuerdoInstance.descripcionAcuerdo[i]}" readonly="readonly"/>
            </td>         
            <td  class="tdDatos" id="seleccionAcuerdo">
              <g:select style="width:150px" class="seleccionarAcuerdo" id="seleccionarAcuerdo_${i}" multiple="multiple" onChange="contar(this)" optionKey="id" name="usuarioAcuerdo" from="${usuarioInstance}" value="${acuerdoInstance[i].usuario}"/>
              <g:select style="display: none;" id="usuarioAcuerdoNum" multiple="multiple" optionKey="id" name="usuarioAcuerdoNum" from="${usuarioInstance}" value="${acuerdoInstance[i].usuario}"/>
              <g:hiddenField id="numseleccionarAcuerdo_${i}" value="${acuerdoInstance[i].usuario.size()}" name="numUsuarioAcuerdo"/>
            </td>
            <td  class="tdDatos" id="seleccionAcuerdos">
          
            </td>
            <td class="tdDatos">
              <g:textField onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" size='15' class='campofecha' id='fecha_${i}' readonly="readonly" name='fechaCompromiso' value="${acuerdoInstance[i].fechaCompromiso.format('dd/MM/yyyy')}"/>
            </td>
            <td class="tdDatos">
              <g:select class="selectEstaticos" name="estado" id="estado_${i}" from="${acuerdoLista.constraints.estado.inList}" value="${acuerdoInstance[i].estado}" />
            </td>
            <td class="tdDatos"> <a id='correo' href='/ControlDeReuniones/correo/correo/${acuerdoInstance[i].id}'><image src='/ControlDeReuniones/images/general/correo.png'width='30px'/></a>
             <script type="text/javascript">contadorAcuerdo(${i})</script> 
            </td>           
          </tr>   
          <tr>
            <td><h4>Seguimiento</h4></td>
            <td class="tdDatos" colspan="3"><g:textArea name='seguimiento'  value='${acuerdoInstance[i].seguimiento}'></g:textArea></td>
          </tr>
          
         
        </g:each>
      </table>

      <p>&nbsp;</p>
    </div>
    <p>&nbsp;</p>  
    <fieldset class="buttons">
      <table>
        <tr>
          <td>
        <g:if test="${minutaInstance.estadoMinuta == "Finalizada"}">
          <g:actionSubmit action="update" name="crear" class="save" value="Guardar" />
          <a href="${createLink(uri: '/Minuta/list')}" class="list" aling="center"><g:message code="Ir a gestión de minutas"/></a>
          <a href="${createLink(uri: '/SeguimientoMinuta/list')}" class="list" aling="center"><g:message code="Ir a seguimiento de acuerdos"/></a>
        </g:if>
        <g:else>
          <a href="javascript:window.history.back();" class="list" aling="center"><g:message code="Volver a la búsqueda"/></a>
        </g:else>
        </td>

        <td>
          <div style="display: none;">
            <g:jasperReport jasper="Minuta" format="DOCX,PDF" name="Imprimir minuta ">
            </g:jasperReport>
          </div>
          <div align="right">
            <g:jasperReport jasper="Minuta" format="DOCX,PDF" name="Imprimir minuta">
              <input  type ="hidden" name="minuta" value ="${minutaInstance?.id}"/>
              <input  type ="hidden" name="RUTA" value="${Path}/reports//" />
            </g:jasperReport>
          </div>
        </td>
        <td>
          
        </td>
        </tr> 

      </table>
    </fieldset>
  </div>
</g:if>  
<g:else> 
  <!--///////////////////////////////Finalizada/////////////////////////////////////--> 
  <!--//////////////////////////////////Fin/////////////////////////////////////////-->  


  <!--=======================Datos Generales===========================-->
  <div class="tab_container">
    <div id="tab1"  class="tab_content"  style="display: block">

      <table class="tablaDatos">

        <tr>
          <td  class="tdEncabezado" colspan="4">Datos generales de la minuta</td>
        </tr>       
        <tr>
          <td class="tdTipoDatos" width="200px" >  
            <label for="Responsable">
              <g:message code="minuta.responsable.label" default="Responsable de reunión:" />
            </label>
          </td>
          <td  class="tdDatos trAux">
        <g:textField onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" name="responsable.nombre" id="responsable" readonly="readonly" value="${minutaInstance.responsable}" />
        <g:hiddenField name="responsable.id" id="responsable" value="${minutaInstance.responsable.id}"/>
        </td>
        <td  class="tdTipoDatos" width="200px">
          <label for="identificador">
            <g:message code="minuta.identificador.label" default="Identificador:" />
            <span class="required-indicator">*</span>
          </label>
        </td>
        <td class="tdDatos trAux">
        <g:textField onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" name="identificador" required="" size="20px" value="${minutaInstance?.identificador}" readonly="readonly" />
        <g:hiddenField name="estadoMinuta" value="${minutaInstance?.estadoMinuta}"/>
        </td>
        </tr>       
        <tr>
          <td class="tdTipoDatos" width="200px">
            <label for="tipoReunion">
              <g:message code="minuta.tipoReunion.label" default="Tipo reunión:" />
              <span class="required-indicator">*</span>
            </label>
          </td>
          <td class="tdDatos trAux">
        <g:select style="width:140px" id="tipoReunion" name="tipoReunion.id" from="${tipoReunionInstance}" optionKey="id" required="" value="${minutaInstance?.tipoReunion?.id}" class="selectEstaticos"  />
        </td>
        <td class="tdTipoDatos" width="200px">
          <label for="lugar">
            <g:message code="minuta.lugar.label" default="Lugar:" />
          </label>
        </td> 
        <td  class="tdDatos trAux">
        <g:textField onKeyUp="limpiarvacios(this),quitar(this)"  onChange="limpiarvacios(this)"   class="vacioL" id="lugar1" maxlength="250" name="lugar" size="20px" value="${minutaInstance?.lugar}" />
        </td>            
        </tr>
        <tr>
          <td   class="tdTipoDatos" width="200px">
            <label for="objetivo">
              <g:message code="minuta.objetivo.label" default="Objetivo:" />
            </label>
          </td>
          <td class="tdDatos trAux" colspan="3">

        <g:textArea onKeyUp="limpiarvacios(this),quitar(this)" onChange="limpiarvacios(this)"  class="vacioL" maxlength="950" rows="2" cols="80" class="vacioL" id="objetivo" name="objetivo" value="${minutaInstance?.objetivo}" />

        </td>

        </tr>

        <tr>
          <td class="tdTipoDatos" width="200px">
            <label for="fechaInicio">
              <g:message code="minuta.fechaInicio.label" default="Fecha inicio:" />
            </label>
          </td>
          <td class="tdDatos trAux">
        <g:if test="${minutaInstance?.fechaInicio != null}">
          <g:textField onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" name="fechaI" size="20px" class='campofecha' value="${minutaInstance?.fechaInicio.format("dd/MM/yyyy")}" />
        </g:if>
        <g:else>
          <g:textField onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" name="fechaI" value="" class='campofecha' />
        </g:else>

        </td>
        <td class="tdTipoDatos" width="200px">
          <label for="horaInicio">
            <g:message code="minuta.horaInicio.label" default="Hora inicio:" />
          </label>
        </td>
        <td class="tdDatos trAux">
        <g:textField onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" name="horaInicio" size="20px" value="${minutaInstance?.horaInicio}" readonly="readonly"/>
        </td>
        </tr>

        <tr>
          <td  class="tdTipoDatos" width="200px">
            <label for="fechaFin">
              <g:message code="minuta.fechaFin.label" default="Fecha fin:" />
            </label>
          </td>
          <td class="tdDatos trAux"> 
        <g:if test="${minutaInstance?.fechaFin != null}">
          <g:textField onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" name="fechaF" value="${minutaInstance?.fechaFin.format("dd/MM/yyyy")}" class='campofecha'/>
        </g:if>
        <g:else>
          <g:textField onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" name="fechaF" value="" class='campofecha'/>
        </g:else>           
        </td>


        <td   class="tdTipoDatos" width="200px">
          <label for="horaFin">
            <g:message code="minuta.horaFin.label" default="Hora fin:" />
          </label>
        </td >
        <td  class="tdDatos trAux">
        <g:textField onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" name="horaFin" value="${minutaInstance?.horaFin}" readonly="readonly" />
        </td>    
        </tr>
      </table>
      <br>
      <br>
    </div>   
    <!--===========================Fin========================================-->


    <!--===========================Participantes==============================-->
    <div id="tab2" class="tab_content">
      <table id="tablaParticipante" class="tablaPart tablaDatos" align="center" style="text-align: center" width="300px">
        <tr>
          <td class="tdEncabezado" width="175"><g:select class="selectPartEstatico" style="display:none; width:300px;" id="selecciona" optionKey="id" name="usuari" from="${usuarioInternoInstance}" value=""></g:select>Participantes</td>

        <td class="tdEncabezado" aling="left">
          <a onClick="agregarCamposParticipantes()" value="agregarusuario"><image src="/ControlDeReuniones/images/general/agregar.png" width="20px"/></a>            
        </td>

        </tr> 
        <g:set var="contador" value="${0}"/>

        <g:each in="${usuarioInstance}" status="i" var="usuario">
          <g:if test="${usuarioInstance.tipo[i]=="Interno"}">

            <g:if test="${usuarioInstance.id[i]==minutaInstance.responsable.id}">
              <tr class="trAux">

                <td class="tdDatos " id="seleccion">
              <g:select style="width:300px" class="selectFiltroEstatico" name="usuariodis" from="${usuarioInternoInstance}" optionKey="id" value="${minutaInstance.responsable.id}" disabled="true"></g:select>
              <g:hiddenField name="usuario" id="responsable" value="${minutaInstance.responsable.id}" readonly="readonly"/>
              </td>
              <td class="tdDatos"></td>

              </tr>     
            </g:if>
            <g:else>  
              <tr class="trAux">
                <td  class="tdDatos" id="seleccion">
              <g:select class="selectFiltroEstatico" style="width:300px" id="selectFiltroEstatico_${i}" optionKey="id" name="usuario" from="${usuarioInternoInstance}" value="${usuarioInstance.id[i]}"></g:select>   
              <td class="tdDatos" ><a onclick='eliminarUsuario(this)' href='#'><image src='/ControlDeReuniones/images/general/eliminar.png' width='30px' /></a>
                <script type="text/javascript">${contador=contador+1}</script>
              </td>
              
              <td class="tdDatos"></td>
              </tr>     
            </g:else>
          </g:if>
        </g:each>

      </table>
      <div style="height:50px">

      </div>

      <table id="tablaExterno"  class="tablaDatos" align="center" style="text-align: center">
        <tr >

          <td class="tdEncabezado" width="175">Nombre del externo</td>
          <td class="tdEncabezado" width="175">Correo electrónico</td>
          <td class="tdEncabezado" width="175">Organización</td>
          <td class="tdEncabezado" width="175">Puesto</td>        
          <td class="tdEncabezado" >
            <a  onClick="agregarCamposExterno()" value="agregarusuario"><image src="/ControlDeReuniones/images/general/agregar.png" width="20px"/></a> 
          </td>
        </tr>



        <g:each in="${usuarioInstance}" status="i" var="usuario">
          <g:if test="${usuarioInstance.tipo[i]=="Externo"}">
            <tr class="trAux">


              <td class="tdDatos" ><input onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" type="text" size="20" id="nombreExterno_${i}" name="nombreExterno" value="${usuarioInstance.nombre[i]}"></td>
              <td class="tdDatos" ><input onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" type="text" size="20" id="emailExterno_${i}" name="emailExterno" value="${usuarioInstance.correoElectronico[i]}"></td>
              <td class="tdDatos" ><input onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" type="text" size="20" id="organizacionExterno_${i}" name="organizacionExterno" value="${usuarioInstance.organizacion[i]}"></td>
              <td class="tdDatos" ><input onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" type="text" size="20" id="puesto_${i}" name="puesto" value="${usuarioInstance.puesto[i]}"></td>
              <td class="tdDatos" ><a onclick='eliminarParticipante(this)' href='#'><image src='/ControlDeReuniones/images/general/eliminar.png' width='30px' /></a></td>
              <td>
              </td>
            </tr>     
          </g:if>
        </g:each>
      </table>
    </div>
    <!--===========================Fin===================================-->


    <!--=======================Puntos a Tratar==========================-->
    <div id="tab3" name="tab3" class="tab_content">

      <table id="tablaPuntos" class="tablaDatos" align="center" style="text-align: center">
        <tr>

          <td class="tdEncabezado" width="175">Puntos a tratar</td>

          <td class="tdEncabezado" width="100"></td> 

          <td class="tdEncabezado" aling="left">
            <a  onClick="agregarCamposPuntos()"><img alt="" src="/ControlDeReuniones/images/general/agregar.png" width="20px"/></a>
          </td>
        </tr>
        <g:if test="${puntosTratarInstance}">
          <g:each in="${puntosTratarInstance}" status="i" var="puntoTratar">

            <tr class="trAux">
              <td  class="tdDatos"> <g:textArea onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)"   rows='2' cols='79' maxlength="950" size="15" id="pTratar_${i+1}" name="pTratar" value="${puntosTratarInstance[i].puntoTratar}"/>
              <script type="text/javascript">contadorPunto(${i+1})</script>
              </td>
              <td class="tdDatos"><a href='#'><img src='/ControlDeReuniones/images/general/limpiar.png' id='${i+1}' onclick='limpiarPuntos(id)' width='30px'/></a> </td>
            <td class="tdDatos"> <a onclick='eliminarUsuario(this)' href='#'><image src='/ControlDeReuniones/images/general/eliminar.png' width='30px' /></a>          
            </td>
            </tr>
          </g:each>
        </g:if>
        <g:else>
          <tr class="trAux">

            <td class="tdDatos"> 
              <g:textArea onKeyUp="limpiarvacios(this),quitar(this)" onChange="limpiarvacios(this)" rows='2' cols='79' maxlength="950" size="15" id="pTratar_${1}" name="pTratar" value=""/>
              <script type="text/javascript">contadorPunto(${1})</script>
            </td>
          

          <td class="tdDatos"><a href='#'><img src='/ControlDeReuniones/images/general/limpiar.png' id='${1}' onclick='limpiarPuntos(id)' width='30px'/></a> </td>
          <td class="tdDatos"></td>

          </tr>
        </g:else>
      </table>
    </div>


    <!--===========================Fin========================================-->

    <!--===========================Acuerdos===================================-->
    <div id="tab4" class="tab_content">
      <table border="0" width="860px;" id="tablaAcuerdo" class="form-gerados tablaDatos" align="center" style="text-align: center">
        <tr>

          <td class="tdEncabezado" width="350px">Descripción</td>
          <td class="tdEncabezado" width="170px">Responsable(s)</td>
          <td class="tdEncabezado" width="170px">Corresponsables</td>
          <td class="tdEncabezado" width="80px">Fecha de compromiso</td>
          <td class="tdEncabezado" width="80px">Estado</td>
           <td class="tdEncabezado" width="20px" style="display:none">Correo</td>
          <td class="tdEncabezado" width="20px">

         <!-- <td class="tdEncabezado" width="445px">Descripción</td>
          <td class="tdEncabezado" width="195px">Responsable</td>
          <td class="tdEncabezado" width="90px">Fecha de compromiso</td>
          <td class="tdEncabezado" width="90px">Estado</td>
          <td class="tdEncabezado" width="20px" style="display:none">Correo</td>
          <td class="tdEncabezado" width="20px">
            <!-- Este campo oculto se utiliza para ser clonado en nuevocampo.js para agregar un nuevo acuerdo -->
            <g:select id="seleccionarAcuerd" style="display:none; width:170px" multiple="multiple" onChange="contar(this)" optionKey="id" name="usuarioAcuerdo" from="${usuarioInstance}" value=""></g:select>
          </td>
          <td class="tdEncabezado"  align="left" width="20px">
            <a onClick="agregarCamposAcuerdos()">
              <img alt="" title="Agregar acuerdo" src="/ControlDeReuniones/images/general/agregar.png" width="20px"/>
            </a>
          </td>
        </tr>
    <g:if test="${acuerdoInstance}">
      <g:each in="${acuerdoInstance}" status="i" var="acuerdo">
        <tr class="trAux">
          <td class="tdDatos"> 
            <g:textArea onKeyUp="limpiarvacios(this)" onChange="limpiarvacios(this)" maxlength="950" rows='3' cols='40' id='descripcion_${i}' name='descripcionAcuerdo' value="${acuerdoInstance[i].descripcionAcuerdo}"/>
          </td>
          <td class="tdDatos">
            <g:select class="seleccionarAcuerdo" style="width:150px" id="seleccionarAcuerdo_${i}" multiple="multiple" onChange="contar(this)" optionKey="id" name="usuarioAcuerdo" from="${usuarioInstance}" value="${acuerdoInstance[i].usuario}"/>
            <g:hiddenField id="numseleccionarAcuerdo_${i}" value="${acuerdoInstance[i].usuario.size()}" name="numUsuarioAcuerdo"/>
            <script type="text/javascript">contarnumac(${"seleccionarAcuerdo_"+i});</script>
          </td>
          <td class="tdDatos">
            <g:select name="corresponsable" from="${usuarioInstance}"/>

          </td>
          <td class="tdDatos">
            <g:textField id="fecha_${i}" size='10' class='campofecha' readonly="readonly" name='fechaCompromiso' value="${acuerdoInstance[i].fechaCompromiso.format('dd/MM/yyyy')}"/>
          </td>
          <td class="tdDatos">
          <g:select style="width:40px" class="selectEstaticos" name="estado" id="estado_${i}" from="${acuerdoLista.constraints.estado.inList}" value="${acuerdoInstance[i].estado}" />
            <script type="text/javascript">contadorAcuerdo(${i})</script>
          </td>
          <td class="tdDatos">
            <a href='#'><img alt="" src='/ControlDeReuniones/images/general/limpiar.png' id='${i}' onclick='limpiar(id)' width='30px'/></a>
          </td>
          <td class="tdDatos">
            <a onclick='eliminarUsuario(this)' href='#'><img alt="" src='/ControlDeReuniones/images/general/eliminar.png' width='30px' /></a>
          </td>
        </tr>
      </g:each>

    </g:if>
      <g:else><!-- ********************************************************************************************************* -->
        <tr class="trAux">
          <td class="tdDatos">
            <g:textArea onKeyUp="limpiarvacios(this),quitar(this)" onChange="limpiarvacios(this)"  maxlength="950" rows='3' cols='52' id='descripcion_1' name='descripcionAcuerdo' value=""/>
          </td>
          <td class="tdDatos" id="seleccionAcuerdo" >
            <g:select class="seleccionarAcuerdo" style="width:170px" id="seleccionarAcuerdo_1" multiple="multiple" onChange="contar(this)" optionKey="id" name="usuarioAcuerdo" from="${usuarioInstance}" value=""/>
            <g:hiddenField id="numseleccionarAcuerdo_1" value="0" name="numUsuarioAcuerdo"/>
          </td>
          <td class="tdDatos">
            <g:textField size='10' class='campofecha' id='fecha_1' readonly="readonly" name='fechaCompromiso' value="${new Date().format('dd/MM/yyyy')}"/>
            </td>
          <td class="tdDatos">
            <g:select class="selectEstaticos" name="estado" id="estado_1" from="${acuerdoLista.constraints.estado.inList}" value="" />
            <script type="text/javascript">contadorAcuerdo(1)</script>
          </td>
          <td class="tdDatos">
            <a href='#'><img alt="" src='/ControlDeReuniones/images/general/limpiar.png' id='${1}' onclick='limpiar(id)' width='30px'/></a>
          </td>
          <td class="tdDatos"> <a onclick='eliminarUsuario(this)' href='#'><img alt="" src='/ControlDeReuniones/images/general/eliminar.png' width='30px' /></a> </td>
        </tr>
      </g:else>
      </table>

      <p>&nbsp;</p>
    </div>
    
    <!--===========================Archivos===================================-->
  <div id="tab5" class="tab_content">
    <g:if test="${minutaInstance?.upload}">
      <g:render template="downloadFile"/>
    </g:if>  
    <g:else>
      <h2>Carga de archivo</h2>
      <g:render template="uploadFile"/>
    </g:else>     
  </div>
<!--=========================Fin Archivos==============================-->
    <p>&nbsp;</p>
    <fieldset class="buttons">

      <g:actionSubmit action="update" name="crear" class="save" value="Guardar" />      
      <input type="button" class="delete" value="Eliminar" onclick="mostrar('mensaje', ${minutaInstance?.id})"/>
      <g:if test="${minutaInstance.estadoMinuta == "Creada"}">
        <input id="inicioMinuta" style="display:inline;" class="iniMinuta" type="button" name="inicio" value="Iniciar minuta" onclick="horaFechaInicio()" />
        <g:actionSubmit  class="finMinuta" name="fin"  value="Finalizar minuta"  controller="minuta" action="update" onclick="horaFechaFin(),mont()" disabled="true" id="finalizarMinuta" style="display: none;"/>
        <a href="${createLink(uri: '/Minuta/list')}" class="list" aling="center"><g:message code="Ir a gestión de minutas"/></a>
      </g:if>
      <g:elseif test="${minutaInstance.estadoMinuta == "Iniciada"}">
        <input id="inicioMinuta" style="display:none;" class="iniMinuta" type="button" name="inicio" value="Iniciar minuta" onclick="horaFechaInicio()" disabled="true" style="display: none;"/>
        <g:actionSubmit class="finMinuta" name="fin"  value="Finalizar minuta"  controller="minuta" action="update" onclick="horaFechaFin(),mont(),validar(fm)" id="finalizarMinuta" style="display: inline;"/>     
        <a href="${createLink(uri: '/Minuta/list')}" class="list" aling="center"><g:message code="Ir a gestión de minutas"/></a>
      </g:elseif>
    </fieldset>
  </div>
</g:else>


<!--===========================Fin===================================-->

<!-- Fin del contenido del GSP -->
