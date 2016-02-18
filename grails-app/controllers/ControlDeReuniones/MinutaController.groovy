package ControlDeReuniones
import javax.sql.DataSource
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import groovy.sql.Sql
import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.web.multipart.*
import org.springframework.*
import java.util.*

class MinutaController {
    

    def springSecurityService
    def authenticationTrustResolver
    def mailService
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    
    
    
    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
       
        
        if (springSecurityService.isLoggedIn()) {

            def principal = springSecurityService.principal
        
            String role = principal.authorities
      
            if(role.equals("[ROLE_Administrador]")){
                
                def lista
                def listaGral=Minuta.findAll("FROM Minuta AS m WHERE (m.estadoMinuta='Abierta' or m.estadoMinuta='Iniciada' or m.estadoMinuta='Creada')")
                
                if(params.max && params.offset)
                {
                    if(params.order && params.sort)
                    {
                        lista=Minuta.findAll("FROM Minuta AS m WHERE (m.estadoMinuta='Abierta' or m.estadoMinuta='Iniciada' or m.estadoMinuta='Creada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])                                                              
                    }
                    else
                    {
                        lista=Minuta.findAll("FROM Minuta AS m WHERE (m.estadoMinuta='Abierta' or m.estadoMinuta='Iniciada' or m.estadoMinuta='Creada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])                                          
                    }
                    
                }
                else
                {
                    if(params.order && params.sort)
                    {
                       
                        lista=Minuta.findAll("FROM Minuta AS m WHERE (m.estadoMinuta='Abierta' or m.estadoMinuta='Iniciada' or m.estadoMinuta='Creada') order by "+params.sort+" "+params.order+"",[max:9,offset:0])                                      
                    }
                    else
                    {
                        lista=Minuta.findAll("FROM Minuta AS m WHERE (m.estadoMinuta='Abierta' or m.estadoMinuta='Iniciada' or m.estadoMinuta='Creada')",[max:9,offset:0])                                      
                    }
                }
                
                [listar: lista, minutaInstanceTotal: listaGral.size]

                
                
            }else if(role.equals("[ROLE_Responsable]")){
                def lista
                
                def user=springSecurityService.getCurrentUser() 
                def u=user.properties.id
                def listaGral=Minuta.findAll("FROM Minuta AS m WHERE (m.estadoMinuta='Abierta' or m.estadoMinuta='Iniciada' or m.estadoMinuta='Creada') and responsable_id='${u}'")                     
                if(params.max && params.offset)
                {
                    lista=Minuta.findAll("FROM Minuta AS m WHERE (m.estadoMinuta='Abierta' or m.estadoMinuta='Iniciada' or m.estadoMinuta='Creada') and responsable_id='${u}'",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])                     
                }
                else
                {
                    lista=Minuta.findAll("FROM Minuta AS m WHERE (m.estadoMinuta='Abierta' or m.estadoMinuta='Iniciada' or m.estadoMinuta='Creada') and responsable_id='${u}'",[max:10,offset:0])                     
                }
                
                [listar: lista, minutaInstanceTotal: listaGral.size]
                
        
    
            }
        }
    }

    def create() {
        redirect(action: "crearMinuta", params:params)
    }
    
    def crearMinuta() {
     
        def user=springSecurityService.getCurrentUser()
       
        def usuarioInstance = Usuario.findAllByTipo("Interno")
        def tipoReunionInstance = TipoReunion.findAllByEstado("Activo")
        
        [minutaInstance: new Minuta(params),usuarioInstance:usuarioInstance,responsableInstance:user,tipoReunionInstance:tipoReunionInstance]
    }

    def save() {
        println "save"
        def validar1
        def descAcuerdo = false

        if(params.estadoMinuta=="Prefinalizada"){  
            params.estadoMinuta = "Iniciada"
            params.fechaF = ""
            params.horaFin = ""
            descAcuerdo = true
        }
        
        if(params.fechaI )
        {
            params.fechaInicio =  new Date()   
            String[] fechainicio = params.fechaI.split("/");     
            params.fechaInicio.setDate(Integer.parseInt(fechainicio[0]))        
            params.fechaInicio.setMonth(Integer.parseInt(fechainicio[1])-1)
            params.fechaInicio.setYear(Integer.parseInt(fechainicio[2])-1900) 
        }
        if(params.fechaF)
        {
            params.fechaFin = new Date() 
            String[] fechafin = params.fechaF.split("/");     
            params.fechaFin.setDate(Integer.parseInt(fechafin[0]))        
            params.fechaFin.setMonth(Integer.parseInt(fechafin[1])-1)
            params.fechaFin.setYear(Integer.parseInt(fechafin[2])-1900)       
        }           
        //////////////////////Externo/////////////////////
        List usuarioLista = new ArrayList()
        try {
            params.emailExterno.length
            for(def i=0; i<params.emailExterno.length; i++) {
                if(params.emailExterno[i]) {
                    def externoInstance = Usuario.findByUsername(params.emailExterno[i]+"/"+params.identificador)  
                    if(!externoInstance){
                        def usuarioExterno = new Usuario(username:params.emailExterno[i]+"/"+params.identificador,password:"123",correoElectronico:params.emailExterno[i],nombre:params.nombreExterno[i],organizacion:params.organizacionExterno[i],puesto:params.puesto[i],tipo:"Externo",enabled:true)
                        if(!usuarioExterno.save(flush:true)) {
                            validar1="validarExterno1"
                        } else {
                            externoInstance = usuarioExterno
                            usuarioLista.add(externoInstance.id)
                        }
                    }
                }
            }
        } catch(Exception) {
            if(params.emailExterno) {
                def externoInstance = Usuario.findByUsername(params.emailExterno+"/"+params.identificador) 
                if(!externoInstance){
                    
                    def usuarioExterno = new Usuario(username:params.emailExterno+"/"+params.identificador,password:"123",correoElectronico:params.emailExterno,nombre:params.nombreExterno,organizacion:params.organizacionExterno,puesto:params.puesto,tipo:"Externo",enabled:true)
                    
                    if(!usuarioExterno.save(flush:true))
                    {
                        validar1="validarExterno1"                     
                    }
                    else
                    {
                        externoInstance = usuarioExterno
                        usuarioLista.add(externoInstance.id)
                    }
                }
                else
                {
                    
                }

                  
                
            }
        }
        try
        {
            params.usuario.length
            for(def i=0; i<params.usuario.size(); i++)
            {
                usuarioLista.add(params.usuario[i])
            }
        }
        catch (Exception e)
        {
            usuarioLista.add(params.usuario)
        }
        
        
        String [] totalUsuarios = usuarioLista      
        params.usuario = totalUsuarios
        
      
        /////////////////fin Externo /////////////////////////////////
       
        def minutaInstance= new Minuta(params)
      
        if (!minutaInstance.save(flush: true)) {
       
            def user=springSecurityService.getCurrentUser()
            
            def usuarioInstance = Usuario.findAllByTipo("Interno")
            def tipoReunionInstance = TipoReunion.findAllByEstado("Activo")
           
            render(view: "crearMinuta", model: [minutaInstance: minutaInstance,responsableInstance:user,usuarioInstance:usuarioInstance,tipoReunionInstance:tipoReunionInstance])
            
            return
        }

        //println "//////////////////Parametros//////////////// "+ minutaInstance.properties
       
       
        
        //////////////////////    Punto a Tratar
        
        try
        {
            params.pTratar.length
            for(int i=0; i<params.pTratar.size(); i++){
            
                
                def puntoTratarInstance=new PuntoTratar(puntoTratar:params.pTratar[i],minuta:minutaInstance) 
                puntoTratarInstance.save(flush:true)
                
            }
        }
        catch(Exception)
        {
            if(params.pTratar)
            {
                def puntoTratarInstance=new PuntoTratar(puntoTratar:params.pTratar,minuta:minutaInstance) 
                puntoTratarInstance.save(flush:true)
                
            }
        }
        
        ////////////////////Fin Punto a Tratar
        
        /////////////////////////// Acuerdo
        
        
        try
        {
            
            params.descripcionAcuerdo.length
           
            for(int i=0; i<params.descripcionAcuerdo.size(); i++){
                p
                def fechaDate=new Date()
                String[] fechaCompromisoF = params.fechaCompromiso[i].split("/");     
                fechaDate.setDate(Integer.parseInt(fechaCompromisoF[0]))        
                fechaDate.setMonth(Integer.parseInt(fechaCompromisoF[1])-1)
                fechaDate.setYear(Integer.parseInt(fechaCompromisoF[2])-1900)       
                def usuarioInstance = Usuario.findById(params.usuarioAcuerdo[i])                    
                              
                def acuerdoInstance= new Acuerdo(usuario:usuarioInstance, descripcionAcuerdo:params.descripcionAcuerdo[i],fechaCompromiso:fechaDate,estado:params.estado[i],minuta:minutaInstance)
                acuerdoInstance.save(flush: true)
                
               
            }
        }
        catch(Exception e){
           
           
            if(params.descripcionAcuerdo)
            {
                //                println "------d------->" + params.fechaCompromiso 
                //                println "------ddd------->" + params.fechaCompromiso.split("/"); 
                def fechaDate=new Date()   
                String[] fechaCompromisoF = params.fechaCompromiso.split("/");  
                fechaDate.setDate(Integer.parseInt(fechaCompromisoF[0]))        
                fechaDate.setMonth(Integer.parseInt(fechaCompromisoF[1])-1)
                fechaDate.setYear(Integer.parseInt(fechaCompromisoF[2])-1900) 
               
                def usuarioInstance = Usuario.findById(params.usuarioAcuerdo)                    
                                
                def acuerdoInstance= new Acuerdo(usuario:usuarioInstance, descripcionAcuerdo:params.descripcionAcuerdo,fechaCompromiso:fechaDate,estado:params.estado,minuta:minutaInstance)
                acuerdoInstance.save(flush: true)
               
            }
           
                
        } 
            
        
     
        ///////////////////Fin Acuerdo//////////////////////////////////////////////////////////////////
        if(validar1=="validarExterno1"){
            flash.message = "El participante externo no pudo ser guardado, por que falto ingresar algunos campos o el correo era invalido."
        }
        else
        {
            if(descAcuerdo==true)
            flash.message = "La minuta no puede ser finalizado hasta que ingrese un acuerdo."       
            else
            flash.message = "La minuta se guardó correctamente."
        }
        redirect(action: "continuarMinuta", id: minutaInstance.id)
         
        
        
    }

    def show() {
        def minutaInstance = Minuta.get(params.id)
        if (!minutaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'minuta.label', default: 'Minuta'), params.id])
            redirect(action: "list")
            return
        }

        [minutaInstance: minutaInstance]
    }

    def edit() {
        def minutaInstance = Minuta.get(params.id)
        if (!minutaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'minuta.label', default: 'Minuta'), params.id])
            redirect(action: "list")
            return
        }

        [minutaInstance: minutaInstance]
    }
    
    def continuarMinuta() {
        def minutaInstance = Minuta.get(params.id)
        
        if (!minutaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'minuta.label', default: 'Minuta'), params.id])
            redirect(action: "crearMinuta")
            return
        }
            
        def user=springSecurityService.getCurrentUser() 
        
        def principal = springSecurityService.principal
        String role = principal.authorities
        
        if(user.id == minutaInstance.responsable.id || role == "[ROLE_Administrador]")
        {
            
            def puntosTratarInstance = PuntoTratar.findAllByMinuta(minutaInstance)
            def acuerdoInstance = Acuerdo.findAllByMinuta(minutaInstance)
            def acuerdoLista = new Acuerdo(params)           
            def usuarioInstance = minutaInstance.usuario
            def usuarioInternoInstance = Usuario.findAllByTipo("Interno")
            def usuarioExternoInstance = Usuario.findAllByTipo("Externo")
            def tipoReunionInstance = TipoReunion.findAllByEstado("Activo")
            
            
        
            [usuarioExternoInstance:usuarioExternoInstance,usuarioInternoInstance:usuarioInternoInstance,usuarioInstance:usuarioInstance, minutaInstance: minutaInstance,puntosTratarInstance:puntosTratarInstance,acuerdoInstance:acuerdoInstance,acuerdoLista:acuerdoLista,tipoReunionInstance:tipoReunionInstance]
        }
        else
        {
            flash.message = "El usuario registrado no es responsable de la minuta"
            redirect(action: "crearMinuta")
        }
    }

    def update() {
        println params
        def seguimiento
        if(!params.seguimiento) {seguimiento='Sin seguimiento'}
        else {seguimiento = params.seguimiento}

        def paraMensaje
        def validar,prefinalizada=false  
        def cont = 0,seguimientoAcuerdo=[]
     
        
        if(params.estadoMinuta=="Finalizada")
        {  
            try
            {
                params.descripcionAcuerdo.length
                for(int i=0; i<params.descripcionAcuerdo.size(); i++){
 
                    if(params.numUsuarioAcuerdo[i]=="0")
                    {
                        flash.message = "Uno o varios acuerdos no tiene asignado un responsable."
                        redirect(action: "continuarMinuta", id: params.id)
                        return;
                    }
                }
            }
            catch(Exception e)
            {
                if(params.numUsuarioAcuerdo=="0")
                {
                    flash.message = "Uno o varios acuerdos no tiene asignado un responsable."
                    redirect(action: "continuarMinuta", id: params.id)
                    return;
                }
            }
        }
        
        if(params.estadoMinuta=="Prefinalizada")
        { 
            prefinalizada=true
            
            if(!params.pTratar || !params.descripcionAcuerdo || !params.lugar || !params.objetivo || !params.pTratar || !params.descripcionAcuerdo )
            {
                params.estadoMinuta = "Iniciada"
                params.fechaF = ""
                params.horaFin = ""
                paraMensaje = "error"
                prefinalizada=false
                
            }
            else
            {
                params.estadoMinuta = "Finalizada"
            }
           
            
            if(params.pTratar)
            {
                try
                {
                    def contadorPunto = 0  
                    params.pTratar.length
                    for(int i=0; i<params.pTratar.size(); i++){
                        if(!params.pTratar[i])
                        {
                            contadorPunto++
                            
                        }
                    }
                    if (contadorPunto == params.pTratar.size())
                    {
                        params.estadoMinuta = "Iniciada"
                        params.fechaF = ""
                        params.horaFin = ""
                        validar = "punto"
                        prefinalizada=false
                    }
                }
                catch(Exception)
                {
                    
                }
            }
           
            if(params.descripcionAcuerdo)
            {
                try
                {
                    
                
                    def contadorPunto = 0  
                    params.descripcionAcuerdo.length
                    
                    for(int i=0; i<params.descripcionAcuerdo.size(); i++){
                        if(!params.descripcionAcuerdo[i])
                        {
                            contadorPunto++
                            
                        }
                        else if(params.numUsuarioAcuerdo[i]=="0")
                        {
                            params.estadoMinuta = "Iniciada"
                            params.fechaF = ""
                            params.horaFin = ""
                            validar = "UsuarioAcuerdo"
                            prefinalizada=false
                            
                        }
                       
                    }
                    if (contadorPunto == params.descripcionAcuerdo.size())
                    {
                        params.estadoMinuta = "Iniciada"
                        params.fechaF = ""
                        params.horaFin = ""
                        validar = "descripcion"
                        prefinalizada=false
                    }
                }
                catch(Exception e)
                {
                    if(params.numUsuarioAcuerdo=="0")
                    {
                        params.estadoMinuta = "Iniciada"
                        params.fechaF = ""
                        params.horaFin = ""
                        validar = "UsuarioAcuerdo"
                        prefinalizada=false
                        
                    }
                }
            }
            
            if(!params.lugar){
                validar = "lugar" 
            }else if(!params.objetivo){
                validar = "objetivo" 
            }else if(!params.pTratar ){
                validar = "punto"
            }else if(!params.descripcionAcuerdo){
                validar = "descripcion"
            
            
            }
        }
       
        
        
       
      
          
        
        if(params.fechaI)
        {
            params.fechaInicio =  new Date()       
            String[] fechainicio = params.fechaI.split("/");     
            params.fechaInicio.setDate(Integer.parseInt(fechainicio[0]))        
            params.fechaInicio.setMonth(Integer.parseInt(fechainicio[1])-1)
            params.fechaInicio.setYear(Integer.parseInt(fechainicio[2])-1900)         
          
        }
        if(params.fechaF)
        {
            
            params.fechaFin = new Date() 
            String[] fechafin = params.fechaF.split("/");     
            params.fechaFin.setDate(Integer.parseInt(fechafin[0]))        
            params.fechaFin.setMonth(Integer.parseInt(fechafin[1])-1)
            params.fechaFin.setYear(Integer.parseInt(fechafin[2])-1900)       
            
            
        }     
        
        List usuarioLista = new ArrayList()
        try 
        {
           
            params.emailExterno.length
            def validarExterno
            for(def i=0; i<params.emailExterno.length; i++)
            {
                if(params.emailExterno[i])
                {
                    def externoInstance = Usuario.findByUsername(params.emailExterno[i]+"/"+params.identificador)               
                    if(!externoInstance){
                    
                        def usuarioExterno = new Usuario(username:params.emailExterno[i]+"/"+params.identificador,password:"123",correoElectronico:params.emailExterno[i],nombre:params.nombreExterno[i],organizacion:params.organizacionExterno[i],puesto:params.puesto[i],tipo:"Externo",enabled:true)
                    
                        if(!usuarioExterno.save(flush:true))

                        {         

                            validar = "validarExterno"
                        }
                        else
                        {              
                            externoInstance = usuarioExterno
                            usuarioLista.add(externoInstance.id)
                        }
                    }
                    else
                    {
                        if(params.estadoMinuta !="Finalizada")
                        {
                            externoInstance.nombre = params.nombreExterno[i]
                            externoInstance.organizacion = params.organizacionExterno[i]
                            externoInstance.puesto = params.puesto[i]
                            externoInstance.save(flush:true) 
                        }
                        usuarioLista.add(externoInstance.id) 
                    }
                }
            }
            
        }
        catch(Exception)
        {
            if(params.emailExterno)
            {
                def externoInstance = Usuario.findByUsername(params.emailExterno+"/"+params.identificador) 
                if(!externoInstance){
                    
                    def usuarioExterno = new Usuario(username:params.emailExterno+"/"+params.identificador,password:"123",correoElectronico:params.emailExterno,nombre:params.nombreExterno,organizacion:params.organizacionExterno,puesto:params.puesto,tipo:"Externo",enabled:true)
                   
                    
                    if(!usuarioExterno.save(flush:true))
                    {
                        validar = "validarExterno"                                          
                    }
                    else
                    {
                        externoInstance = usuarioExterno
                        usuarioLista.add(externoInstance.id)
                    }
                }
                else
                {                 
                    externoInstance.nombre = params.nombreExterno
                    externoInstance.organizacion = params.organizacionExterno
                    externoInstance.puesto = params.puesto
                    externoInstance.save(flush:true)                   
                    usuarioLista.add(externoInstance.id)
                }

                  
                
            }
        }

        try
        {
            params.usuario.length
            for(def i=0; i<params.usuario.size(); i++)
            {
                usuarioLista.add(params.usuario[i])
            }
        }
        catch (Exception e)
        {
            usuarioLista.add(params.usuario)
        }

        
        def usuarioConAcuerdo = []
        usuarioConAcuerdo = params.usuarioAcuerdo
        try{
                
           
          
            usuarioConAcuerdo.length
            for(def i=0; i<usuarioConAcuerdo.size(); i++){
               
                def participanteAcuerdo=false
                for(def j=0; j<usuarioLista.size(); j++)
                {
                   
                    if((usuarioConAcuerdo[i]).toString() == (usuarioLista[j]).toString())
                    {
                       
                        participanteAcuerdo=true
                    }
                }
                if (participanteAcuerdo==false)
                { 
                    usuarioLista.add(usuarioConAcuerdo[i]) 
                    validar = "participante"
                }
            }
        }
        catch(Exception e)
        {
            if(usuarioConAcuerdo)
            {
               
                def participanteAcuerdo=false
                for(def j=0; j<usuarioLista.size(); j++)
                {
                   
                    if((usuarioConAcuerdo).toString() == (usuarioLista[j]).toString())
                    {
                        
                        participanteAcuerdo=true
                    }
                }
                if (participanteAcuerdo==false)
                { 
                    usuarioLista.add(usuarioConAcuerdo) 
                    validar = "participante"
                }
                
            }
        }
        
        
        String [] totalUsuarios = usuarioLista      
        params.usuario = totalUsuarios
        
    
        
        def minutaInstance = Minuta.get(params.id)     
        if (!minutaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'minuta.label', default: 'Minuta'), params.id])
            redirect(action: "crearMinuta")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (minutaInstance.version > version) {               
                flash.message = "Mientras usted editaba, otro usuario ha actualizado su Minuta."
                redirect(action: "continuarMinuta", id: minutaInstance.id)
                return
            }
        }

        //        if(params.estadoMinuta=="Finalizada"){
        //        
        //        if(!params.pTratar || !params.descripcionAcuerdo){            
        //            params.estadoMinuta="Iniciada" 
        //            params.fechaFin = null
        //            params.horaFin = null
        //             
        //            //            
        //        }
        //        } 

        minutaInstance.properties = params
        minutaInstance.save(flush: true)

        def puntoTratarInstance = PuntoTratar.findAllByMinuta(minutaInstance)
        
        def tamanio = puntoTratarInstance.size()
        
        for(def i=0; i<tamanio; i++){ 
            puntoTratarInstance[i].delete(flush: true)    
        }
       
        try
        {
           
            params.pTratar.length
            for(int i=0; i<params.pTratar.size(); i++){
                if(params.pTratar[i])
                {
                    
                    puntoTratarInstance=new PuntoTratar(puntoTratar:params.pTratar[i],minuta:minutaInstance) 
                    puntoTratarInstance.save(flush:true)
                    
                }
            }
        }
        catch(Exception)
        {
            if(params.pTratar)
            {
                puntoTratarInstance=new PuntoTratar(puntoTratar:params.pTratar,minuta:minutaInstance) 
                puntoTratarInstance.save(flush:true)
                
            }
        }
        
        def acuerdoInstance = Acuerdo.findAllByMinuta(minutaInstance)
        
        def tamanioAcuerdo = acuerdoInstance.size()
        
        for(def i=0; i<tamanioAcuerdo; i++){
            acuerdoInstance[i].delete(flush: true)    
        }
        
       
         
        try
        {
          
            params.descripcionAcuerdo.length
            def contador=0
            for(int i=0; i<params.descripcionAcuerdo.size(); i++)
            { 
                if(params.descripcionAcuerdo[i])
                { 
                    def fechaDate=new Date()
                    //String[] usuarioFinalArray=usuarioFinal.split(",\\s") 
                
                    String[] fechaCompromisoF = params.fechaCompromiso[i].split("/");     
                    fechaDate.setDate(Integer.parseInt(fechaCompromisoF[0]))
                    fechaDate.setMonth(Integer.parseInt(fechaCompromisoF[1])-1)
                    fechaDate.setYear(Integer.parseInt(fechaCompromisoF[2])-1900)   
                
                                    
                
                    def pruebaInstancia=[]
                
                    def usuarioInstance
                    for(def j=0; j<Integer.parseInt(params.numUsuarioAcuerdo[i]); j++)
                    { 
                        usuarioInstance = Usuario.findById(params.usuarioAcuerdo[contador])
                        
                        pruebaInstancia.add(usuarioInstance)
                        contador++
                    }
                 
                   
                 
                
                    def acuerdoInstancia= new Acuerdo(usuario:pruebaInstancia, descripcionAcuerdo:params.descripcionAcuerdo[i],fechaCompromiso:fechaDate,estado:params.estado[i],minuta:minutaInstance, seguimiento:seguimiento)
                
                    acuerdoInstancia.save(flush: true)
                
                    def estado = acuerdoInstancia.properties.estado
                }
            }
                       
            def instancia = Acuerdo.findAllByMinuta(minutaInstance)
            
            def id = minutaInstance.id
            def estadoA = instancia.estado
            def noInstancia = instancia.size()   
            
            if(params.estadoMinuta == "Finalizada"){

                for(def j = 0; j<instancia.size(); j++){

                    if(estadoA[j] == "Cancelado" || estadoA[j] == "Delegado" || estadoA[j] == "Realizado"){
                        cont = cont + 1
                    }
                }

                if(cont == noInstancia){
                    //Cambia el estado de la minuta a CERRADA
                    params.estadoMinuta = "Cerrada"
                    Minuta.executeUpdate("UPDATE Minuta SET estado_minuta ='Cerrada' WHERE id ='${id}'")
                       
                }
            }
        }
        catch(Exception e){
       
           
            if(params.descripcionAcuerdo)
            {        
               
                def fechaDate=new Date() 
                String[] fechaCompromisoF = params.fechaCompromiso.split("/");  
                fechaDate.setDate(Integer.parseInt(fechaCompromisoF[0]))        
                fechaDate.setMonth(Integer.parseInt(fechaCompromisoF[1])-1)
                fechaDate.setYear(Integer.parseInt(fechaCompromisoF[2])-1900) 
               
                def acuerdoInstancia= new Acuerdo(usuario:params.usuarioAcuerdo, descripcionAcuerdo:params.descripcionAcuerdo,fechaCompromiso:fechaDate,estado:params.estado,minuta:minutaInstance,seguimiento:seguimiento)
            
                acuerdoInstancia.save(flush: true)
                
            }       
                        
            def instancia = Acuerdo.findAllByMinuta(minutaInstance)
            
            def id = minutaInstance.id
            def estadoA = instancia.estado
            def noInstancia = instancia.size()   
           // def seguimientos = instancia.seguimiento
            
            //println instancia.size()
            //println estadoA[0]
            //println ""
            
            if(params.estadoMinuta == "Finalizada"){
                for(def j = 0; j<instancia.size(); j++){
                   //println j
                   //println "estadoA " + estadoA[j]
                    if(estadoA[j] == "Cancelado" || estadoA[j] == "Delegado" || estadoA[j] == "Realizado"){
                        cont = cont + 1
                    }
                }

                if(cont == noInstancia){
                    //Cambia el estado de la minuta a CERRADA
                    params.estadoMinuta = "Cerrada"
                    Minuta.executeUpdate("UPDATE Minuta SET estado_minuta ='Cerrada' WHERE id ='${id}'")                    
                    //println "Dato cambiado satisfactoriamente"

                }
            }
        }
    
        ////////////////////////////////////VALIDACIONES///////////////////////////////////
       
        if(paraMensaje == "error")
        {
            flash.message ="Falta agregar acuerdos y puntos a tratar."            
        }else{
            flash.message = "Los cambios se realizaron correctamente."
        }
        if(validar == "lugar"){
            flash.message = "Ingrese el lugar en datos generales."
        }
        if(validar == "objetivo" ){
            flash.message = "Ingrese el objetivo en datos generales."
        }
        if(validar == "punto"){
            flash.message = "Ingrese puntos a tratar."
        }
        if(validar == "descripcion"){
            flash.message = "Ingrese la descripción en acuerdos."
        }
        if(validar=="participante"){
            flash.message = "Uno o varios participantes no pueden ser eliminados, porque estan asignados a un acuerdo."
        }
        if( validar=="validarExterno"){
            flash.message = "El participante externo no pudo ser guardado, por que falto ingresar algunos campos o el correo era incorrecto."
        }
        if(validar=="UsuarioAcuerdo"){
            flash.message = "Uno o varios acuerdos no tiene asignado un responsable."
        }
        
        
        ////////////////////////////////////VALIDACIONES///////////////////////////////////
        def mensajeCorreo
       
        if(params.estadoMinuta == "Cerrada" && cont)
        {
            redirect(action:"list", controller:"seguimientoMinuta")
        }
        else
        {
            if(prefinalizada){                              
                
                try
                {
                    notificacion()
                    flash.message ="Se ha enviado un correo a todos los participantes con la información de la minuta."
                }
                catch(Exception e)
                {
                    flash.message ="No se pudo enviar el correo."
                }
            }           
            redirect(action: "continuarMinuta", id: minutaInstance.id)
                  
        }
    }
    
    
    
    def delete() {
        def minutaInstance = Minuta.get(params.id)
        if (!minutaInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'minuta.label', default: 'Minuta'), params.id])
            redirect(action: "list")
            return
        }

        try {
            minutaInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'minuta.label', default: 'Minuta'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'minuta.label', default: 'Minuta'), params.id])
            redirect(action: "show", id: params.id)
        }
       
    }

    def eliminarMinuta(){
        
        def id = params.id
        
        
        def minutaInstance = Minuta.get(id)
       
        if(minutaInstance){   
            def puntoTratarInstance = PuntoTratar.findAllByMinuta(minutaInstance)           
            def tamanio = puntoTratarInstance.size()      
            for(def i=0; i<tamanio; i++){
               
            
                puntoTratarInstance[i].delete(flush: true)    
            }
             
            def acuerdoInstance = Acuerdo.findAllByMinuta(minutaInstance)        
            def tamanioAcuerdo = acuerdoInstance.size()          
            for(def i=0; i<tamanioAcuerdo; i++){
           
            
                acuerdoInstance[i].delete(flush: true)    
            }
        }
       
        try{
            minutaInstance.delete(flush:true)
        }catch(Exception){
            
        } 
        flash.message = "La minuta se eliminó correctamente"
        redirect(action: "list", controller:"Minuta")
    }
   
    
    
    
    def notificacion(){
        
      
        
        def identificador = params.identificador
        def responsable = params.responsable.nombre
        def lugar = params.lugar
        def objetivo  = params.objetivo
        def fechaFin = params.fechaF
        def fechaInicio = params.fechaI
        def horaInicio =params.horaInicio
        def horaFin = params.horaFin
            
        def usuario = params.usuario
        
        
        def puntoTratar = params.pTratar
        def descripcion = params.descripcionAcuerdo
        def usuarioAcuerdo = params.usuarioAcuerdo
        def numUsuarioAcuerdo = params.numUsuarioAcuerdo
        def fechaCompromiso = params.fechaCompromiso
        def estado = params.estado
        def seguimiento = params.seguimiento
        def tipoRInstance = TipoReunion.get(params.tipoReunion.id)
        def miAcuerdo = ''
        String usuarioInstance = ""
        String punto = '<tr><td colspan="4" style="background:#D8D8D8;">'   
        String descripcionN = ""
        String fechaCom = ""
        String estadoM = ""
        String usAcuerdo = ""
                  
        try{
            for(def j=0; j<params.usuario.size(); j++){
                String usuarioInstanceE = Usuario.get(params.usuario[j])
                //              String usuarioInstanceE = usuario[j]
                usuarioInstance = usuarioInstance +usuarioInstanceE+'</td></tr><tr><td colspan="4" style="background:#D8D8D8;" >'
               
            }
        }catch(Exception){
            usuario.length
        }
        
        
        try{    
            puntoTratar.length
            for(def x=0; x<puntoTratar.size(); x++){
                String punto1 =  puntoTratar[x] 
                punto =  punto + punto1 +'</td></tr><tr><td colspan="4" style="background:#D8D8D8;">'
            }     
            punto =  punto +'</td></tr>'
        }catch(Exception){ 
           
            String punto1 =  puntoTratar 
            punto =  punto1     
        }
       
        
        
        
        "\n"+'<tr align="left" ><td>'+descripcionN+'</td> <td>'+usAcuerdo+'<br/></td> <td>'+fechaCom+'</td> <td>'+estadoM+'</td></tr><table> '        
        try{
            
            params.descripcionAcuerdo.length
            def contador=0
            for(int i=0; i<params.descripcionAcuerdo.size(); i++) {
               
                miAcuerdo=miAcuerdo+'<tr align="left">'
          
                miAcuerdo=miAcuerdo+'<td style="background:#D8D8D8; text-align:center;">'+params.descripcionAcuerdo[i]+'</td>'
            
                miAcuerdo=miAcuerdo+'<td style="background:#D8D8D8; text-align:center;">'
                def pruebaInstancia=[]
                def usuarioAcuerdoInstance
                for(def j=0; j<Integer.parseInt(params.numUsuarioAcuerdo[i]); j++)
                { 
                    usuarioAcuerdoInstance = Usuario.findById(params.usuarioAcuerdo[contador])
                    miAcuerdo=miAcuerdo+usuarioAcuerdoInstance+'<br>'
                   
                    contador++
                }

                
                miAcuerdo=miAcuerdo+'</td>'
            
                miAcuerdo=miAcuerdo+'<td style="background:#D8D8D8; text-align:center;">'+params.fechaCompromiso[i]+'</td>'
           
                miAcuerdo=miAcuerdo+'<td style="background:#D8D8D8; text-align:center;">'+params.estado[i]+'</td>'
                miAcuerdo=miAcuerdo+'</tr>'      
            }
        }
        catch (Exception)
        {
            miAcuerdo=miAcuerdo+'<tr align="left">'
          
            miAcuerdo=miAcuerdo+'<td style="background:#D8D8D8; text-align:center;">'+params.descripcionAcuerdo+'</td>'
            
            miAcuerdo=miAcuerdo+'<td style="background:#D8D8D8; text-align:center;">'
            def pruebaInstancia=[]
            def usuarioAcuerdoInstance
            
                        
            
            if(params.numUsuarioAcuerdo != "1"){
                                               
                for(def j=0; j<Integer.parseInt(params.numUsuarioAcuerdo); j++)
                { 
                    if(Integer.parseInt(params.numUsuarioAcuerdo)==1)
                    {
                        usuarioAcuerdoInstance = Usuario.findById(params.usuarioAcuerdo)
                    }
                    usuarioAcuerdoInstance = Usuario.findById(params.usuarioAcuerdo[j])
                    miAcuerdo=miAcuerdo+usuarioAcuerdoInstance+'<br>'
                }
            }
            else{
                usuarioAcuerdoInstance = Usuario.findById(params.usuarioAcuerdo)
                miAcuerdo=miAcuerdo+usuarioAcuerdoInstance+'<br>'
            }
                
            miAcuerdo=miAcuerdo+'</td>'
            
            miAcuerdo=miAcuerdo+'<td style="background:#D8D8D8; text-align:center;">'+params.fechaCompromiso+'</td>'
           
            miAcuerdo=miAcuerdo+'<td style="background:#D8D8D8; text-align:center;">'+params.estado+'</td>'
            miAcuerdo=miAcuerdo+'</tr>' 
            
        }
       
        
        
        def user=springSecurityService.getCurrentUser() 
        def correoResponsable=user.properties.correoElectronico       
        for(def i=0; i<params.usuario.size(); i++){
            def usuarioInstance1= Usuario.get(params.usuario[i])
            def final2 = usuarioInstance1.properties.correoElectronico 
            def nombre = usuarioInstance1.properties.nombre
           
   
            notificarMinuta(correoResponsable,final2,identificador,responsable,lugar,objetivo,tipoRInstance,fechaInicio,horaInicio,fechaFin,horaFin,usuarioInstance,punto,descripcionN,usAcuerdo ,fechaCom,estadoM,miAcuerdo)           

               
        }
        
       
    }
    
    def notificarMinuta(correoResponsable,final2,identificador,responsable,lugar,objetivo,tipoRInstance,fechaInicio,horaInicio,fechaFin,horaFin,usuarioInstance,punto,descripcionN,usAcuerdo,fechaCom,estadoM,miAcuerdo){
        
        mailService.sendMail {
            to final2
            from correoResponsable
            subject "Informacion de " + identificador
            //html (view:"/minuta/informacion", model:[identificador:identificador])
            html '<table align="center" width="700px" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size:12px;"><th style="background:#585858; color:white;" height="40" colspan="4">Identificador:&nbsp;'+identificador+'</th>'+
            "\n"+'<tr align="left"> <th style="background:#585858; color:white;">Responsable:</th> <td style="background:#D8D8D8;">'+responsable+'</td> <th style="background:#585858; color:white;" height="30">Lugar:</th><td style="background:#D8D8D8;">'+lugar+'</td></tr>'+
            "\n"+'<tr align="left"><th style="background:#585858; color:white;" >Tipo de reunión:</th> <td style="background:#D8D8D8;">'+tipoRInstance+'</td><th style="background:#585858; color:white;" height="30">Objetivo:</th> <td style="background:#D8D8D8;">'+objetivo+'</td></tr>'+
            "\n"+'<tr align="left"><th style="background:#585858; color:white;" >Fecha inicio:</th> <td style="background:#D8D8D8;">'+fechaInicio+'</td><th style="background:#585858; color:white;" height="30">Hora inicio:</th><td style="background:#D8D8D8;">'+horaInicio+'</td></tr>'+
            "\n"+'<tr align="left"><th style="background:#585858; color:white;"> Fecha fin:</th><td style="background:#D8D8D8;">'+fechaFin+'</td><th style="background:#585858;color:white;" height="30">Hora fin:</th><td style="background:#D8D8D8;">'+horaFin+'</td></tr></table>'+
            "\n"+'<table align="center" width="700px" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size:12px;" ><tr><td height="10" colspan="2"></td></tr><tr style="background:#585858; color:white;"><th height="40" colspan="4">Participantes</th></tr><tr ><td colspan="4" style="background:#D8D8D8;">'+usuarioInstance+'</td></tr></table>'+
            "\n"+'<table align="center" width="700px" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size:12px;" ><tr><td height="10" colspan="2"></td></tr><tr style="background:#585858; color:white;"><th height="40" colspan="4">Puntos a tratar</th></tr><td style="background:#D8D8D8;">'+punto+'</td></tr></table>'+
            "\n"+'<table align="center"  style="text-align:center;" width="700px" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size:12px;"><tr><td height="10" colspan="2"></td></tr><tr style="background:#585858; color:white;"><th height="40" colspan="4" style="background:#585858;">Acuerdos</th></tr>'+
            "\n"+'<tr align="center"><th style="background:#585858; color:white;" height="20">Descripción:</th><th style="background:#585858; color:white;" height="20">Responsable:</th><th style="background:#585858; color:white;" height="20">Fecha compromiso:</th><th style="background:#585858; color:white;" height="20">Estado:</th></tr>'+
            "\n"+miAcuerdo+'</table>'  
        }
    }

    def uploadFile(){
       
        def file=request.getFile('myFile')
        def nameFile = file.originalFilename
      
       
        def destinationDirectory = "files/"
        //def name = params.minutaIdentificador
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath(destinationDirectory)

        def storagePathDirectory = new File(storagePath)
        if(!storagePathDirectory.exists()){
            //println "CREATING DIRECTORY ${storagePath}"
            if(storagePathDirectory.mkdirs()){

                }else{

                }
        }

        if(!file.isEmpty()){
            Minuta.executeUpdate("update Minuta d set d.upload='${storagePath}/${nameFile}' "+
                "where d.id=${params.minutaId as int}")
            file.transferTo(new File("${storagePath}/${nameFile}"))
            flash.message ="¡El archivo se ha cargado correctamente!"
            redirect(action: "continuarMinuta", id: params.minutaId)

        }else{
            flash.error="¡El archivo no pudo ser cargado!"
        }
    }

    def downloadFile(){
        InputStream contentStream
        def minutaInstance = Minuta.get(params.id) 
        def directory = minutaInstance.upload
        def arreglo = [] 
        arreglo = directory.split("/")
        def pos
        for(int x=0;x<arreglo.length;x++){
            if(arreglo[x].equals("files"))pos=x
        }
        def fileName = arreglo[pos+1]
        def servletContext = ServletContextHolder.servletContext
        def storagePath = servletContext.getRealPath("files/")
        //  fileName = file.name
        def file = new File("${storagePath}/${fileName}")

        //def file = new File(servletContext.getRealPath("files/"+params.identificador))
        
        if(file.exists()){
            response.setContentType("application/octet-stream")
            response.setHeader("Content.disposition","attachment; filename=filename-with-extension")
            response.setContentType("file-mime-type")
        contentStream = file.newInputStream()
        response.outputStream << contentStream
        webRequest.renderView = false
            //response.outputStream << file.bytes
            return
        }
        else{
            flash.message= "Error al intentar descargar el archivo"
            redirect(action: "continuarMinuta", id: minutaInstance.id)
        }
    }
}