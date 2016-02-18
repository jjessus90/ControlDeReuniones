<%@ page import="ControlDeReuniones.TipoReunion" %>


<g:javascript src="JSCon.js"/>

<table style="width:750px;" border="0" class="tablaDatos">
  <tr>
    <td style="color: white;" class="tdEncabezado" colspan="4">Ingrese los datos del tipo de reunión</td>
  </tr>
  <tr> 
    <td valign="middle" class="tdTipoDatos" style="width:30%;" >
      <label for="nombre">
        <g:message code="tipoReunion.nombre.label" default="Nombre de tipo de reunión:" />
        <span class="required-indicator">*</span>
      </label>
    </td>
    <td valign="middle" class="tdDatos" style="width:40%;" >
  <g:textField style="width:315px;" name="nombre" id="nom" required="" value="${tipoReunionInstance?.nombre}" maxlength="100" onkeyup="return soloLetras(event, this)" onkeypress="return soloLetras(event, this)" onchange="return soloLetras(event, this)" />
</td>

<td class="tdTipoDatos" style="width:9%;" >
  <label for="estado">
    <g:message code="tipoReunion.estado.label" default="Estado:" />
  </label>
</td>
<td class="tdDatos" style="width:11%;" >
  <select name="estado" value="${tipoReunionInstance?.estado}">
    <option>Activo</option>
    <option>Inactivo</option>
  </select>
</td>
</tr>
<tr>
  <td class="tdTipoDatos">
    <label for="descripcion">
      <g:message code="tipoReunion.descripcion.label" default="Descripción:" />
    </label>
  </td>
  <td colspan="3" class="tdDatos">
<g:textArea rows="3" cols="79" name="descripcion" id="desc" value="${tipoReunionInstance?.descripcion}" maxlength="250" onkeypress="descipcion('desc')"/>
</td>
</tr>
</table>
