package ControlDeReuniones


import org.springframework.dao.DataIntegrityViolationException
import javax.sql.DataSource
import org.codehaus.groovy.grails.commons.ConfigurationHolder
import groovy.sql.*

class HistorialController {
    

    def springSecurityService
    def authenticationTrustResolver
    
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    

    def index() {
        redirect(action: "lista", params: params)
    }

    def lista() {
        
        
        def u
        def annoi, mesi, diai, annof, mesf, diaf
        def results
        
        def today = new Date()
        def currentDate =  today.format("yyyy-MM-dd").toString()
    
        currentDate = currentDate + " 23:59:59"
        
        def lista,listaGral, listar 
        
        if (springSecurityService.isLoggedIn()) {

            def principal = springSecurityService.principal
        
            String role = principal.authorities
      
            if(role.equals("[ROLE_Administrador]")){
               
                u = "admin"
       
            }else if(role.equals("[ROLE_Responsable]")){
                
                def user=springSecurityService.getCurrentUser() 
                u=user.properties.id
                
            }
        }
        
        if(params.fechaInicio){
            
            
            diai = params.fechaInicio[0] + params.fechaInicio[1]
            mesi = params.fechaInicio[3] + params.fechaInicio[4]
            annoi = params.fechaInicio[6] + params.fechaInicio[7] + params.fechaInicio[8] + params.fechaInicio[9]
            params.fechaInicio2 = annoi + "-" +  mesi + "-" + diai + " 00:00:00"
                
                
            
            if(params.fechaFinal){
                
                                
                
                    
                diaf = params.fechaFinal[0] + params.fechaFinal[1]
                mesf = params.fechaFinal[3] + params.fechaFinal[4]
                annof = params.fechaFinal[6] + params.fechaFinal[7] + params.fechaFinal[8] + params.fechaFinal[9]
                    
                params.fechaFinal2 = annof + "-" +  mesf + "-" + diaf + " 23:59:59"
                
                if(params.tipo){
                    //búsqueda por todo
                   
                    def tipoReunionInstance = TipoReunion.findByNombre(params.tipo)
                    if(u =="admin"){
                        if(params.fechaInicio2<=params.fechaFinal2){
                       
                            if(params.max && params.offset){
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            else{
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            results = listaGral.size
                            flash.message = "Se encontraron "+ results +" resultados."
                            [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, fechaDeInicio: params.fechaInicio, fechaDeFin: params.fechaFinal, results: results]
                        }
                        else{
                            flash.message ="El rango de fechas es inválido."
                        }
                       
                    }
                    else{
                        //responsable
                        if(params.fechaInicio2<=params.fechaFinal2){
                       
                            if(params.max && params.offset){
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND responsable_id= "+u+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"') AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND responsable_id= "+u+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND responsable_id= "+u+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"') AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND responsable_id= "+u+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            else{
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND responsable_id="+u+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND responsable_id="+u+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND responsable_id="+u+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND tipo_reunion_id= '"+tipoReunionInstance.id+"' AND responsable_id="+u+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")   
                                }
                                
                            }
                            results = listaGral.size
                            flash.message = "Se encontraron "+ results +" resultados."
                            [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, fechaDeInicio: params.fechaInicio, fechaDeFin: params.fechaFinal, results: results]
                        }
                        else{
                            flash.message = "El rango de fechas es inválido."
                        }
                    
                    }
                    
                }
                else if(params.fechaInicio2<=params.fechaFinal2){
                    //búsqueda por fechas
                   
                    if(u =="admin"){
                        if(params.fechaInicio2 <= params.fechaFinal2){
                            if(params.max && params.offset){
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            else{
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                       
                            }
                            results = listaGral.size
                            flash.message = "Se encontraron "+ results +" resultados."
                            [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, fechaDeInicio: params.fechaInicio, fechaDeFin: params.fechaFinal, results: results]
                        }
                        results = listaGral.size
                        flash.message = "Se encontraron "+ results +" resultados."
                        [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, fechaDeInicio: params.fechaInicio, fechaDeFin: params.fechaFinal, results: results]
                    }
                    else{
                        //responsable
                        if(params.fechaInicio2 <= params.fechaFinal2){
                            if(params.max && params.offset){
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            else{
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+params.fechaFinal2+"' AND responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                       
                            }
                            results = listaGral.size
                            flash.message = "Se encontraron "+ results +" resultados."
                            [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, fechaDeInicio: params.fechaInicio, fechaDeFin: params.fechaFinal, results: results]
                        }
                        else{
                            flash.message = "El rango de fechas es inválido."
                        }
                        
                    }
                    
                }else{
                     
                    flash.message = "El rango de fechas es inválido."
                }
            }
           
            else{
                if(params.tipo){
                    // búsqueda por tipo y fecha inicio
                    def tipoReunionInstance = TipoReunion.findByNombre(params.tipo)
                    if(u=="admin"){
                        if(params.fechaInicio2<=currentDate){
                            if(params.max && params.offset){
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            else{
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0])
                                    listaGral = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND'" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")  
                                }else{
                                    lista = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0])
                                    listaGral = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND'" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")  
                                }
                                
                            }
                            results = listaGral.size
                            flash.message = "Se encontraron "+ results +" resultados."
                            [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, fechaDeInicio: params.fechaInicio, results:results]
                        }
                        else
                        flash.message = "No se pueden hacer búsquedas de fechas posteriores a la de hoy."
                        
                    }
                    else{
                        //responsable
                        if(params.fechaInicio2<=currentDate){
                            if(params.max && params.offset){
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' and responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' and responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' and responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' and responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            else{
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' and responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0])
                                    listaGral = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND'" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' and responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")  
                                }else{
                                    lista = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND '" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' and responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0])
                                    listaGral = Minuta.findAll ("from Minuta where fecha_inicio between '" + params.fechaInicio2 + "' AND'" + currentDate + "' AND  tipo_reunion_id= '"+tipoReunionInstance.id+"' and responsable_id='${u}' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")  
                                }
                                
                            }
                            results = listaGral.size
                            flash.message = "Se encontraron "+ results +" resultados."
                            [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, fechaDeInicio: params.fechaInicio, results:results]
                        }
                        else
                        flash.message = "No se pueden hacer búsquedas de fechas posteriores a la de hoy."
                    }
                    
                   
                } 
                else{
                    // búsqueda nadamas por fecha de inicio
                    if(u =="admin"){
                        if(params.fechaInicio2 <= currentDate){
                            if(params.max && params.offset){
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            else{
                                
                                if(params.sort && params.order){
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0]) 
                                    listaGral = Minuta.findAll("from Minuta  where fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            results = listaGral.size
                            flash.message = "Se encontraron "+ results +" resultados."
                            [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, fechaDeInicio: params.fechaInicio, results: results]
                        }
                        else{
                            flash.message = "No se pueden hacer búsquedas de fechas posteriores a la de hoy."
                        } 
                    }
                    else{
                        //responsable
                        if(params.fechaInicio2 <= currentDate){
                            if(params.max && params.offset)
                            {
                                if(params.sort && params.order){
                                    lista=Minuta.findAll("FROM Minuta   WHERE responsable_id="+u+" AND fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])                     
                                    listaGral=Minuta.findAll("FROM Minuta  WHERE  responsable_id="+u+" AND fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista=Minuta.findAll("FROM Minuta   WHERE responsable_id="+u+" AND fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])                     
                                    listaGral=Minuta.findAll("FROM Minuta  WHERE  responsable_id="+u+" AND fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            else
                            {
                                if(params.sort && params.order){
                                    lista=Minuta.findAll("FROM Minuta  WHERE  responsable_id="+u+" AND fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0])
                                    listaGral=Minuta.findAll("FROM Minuta  WHERE  responsable_id="+u+" AND fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }else{
                                    lista=Minuta.findAll("FROM Minuta  WHERE  responsable_id="+u+" AND fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0])
                                    listaGral=Minuta.findAll("FROM Minuta  WHERE  responsable_id="+u+" AND fecha_inicio between '"+params.fechaInicio2+"' AND '"+currentDate+"' AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                                }
                                
                            }
                            results = listaGral.size
                            flash.message = "Se encontraron "+ results +" resultados."
                            [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, fechaDeInicio: params.fechaInicio, results: results]
                        }
                        else{
                            flash.message = "No se pueden hacer búsquedas de fechas posteriores a la de hoy."
                        }
                    }
                   
                }
            }
        }
    
        else if(params.tipo){
            //búsqueda unicamente por tipo
                        
            def tipoReunionInstance = TipoReunion.findByNombre(params.tipo)
            if(u == "admin"){
                if(params.max && params.offset)
                {
                    if(params.sort && params.order){
                        lista=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id ="+tipoReunionInstance.id+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                        listaGral=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id ="+tipoReunionInstance.id+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')" )
                    }else{
                        lista=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id ="+tipoReunionInstance.id+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])
                        listaGral=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id ="+tipoReunionInstance.id+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')" )
                    }
                    
                    
                }
                else
                {
                    if(params.sort && params.order){
                        lista=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id ="+tipoReunionInstance.id+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0])
                        listaGral=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id ="+tipoReunionInstance.id+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')" )
                
                    }else{
                        lista=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id ="+tipoReunionInstance.id+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0])
                        listaGral=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id ="+tipoReunionInstance.id+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')" )
                
                    }
                    
                }
                
                
            }else{
                                                             
                if(params.max && params.offset)
                {
                    if(params.sort && params.order){
                        lista=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id='"+tipoReunionInstance.id+"' and responsable_id="+u+" AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])  
                        listaGral=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id='"+tipoReunionInstance.id+"' and responsable_id="+u+"AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                    }else{
                        lista=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id='"+tipoReunionInstance.id+"' and responsable_id="+u+"AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:Integer.parseInt(params.max),offset:Integer.parseInt(params.offset)])  
                        listaGral=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id='"+tipoReunionInstance.id+"' and responsable_id="+u+"AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")
                    }
                    
                    
                }
                else
                {
                    if(params.sort && params.order){
                        lista=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id='"+tipoReunionInstance.id+"' and responsable_id="+u+"AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada') order by "+params.sort+" "+params.order+"",[max:10,offset:0])  
                        listaGral=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id='"+tipoReunionInstance.id+"' and responsable_id="+u+"AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")                     
                    }else{
                        lista=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id='"+tipoReunionInstance.id+"' and responsable_id="+u+"AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')",[max:10,offset:0])  
                        listaGral=Minuta.findAll("FROM Minuta  WHERE tipo_reunion_id='"+tipoReunionInstance.id+"' and responsable_id="+u+"AND (estado_minuta = 'Cerrada' or estado_minuta = 'Cancelada')")                     
                    }
                        
                }
            }
            
            results = listaGral.size
            flash.message = "Se encontraron "+ results +" resultados."
            [listar: lista, minutaInstanceTotal: listaGral.size, tipoDeReunion: params.tipo, results:results]
            
        }
        else if(params.fechaFinal){
            flash.message = "Debe seleccionar tambien una de fecha de inicio."
        }
        else{  
         
            if(params.contador)
            {
                flash.message = "Debe seleccionar por lo menos un tipo de reunion." 
            }
            else{
                def contadorInstance=0
                return [contadorInstance:contadorInstance]
            }
              
        }
        
    }
    
    def limpiar(){
        redirect(action: "lista", controller: "Historial", params:params)
    }

    def verMinuta(){        
        flash.message = "" 
        redirect(action: "continuarMinuta", controller: "Minuta", params:params)
    }
    
}


//<g:set var="tamanioGet" value="${0}"/>
//                    <g:if test="${listar[i].objetivo.size()>30}">
//                      <script type="text/javascript">${tamanioGet=30};</script>
//                    </g:if>
//                    <g:else>
//                      <script type="text/javascript">${tamanioGet=(listar[i].objetivo.size()-1)}; </script>
//                    </g:else>
//                    <td class="tdDatos">${listar[i].objetivo.getAt(0..tamanioGet)}</td> 