<g:hiddenField name="minutaIdentificador" value="${minutaInstance?.identificador}"></g:hiddenField>
        <g:hiddenField name="minutaId" value="${minutaInstance?.id}"></g:hiddenField>
        <input type="file" name="myFile"/>
        <g:actionSubmit action="uploadFile" enctype="multipart/form-data" value="Guardar"/>

