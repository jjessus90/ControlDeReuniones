package ControlDeReuniones

class CorreoController {
    
    def mailService
    static allowedMethods = [correoEnviado: "POST"]
  
    def correo(){
       
            //println "parametros " + params

            //Declaración de variables
            def acuerdoInstance = Acuerdo.get(params.id)              
            def minuta = acuerdoInstance.minuta
            def id = acuerdoInstance.id
            
            def responsable = minuta.responsable
            def correo = responsable.properties.correoElectronico
            
            //Variables para construcción del mensaje y asunto de la interfaz de correo
            def identificador = acuerdoInstance.minuta.identificador        
            def descripcion = acuerdoInstance.descripcionAcuerdo
            String asunto = "Notificación del acuerdo: " + descripcion
            String msj = "Se le informa que el acuerdo " + descripcion + " de la Minuta con identificador '" + identificador + "' está próximo a vencer."

            String usuario = acuerdoInstance.properties.usuario     
            String usuarioFinal = ""
               
            
            //Se le quitan los corchetes a la lista que contiene los usuarios
            def usua = new ArrayList()
            String usu = acuerdoInstance.properties.usuario
            
            for(def i=1; i<usu.size()-1; i++){            
                usua.add(usu[i])           
            }        
            for(def i=0; i<usua.size(); i++)
            {
                usuarioFinal = usuarioFinal + usua[i]
            }
            
        
            //Si son mas de dos correos, se separan por (,)  y espacio (\\s) para mostrarlos en la interfaz de correo
            String[] usuarioFinalArray = usuarioFinal.split(",\\s") 
            String correoUsuario2 = ""
            try{
            for(String usuariosFinal:usuarioFinalArray){
                def correoUsuario = Usuario.findByNombre(usuariosFinal)                   
                correoUsuario2 = correoUsuario2 + correoUsuario.correoElectronico + ", "        
            } 
        }catch(Exception e){
            println "Exeption " + e
            
        }    
       
            
            //Variables que se muestran en la interfaz de correo
            //Para, Asunto, Mensaje, De, Id
            [correoUsuario2:correoUsuario2, asunto:asunto, msj:msj, correo:correo, id:id]
        }
  
    
    def correoEnviado(){
            //println "//// " + params
            
            //Se toman los datos de la vista CorreoEnviado y se envían al servicio CorreoNotificacionAcuerdoService
            def subjet = params.asuntos
            def body = params.mensajes
            def correoRespo = params.correo
            
            //Variable id, para redireccionar al gps de correo 
            def id = params.id
           
            //Cacha los errores, cuando no se puede enviar un correo, ej. Cuando no hay servicio de internet
            try{
                //Se se paran los correos por coma y espacio para poder enviar
                def correos = params.para.split(",\\s*")
                def cc = params.cc.split(",\\s*")
                def cco = params.cco.split(",\\s*")

                enviarCorreo(correos, subjet, body, correoRespo, cc, cco)

                //For que envia correos a los participates 
//                for(def i=0; i<correos.size(); i++){
//                    enviarCorreo(correos[i], subjet, body, correoRespo)
//                    flash.mensaje = "Por favor espere, su correo se esta enviando"
//                }
                flash.message = "Mensaje enviado."
                redirect(action:"correo", controller:"Correo", id:id)
            }
            catch(Exception e){
                println "Exeption " + e
                flash.message = "Falló en el envío de correo(s). Inténtelo más tarde."
                def mensaje1 = flash.message = "Falló el envío de correo(s). Revise que los correos ingresados estén escritos correctamente o inténtelo más tarde."
                redirect(action:"correo", controller:"Correo", id:id)
            }
    }
    def enviarCorreo(correoElectronico, asunto, mensaje, correoResponsable, conC, conCO){
        //"jm.rangel@live.com.mx", "joseesparza@utez.edu.mx"
        //"josuemartinez@utez.edu.mx", "joseestrada@utez.edu.mx"
        mailService.sendMail {
            to correoElectronico
            from correoResponsable
            cc conC
            bcc conCO
            subject asunto
            body mensaje
        }
    }
}
