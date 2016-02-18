package ControlDeReuniones

import org.springframework.dao.DataIntegrityViolationException

class PermisoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [permisoInstanceList: Permiso.list(params), permisoInstanceTotal: Permiso.count()]
    }

    def create() {
        [permisoInstance: new Permiso(params)]
    }

    def save() {
        def permisoInstance = new Permiso(params)
        if (!permisoInstance.save(flush: true)) {
            render(view: "create", model: [permisoInstance: permisoInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'permiso.label', default: 'Permiso'), permisoInstance.id])
        redirect(action: "show", id: permisoInstance.id)
    }

    def show() {
        def permisoInstance = Permiso.get(params.id)
        if (!permisoInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'permiso.label', default: 'Permiso'), params.id])
            redirect(action: "list")
            return
        }

        [permisoInstance: permisoInstance]
    }

    def edit() {
        def permisoInstance = Permiso.get(params.id)
        if (!permisoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permiso.label', default: 'Permiso'), params.id])
            redirect(action: "list")
            return
        }

        [permisoInstance: permisoInstance]
    }

    def update() {
        def permisoInstance = Permiso.get(params.id)
        if (!permisoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'permiso.label', default: 'Permiso'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (permisoInstance.version > version) {
                permisoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'permiso.label', default: 'Permiso')] as Object[],
                          "Another user has updated this Permiso while you were editing")
                render(view: "edit", model: [permisoInstance: permisoInstance])
                return
            }
        }

        permisoInstance.properties = params

        if (!permisoInstance.save(flush: true)) {
            render(view: "edit", model: [permisoInstance: permisoInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'permiso.label', default: 'Permiso'), permisoInstance.id])
        redirect(action: "show", id: permisoInstance.id)
    }

    def delete() {
        def permisoInstance = Permiso.get(params.id)
        if (!permisoInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'permiso.label', default: 'Permiso'), params.id])
            redirect(action: "list")
            return
        }

        try {
            permisoInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'permiso.label', default: 'Permiso'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'permiso.label', default: 'Permiso'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
