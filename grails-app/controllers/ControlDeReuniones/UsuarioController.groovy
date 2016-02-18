package ControlDeReuniones

import org.springframework.dao.DataIntegrityViolationException
import javax.sql.DataSource
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import groovy.sql.*

class UsuarioController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def mailService

    def index() {
        redirect(action: "create", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [usuarioInstanceList: Usuario.list(params), usuarioInstanceTotal: Usuario.count()]
    }

    def create() {
        def usuarioInstance
        def rolInstance
        if(params.id){
            usuarioInstance = Usuario.get(params.id)
            rolInstance = UsuarioRol.findByUsuario(usuarioInstance)
           
        }else{
            usuarioInstance = new Usuario(params)
        }
        
       
        def lista
        def listaGral = Usuario.findAll("FROM Usuario AS u Where (u.tipo='Interno')")
        if(params.max && params.offset)
        {
            if(params.order && params.sort)
            {
                lista=Usuario.findAll("FROM Usuario AS u Where (u.tipo='Interno')order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])                                                              
            }
            else
            {
                lista=Usuario.findAll("FROM Usuario AS u Where (u.tipo='Interno')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])                                          
            }
        }
        else
        {
            if(params.order && params.sort)
            {
                       
                lista=Usuario.findAll("FROM Usuario AS u Where (u.tipo='Interno') order by "+params.sort+" "+params.order+"",[max:10,offset:0])                                      
            }
            else
            {
                lista=Usuario.findAll("FROM Usuario AS u Where (u.tipo='Interno')",[max:10,offset:0])                                      
            }
        }
        if(params.id)
        [usuarioInstanceList: lista, usuarioInstanceTotal: listaGral.size,usuarioInstance: usuarioInstance,rolInstance:rolInstance.rol.id]
        else
        [usuarioInstanceList: lista, usuarioInstanceTotal: listaGral.size,usuarioInstance: usuarioInstance]
                                    
    }   
    

    def save(){
        if(Integer.parseInt(params.rol.id) == 1)
        params.enabled = true
        def usuarioInstance = new Usuario(params)
        if (!usuarioInstance.save(flush: true)) {
            flash.message = "El usuario que intenta registrar ya existe."
            redirect(action: "create")
            return
        }
        def obtenerRol = Rol.get(params.rol.id)
        def verificacionAdmin = UsuarioRol.findByRol(obtenerRol)
        if(!verificacionAdmin)
        {
            def usuarioRegistrado = Usuario.findByUsername(params.username)
            def rolUsuario = Rol.findById(params.rol.id)
            def usuarioRolInstance= new UsuarioRol(usuario:usuarioRegistrado, rol:rolUsuario)
            usuarioRolInstance.save(flush: true)
            flash.message = "Se agregó correctamente el nuevo usuario."
            redirect(action: "create")
        }
        else 
        {
            try{
                envioCorreo(correous, username, nombre, puesto, password, correoadm)
            }catch(exception){
            }
            if(Integer.parseInt(params.rol.id) > 1){
                def usuarioRegistrado = Usuario.findByUsername(params.username)
                def rolUsuario = Rol.findById(params.rol.id)
                def usuarioRolInstance= new UsuarioRol(usuario:usuarioRegistrado, rol:rolUsuario)
                usuarioRolInstance.save(flush: true)
                flash.message = "Se agregó correctamente el nuevo usuario."
                redirect(action: "create")
            }
            else{
                def ro = Rol.get(1)
                def rol = Rol.get(3)
                def adm = UsuarioRol.findWhere(rol: ro)
                def usu = Usuario.get(adm.usuario.id)
                adm = UsuarioRol.findWhere(usuario: usu, rol: ro)
                try{
                    adm.delete()
                    def usuarioRolInstance= new UsuarioRol(usuario:usu, rol:rol)
                    usuarioRolInstance.save(flush: true)
                }catch(DataIntegrityViolationException e){

                }
                try{
                    envioCorreo(correous, username, nombre, puesto, password, correoadm)
                }catch(exception){
                    
                }
                def usuarioRegistrado = Usuario.findByUsername(params.username)
                def rolUsuario = Rol.findById(params.rol.id)
                def usuarioRolInstance= new UsuarioRol(usuario:usuarioRegistrado, rol:rolUsuario)
                usuarioRolInstance.save(flush: true)
                redirect(controller: "logout")
                return
            }
        }
    }

    def edit() {
        def usuarioInstance = Usuario.get(params.id)
        if (!usuarioInstance) {
            redirect(action: "create")
            return
        }
        def usuarioRolInstance = UsuarioRol.findByUsuario(usuarioInstance)
        def rolInstance = Rol.get(usuarioRolInstance.rol.id)
        [usuarioInstance: usuarioInstance,rolInstance:rolInstance.id, params: params]
    }

    def verup(){
        def usuarioInstance = Usuario.get(params.id)
        def obtenerRol = Rol.get(1)
        def verificacionAdmin = UsuarioRol.findByRol(obtenerRol)
        def user = Usuario.get(verificacionAdmin.usuario.id)
        if(user == usuarioInstance){
            if (params.version) {
                def version = params.version.toLong()
                if (usuarioInstance.version > version) {
                    usuarioInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'usuario.label', default: 'Usuario')] as Object[],
                                  "Another user has updated this Usuario while you were editing")
                    redirect(action: "create")
                }
            }
            usuarioInstance.properties = params
            usuarioInstance.enabled=true
            if (!usuarioInstance.save(flush: true)) {
                render(view: "create", model: [usuarioInstance: usuarioInstance])
            }
            def ro = Rol.get(1)
            def si
            def rol = Rol.get(3)
            def adm = UsuarioRol.findWhere(rol: ro)
            def administrador = Usuario.get(adm.usuarioId)
            def correoadm = administrador.correoElectronico
            def correous = params.correoElectronico
            def username = params.username
            def nombre = params.nombre
            def puesto = params.puesto
            def password = params.password
            try{
                envioCorreo(correous, username, nombre, puesto, password, correoadm)
                si = 1
            }catch(exception){
                si = 2
            }
            if(si == 1)
            flash.message = "El Administrador se modificó correctamente."
            else
            flash.message = "Los datos se guardarón correctamente, pero no se pudo enviar el correo."
            redirect(action: "create")
            return
        }else{
            if(Integer.parseInt(params.rol.id) == 1){
                usuarioInstance.enabled=true
            }
            update()
        }
    }
    
    def update() {
        def ro = Rol.get(1)
        def si
        def rol = Rol.get(3)
        def adm = UsuarioRol.findWhere(rol: ro)
        def administrador = Usuario.get(adm.usuarioId)
        def correoadm = administrador.correoElectronico
        def correous = params.correoElectronico
        def username = params.username
        def nombre = params.nombre
        def puesto = params.puesto
        def password = params.password
        
        def usu = Usuario.get(adm.usuario.id)
        adm = UsuarioRol.findWhere(usuario: usu, rol: ro)
        if(Integer.parseInt(params.rol.id) > 1){
        }else{
            if(!adm){
            }else{
                try{
                    adm.delete()
                }
                catch(DataIntegrityViolationException e){
                }
                def usur = new UsuarioRol(usuario: usu, rol: rol)
                if(!usur.save(flush: true)){
                }
            }
        }
        def usuarioInstance = Usuario.get(params.id)
        if (!usuarioInstance) {
            redirect(action: "create")
            return
        }
        def rolId = Rol.get(params.rol.id)
        def erl = UsuarioRol.findWhere(usuario: usuarioInstance)
        try {
            erl.delete(flush: true)
        }
        catch (DataIntegrityViolationException e) {

        }
        if (params.version) {
            def version = params.version.toLong()
            if (usuarioInstance.version > version) {
                usuarioInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'usuario.label', default: 'Usuario')] as Object[],
                          "Another user has updated this Usuario while you were editing")
                redirect(action: "create", id: usuarioInstance.id)
            }
        }
        usuarioInstance.properties = params
        erl.properties = [usuario: usuarioInstance, rol: rolId]
        if(Integer.parseInt(params.rol.id) == 1){
            usuarioInstance.enabled=true
        }
        if (!usuarioInstance.save(flush: true)) {
            si = 3
        }
        if(!erl.save(flush: true)){
            redirect(action: "edit", id: usuarioInstance.id)
        }
        if(si == 3){
            flash.message = "El usuario que intenta registrar ya existe."
            redirect(action: "create")
            return
        }
        try{
            envioCorreo(correous, username, nombre, puesto, password, correoadm)
            si = 1
        }catch(exception){
            flash.message = "Los datos se guardarón correctamente, pero no se pudo enviar el correo."
            si = 2
        }
        if(Integer.parseInt(params.rol.id) > 1){
            if(si == 1){
                flash.message = "Los datos se guardarón correctamente y se notificó via correo electrónico."
                redirect(action: "create")
                return
            }
            else{
                redirect(action: "create")
                return
            }
        }else{
            redirect(controller: "logout")
            return
        }
    }
    
    // delete un 95% terminado
    def delete() {    
        def usuarioInstance = Usuario.get(params.id)
        def minuta = Minuta.findAll("FROM Minuta WHERE responsable_id='${usuarioInstance.id}'")
        String acuerdo = usuarioInstance.acuerdo
        def allminutas = Minuta.getAll();
        String usuarioS = new ArrayList()
        def usua = new ArrayList()       
        String usuarioFinal = ""
        usuarioS = allminutas.usuario
        def flag = false
        for(def i=1; i<usuarioS.size()-1; i++){            
            usua.add(usuarioS[i])           
        }       
        for(def i=0; i<usua.size(); i++)
        {            
            usuarioFinal = usuarioFinal + usua[i]
        }
        String[] usuarioFinalArray = usuarioFinal.split(",\\s*")    
        def nombreUsu
        for(String usuariosFinal:usuarioFinalArray){
            nombreUsu = Usuario.findByNombre(usuariosFinal)    
            if(nombreUsu == usuarioInstance){
                flag = true
                break
            }   
            else{
                flag = false
            }   
        }
        if(flag == false){
            def acuerdos
            def rol = Rol.get(1)
            def erl = UsuarioRol.findAllWhere(usuario: usuarioInstance, rol: rol)

            def prueba2 = new ArrayList()
            String acuerdoO = ""
            for(def i=1; i<acuerdo.size(); i++){            
                prueba2.add(acuerdo[i])           
            }
            for(def i=0; i<prueba2.size()-1; i++){
                acuerdoO = acuerdoO + prueba2[i]     
            }
            String acuerdoss = acuerdoO
            String[] acuerdosArray = acuerdoss.split(",\\s*")
            for (String acue : acuerdosArray) {  
                try{
                    acuerdos = Acuerdo.findByDescripcionAcuerdo(acue)
                    def ida = acuerdos.minutaId
                }catch(exeption){
                    break
                }
            }  
            if(acuerdos == null || minuta == 0){
                if (!erl){
                    erl = UsuarioRol.findWhere(usuario: usuarioInstance)
                    if (!erl) {
                        flash.message = message(code: 'default.not.found.message', args: [message(code: 'usuarioRol.label', default: 'UsuarioRol'), params.id])
                    }
                    try {
                        erl.delete(flush: true)

                    }
                    catch (DataIntegrityViolationException e) {

                    }
                    if(!usuarioInstance){
                    }        
                    try {
                        usuarioInstance.delete(flush: true)
                        flash.message = "Se eliminó correctamente el usuario."
                        redirect(action: "create")
                    }
                    catch (DataIntegrityViolationException e) {
                        flash.message = " "
                        redirect(action: "create")
                    }
                }else{
                    flash.message = "No se puede eliminar al administrador."
                    redirect(action: "create")
                    return
                }
            }else{
                if (!erl){
                    flash.message = "No se puede eliminar el usuario porque pertenece a una minuta o a un acuerdo."

                    redirect(action: "create")
                    return
                }else{
                    flash.message = "No se puede eliminar al administrador."
                    redirect(action: "create")
                    return
                }
            }
        }else{
            flash.message = "No se puede eliminar el usuario porque pertenece a una minuta o a un acuerdo."
            redirect(action:"create")
            return
        }
    }
    
    def envioCorreo(correoElectronico, usuario, nombre,  puesto, contraseña, correoRespo){        
         mailService.sendMail {
            to correoElectronico
            from correoRespo
            subject "La Informacion de sus datos ha sido modificada"
//            body "Se le informa que su in formacion ha sido cambiada verifique los datos " +
//                "Nombre: " + nombre+ "| Nombre de usuario: "+ usuario +" | Correo Electronico: "+ correoElectronico +" | Puesto: " + puesto +" Contraseña: " + contraseña
       html '<p>Se le informa que se ha modificado su informaci&oacute;n, quedando de la siguiente manera:</p><table align="center" width=700px><th style="background:#585858; color:white;" height="40" colspan="2">Datos Personales:</th>'+"\n"+
       '<tr align="left"><th height="30">Nombre del participante:</th><td align="center"><b>'+ nombre + '</b></td></tr>' + "\n" +
        '<tr align="left"><th height="30">Puesto:</th><td align="center"><b>' + puesto + '</b></td></tr>' + "\n" + 
            '<tr align="left"><th height="30">Usuario:</th><td align="center"><b>' + usuario + '</b></td></tr>' + "\n" + 
            '<tr align="left"><th height="30">Contrase&ntilde;a:</th><td align="center"><b>' + contraseña + '</b></td></tr>' + "\n" +
            '<tr align="left"><th height="30">Correo Electronico:</th><td align="center"><b>' + correoElectronico + '</b></td></tr>' + "\n" +
            '</table>'
        }
    }
}