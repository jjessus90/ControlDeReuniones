package ControlDeReuniones

import org.springframework.dao.DataIntegrityViolationException


class TipoReunionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "crear", params: params)
    }
    
    def ejeEditar(){
        redirect(action: "editar", params: params)
        
    }
    
    def eje(){
        
        [tipoReunionInstance: new TipoReunion(params)]
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoReunionInstanceList: TipoReunion.list(params), tipoReunionInstanceTotal: TipoReunion.count()]
    }
    
    def editar() {
        
        def tipoReunionInstance = TipoReunion.get(params.id)
        if (!tipoReunionInstance) {
            flash.message = ""
            redirect(action: "list", params: params)
            return
        }

        [tipoReunionInstance: tipoReunionInstance]
        
        
    }
    
    def update() {
        
        def tipoReunionInstance = TipoReunion.get(params.id)
        if (!tipoReunionInstance) {
            flash.message = "No se pudo editar."
            redirect(action: "crear")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (tipoReunionInstance.version > version) {
                tipoReunionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'tipoReunion.label', default: 'TipoReunion')] as Object[],
                          "Another user has updated this TipoReunion while you were editing")
                render(view: "crear", model: [tipoReunionInstance: tipoReunionInstance])
                return
            }
        }

        tipoReunionInstance.properties = params

        if (!tipoReunionInstance.save(flush: true)) {
            render(view: "crear", model: [tipoReunionInstance: tipoReunionInstance])
            return
        }

        flash.message = "Los datos se guardaron correctamente."
        redirect(action: "crear", id: tipoReunionInstance.id)
    }
    
    
    def crear() {
        def tipoReunionInstance
        if(params.id)
        {
             tipoReunionInstance = TipoReunion.get(params.id)
        }
        else
        {
            tipoReunionInstance = new TipoReunion(params)
        }
        
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoReunionInstance: tipoReunionInstance, tipoReunionInstanceList: TipoReunion.list(params), tipoReunionInstanceTotal: TipoReunion.count()]
    }
    
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [tipoReunionInstanceList: TipoReunion.list(params), tipoReunionInstanceTotal: TipoReunion.count()]
    }

    def create() {
        [tipoReunionInstance: new TipoReunion(params)]
    }
    
    def saveOriginal() {
  
        def tipoReunionInstance = new TipoReunion(params)
        if (!tipoReunionInstance.save(flush: true)) {
            render(view: "crear", model: [tipoReunionInstance: tipoReunionInstance, tipoReunionInstanceList: TipoReunion.list(params), tipoReunionInstanceTotal: TipoReunion.count()])
            return
        }

        flash.message = "El tipo de reunión se guardó correctamente."
        redirect(action: "crear")
    }
    
    def save(){
        
        
        def tipoReunionInstance = TipoReunion.findByNombre(params.nombre)  
        
        if(tipoReunionInstance)
        {
            flash.message = "Este tipo de reunión ya existe."
            redirect(action: "crear")
            return
        }
        
        if(!tipoReunionInstance)
        { 
            saveOriginal()
            
        }
        
        
    }

    def show() {
        def tipoReunionInstance = TipoReunion.get(params.id)
        if (!tipoReunionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'tipoReunion.label', default: 'TipoReunion'), params.id])
            redirect(action: "list")
            return
        }

        [tipoReunionInstance: tipoReunionInstance]
    }
    
    
    
    def edit() {
        def tipoReunionInstance = TipoReunion.get(params.id)
        if (!tipoReunionInstance) {
            flash.message = "No se pudo editar."
            redirect(action: "crear")
            return
        }

        [tipoReunionInstance: tipoReunionInstance]
    }

    def delete() {
        def tipoReunionInstance = TipoReunion.get(params.id)
        if (!tipoReunionInstance) {
            flash.message = "No se encontró el tipo de reunión."
            redirect(action: "crear")
            return
        }

      
            
        def pruebaInstancia = Minuta.findAllByTipoReunion(tipoReunionInstance)
        if(!pruebaInstancia)
        {
            tipoReunionInstance.delete(flush: true)
            flash.message = "El tipo de reunión se eliminó correctamente."
            redirect(action: "crear")
            return
        }
        else
        {
            flash.message = "No se puede eliminar el tipo de reunión por que pertenece a una minuta."
            redirect(action: "crear")
            return   
        }
        
    }
  
}

