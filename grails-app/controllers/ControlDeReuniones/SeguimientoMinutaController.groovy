package ControlDeReuniones

import org.springframework.dao.DataIntegrityViolationException

import pl.touk.excel.export.WebXlsxExporter
import pl.touk.excel.export.XlsxExporter
import pl.touk.excel.export.getters.LongToDatePropertyGetter
import pl.touk.excel.export.getters.MessageFromPropertyGetter
import  groovy.sql.Sql
import groovy.sql.*

class SeguimientoMinutaController {
    def dataSource
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    def springSecurityService
    def authenticationTrustResolver
    def mailService    
        
    def index() {
        redirect(action: "list", params: params)
    }   
  
    def list() {     
        if(springSecurityService.isLoggedIn()){
            def principal = springSecurityService.principal        
            String role = principal.authorities
        
            if(role.equals("[ROLE_Administrador]")){
                def estado    
                def estadoT =  Minuta.findAll("FROM Minuta AS m Where (m.estadoMinuta='Finalizada')")  
                if(params.max && params.offset)
                {
                    if(params.order && params.sort){
                        estado =  Minuta.findAll("FROM Minuta AS m Where (m.estadoMinuta='Finalizada')order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                    }
                    else{
                        estado =  Minuta.findAll("FROM Minuta AS m Where (m.estadoMinuta='Finalizada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                    } 
                } 
                else{
                    if(params.order && params.sort){
                        estado =  Minuta.findAll("FROM Minuta AS m Where (m.estadoMinuta='Finalizada')order by "+params.sort+" "+params.order+"",[max:9,offset:0])
                    }
                    else{
                        estado =  Minuta.findAll("FROM Minuta AS m Where (m.estadoMinuta='Finalizada')",[max:9,offset:0])
                    } 
                
                }
            
                if(!estado)
                flash.message = "Usted no tiene minutas a su cargo." 
                //                println "Estado " + estado
                //                def prueba = new ArrayList() 
                //                def minutaFinal = new ArrayList()
                //                if(estado){
                //                    for(def i=0; i<estado.size(); i++)
                //                    {
                //                        prueba.add(Acuerdo.findAllByEstadoInListAndMinuta(["Pendiente", "Parcial"], estado[i]))
                //                        println prueba + "1"
                //                        if(prueba[i])
                //                        {
                //                            println "Prueba " + prueba                    
                //                            minutaFinal.add(estado[i])
                //                            println "MinutaFinal " + minutaFinal  
                //                        }                      
                //                    }
                //                }
                //     
                //                if(!minutaFinal){
                //                    flash.message = "Usted no tiene minutas a su cargo" 
                //                    println "2"
                //                }
                
                [minutaInstanceList: estado, minutaInstanceTotal: estadoT.size]
            }
            else 
            if(role.equals("[ROLE_Responsable]")){
                def user=springSecurityService.getCurrentUser() 
                def u=user.properties.id
                def respo
                def respoT = Minuta.findAll("FROM Minuta WHERE responsable_id='${u}' And estadoMinuta='Finalizada'")
                if(params.max && params.offset)
                {
                    if(params.order && params.sort){
                        respo = Minuta.findAll("FROM Minuta WHERE responsable_id='${u}' And estadoMinuta='Finalizada'order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])         
                    }
                    else{
                        respo = Minuta.findAll("FROM Minuta WHERE responsable_id='${u}' And estadoMinuta='Finalizada'",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])        
                    }    
                }                    
                else
                {
                    if(params.order && params.sort){
                        respo = Minuta.findAll("FROM Minuta WHERE responsable_id='${u}' And estadoMinuta='Finalizada'order by "+params.sort+" "+params.order+"",[max:9,offset:0])                   
                    }
                    else{
                        respo = Minuta.findAll("FROM Minuta WHERE responsable_id='${u}' And estadoMinuta='Finalizada'",[max:9,offset:0])    
                    }   
                }
                
                if(!respo)
                {
                    flash.message = "Usted no tiene minutas a su cargo." 
                }
                //                def edo = respo.estadoMinuta
                //                
                //                def prueba = new ArrayList() 
                //                def minutaFinal = new ArrayList()
                //                if(respo){
                //                    for(def i=0; i<respo.size(); i++)
                //                    {
                //                        prueba.add(Acuerdo.findAllByEstadoInListAndMinuta(["Pendiente", "Parcial"], respo[i]))
                //                        println prueba + "1"
                //                        if(prueba[i])
                //                        {
                //                            println "Prueba " + prueba                    
                //                            minutaFinal.add(respo[i])
                ////                            println "MinutaFinal " + minutaFina+  
                //                        }                      
                //                    }
                //                    println "MinutaFinal " + minutaFinal  
                //                }
                //     
                //                if(!minutaFinal){
                //                    flash.message = "Usted no tiene minutas a su cargo" 
                //                    println "2 gsdfgsdfgsdfg"
                //                }
                
                [minutaInstanceList: respo, minutaInstanceTotal: respoT.size]
            }
        
            
        }                                       
       
    }

    
    
    
    
    
    
    def parti2(){
        redirect(action: "participantes", params: params)
        
    }
    
    
    def participantes(){  
        println params 
        //Variable minutaInstance toda el id de la minuta
        def minutaInstance = Minuta.get(params.id) 
        //Variable que toma los usuarios que pertenecen a la minuta
        def nuevo =  minutaInstance.usuario 
        
        [usuarioInstanceList: Usuario.list(params), usuarioInstanceTotal: Usuario.count(),
            minutaInstance:minutaInstance, nuevo:nuevo]
    }
    

    
    def cancelar(){   
        
        //println "==== id:  " + params
        
        try{
            //Declaración de variables
            def minutaInstance = Minuta.get(params.id)        
            //println "==== " + minutaInstance.estadoMinuta
            //println "acuerdos " + minutaInstance.acuerdo        
            def correoR = minutaInstance.responsable
            def correoRespo = correoR.correoElectronico

            String acu = minutaInstance.acuerdo
            def prueba = new ArrayList()        
            def prueba2 = new ArrayList()
            String acuerdo = ""

            //Variable que contiene los usuarios pertenecientes a la minuta
            String usuario = minutaInstance.usuario

            //Variable que contiene el identificador de la minuta
            def identi = minutaInstance.identificador 

            //Declaración de variables para el envío de correo
            String usuarioFinal = ""  
            String correoUsuario2 = ""
            def usua = new ArrayList()

            //For que recorre el arreglo de los usuarios y para eliminar los corchetes
            for(def i=1; i<usuario.size()-1; i++){            
                usua.add(usuario[i])           
            }       
            for(def i=0; i<usua.size(); i++)
            {            
                usuarioFinal = usuarioFinal + usua[i]
            }

            //Variable que separa los elementos que no sean una (,) y espacio (\\s)
            String[] usuarioFinalArray = usuarioFinal.split(",\\s*")   

            //For que busca los correos de los usuarios
            for(String usuariosFinal:usuarioFinalArray){
                def nombreUsu = Usuario.findByNombre(usuariosFinal)           
                correoUsuario2 = correoUsuario2 + nombreUsu.correoElectronico + "," 
            }

            //Almacena los correos, separandolos por una (,)
            def lista = correoUsuario2.split(",")

            //For que envia los correos electronicos a través del servicio EnvioDeCorreoService
            for (def i = 0; i<lista.size(); i++)
            {
                notificarCancelarMinuta(identi, lista[i], correoRespo)   
            }

            //for que recorre los el arreglo acuerdos
            for(def i=1; i<acu.size(); i++){            
                prueba2.add(acu[i])           
            }

            //for que quita los corchetes del arreglo de acuerdos
            for(def i=0; i<prueba2.size()-1; i++){
                acuerdo = acuerdo + prueba2[i]           
            }

            String acuerdoss = acuerdo 
            String[] acuerdosArray = acuerdoss.split(",\\s*")
                
            if(acuerdosArray){              
                //for que quita la coma y pone un espacio a los acuerdos
                for (String acue : acuerdosArray) {  
                    def acuerdos = Acuerdo.findByDescripcionAcuerdo(acue)
                    def ida = acuerdos.id
                    //Consulta que actualiza el estado de los acuerdos a CANCELADO
                    Acuerdo.executeUpdate("UPDATE Acuerdo SET estado ='Cancelado' Where id='${ida}'")
                }  

                //Variable que busca el id de la minuta
                def id = minutaInstance.id  

                //Consulta que actualiza el estado de la minuta a FINALIZADA
                Minuta.executeUpdate("UPDATE Minuta SET estado_minuta ='Cancelada' WHERE id ='${id}'")
            }
                
            //Mensaje que muestra al usuario sobre la acción realizada
            flash.message = "La minuta se ha cancelado satisfactoriamente y se ha notificado <br/> por correo electrónico a sus participantes."  
            def mensaje = flash.mensaje = "La minuta se ha cancelado satisfactoriamente y se ha notificado <br/> por correo electrónico a sus participantes."
            //            redirect(action: "list", controller:"SeguimientoMinuta") 

        }
        catch(Exception e){
            //println "Error  " + e               
            //Mensaje que muestra al usuario sobre la acción realizada
            flash.message = "Falló al enviar correo(s). Inténtelo mas tarde."  
            def mensaje1 = flash.mensaje = "Falló al enviar correo(s). Inténtelo mas tarde."
        }
                
        
        redirect(action: "list", controller:"SeguimientoMinuta")        
           
    }
    
    def minutaEdit(){        
        redirect(action: "continuarMinuta", controller: "Minuta", params:params)
    }
    
    def notificarCancelarMinuta(identificador, correoElectronico, correoRespo){        
        mailService.sendMail {
            to correoElectronico
            from correoRespo
            subject "La minuta con identificador " + identificador + " ha sido cancelada"
            body "Se les informa que que la Minuta con identificador '" + identificador + "' y sus acuerdos han sido cancelados. Sin mas por el momento, " +
            "les envío un coordial saludo."
        }
    }

    def reporte(){
        
        def lista = new Sql(dataSource).rows("{call sp_reporte}")
        //def rows = sql.rows("select tr.nombre as Gabinete, m.fecha_inicio as Fecha_Inicio, a.descripcion_acuerdo as Acuerdo, a.estado as Estado, a.fecha_compromiso as Fecha_Compromiso, u.nombre as Dependencia, Grupo from usuario u, tipo_reunion tr, minuta m, acuerdo_usuario au, acuerdo a where m.tipo_reunion_id=tr.id and au.usuario_id=u.id and au.acuerdo_id=a.id and a.minuta_id=m.id")
        //def query = "select tr.nombre as Gabinete, m.fecha_inicio as Fecha_Inicio, a.descripcion_acuerdo as Acuerdo, a.estado as Estado, a.fecha_compromiso as Fecha_Compromiso, u.nombre as Dependencia, Grupo from usuario u, tipo_reunion tr, minuta m, acuerdo_usuario au, acuerdo a where m.tipo_reunion_id=tr.id and au.usuario_id=u.id and au.acuerdo_id=a.id and a.minuta_id=m.id"
        //def listaGral = Minuta.executeQuery(query)
        println "--------"+lista.size()
        def headers = ['Gabinete', 'Fecha Minuta', 'Acuerdo', 'Estado', 'Fecha Compromiso','Dependencia','Grupo']
        def withProperties = ['gabinete', 'fecha_minuta', 'acuerdo', 'estado', 'fecha_compromiso','dependencia','grupo']

        new WebXlsxExporter().with {
            setResponseHeaders(response)
            fillHeader(headers)
            add(lista, withProperties)
            save(response.outputStream)
        }
        redirect(action: "list", controller:"SeguimientoMinuta")
    }
}


