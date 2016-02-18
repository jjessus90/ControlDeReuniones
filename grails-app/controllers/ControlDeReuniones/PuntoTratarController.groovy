package ControlDeReuniones

import org.springframework.dao.DataIntegrityViolationException

class PuntoTratarController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [puntoTratarInstanceList: PuntoTratar.list(params), puntoTratarInstanceTotal: PuntoTratar.count()]
    }

    def create() {
        [puntoTratarInstance: new PuntoTratar(params)]
    }

    def save() {
        def puntoTratarInstance = new PuntoTratar(params)
        if (!puntoTratarInstance.save(flush: true)) {
            render(view: "create", model: [puntoTratarInstance: puntoTratarInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'puntoTratar.label', default: 'PuntoTratar'), puntoTratarInstance.id])
        redirect(action: "show", id: puntoTratarInstance.id)
    }

    def show() {
        def puntoTratarInstance = PuntoTratar.get(params.id)
        if (!puntoTratarInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'puntoTratar.label', default: 'PuntoTratar'), params.id])
            redirect(action: "list")
            return
        }

        [puntoTratarInstance: puntoTratarInstance]
    }

    def edit() {
        def puntoTratarInstance = PuntoTratar.get(params.id)
        if (!puntoTratarInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'puntoTratar.label', default: 'PuntoTratar'), params.id])
            redirect(action: "list")
            return
        }

        [puntoTratarInstance: puntoTratarInstance]
    }

    def update() {
        def puntoTratarInstance = PuntoTratar.get(params.id)
        if (!puntoTratarInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'puntoTratar.label', default: 'PuntoTratar'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (puntoTratarInstance.version > version) {
                puntoTratarInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'puntoTratar.label', default: 'PuntoTratar')] as Object[],
                          "Another user has updated this PuntoTratar while you were editing")
                render(view: "edit", model: [puntoTratarInstance: puntoTratarInstance])
                return
            }
        }

        puntoTratarInstance.properties = params

        if (!puntoTratarInstance.save(flush: true)) {
            render(view: "edit", model: [puntoTratarInstance: puntoTratarInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'puntoTratar.label', default: 'PuntoTratar'), puntoTratarInstance.id])
        redirect(action: "show", id: puntoTratarInstance.id)
    }

    def delete() {
        def puntoTratarInstance = PuntoTratar.get(params.id)
        if (!puntoTratarInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'puntoTratar.label', default: 'PuntoTratar'), params.id])
            redirect(action: "list")
            return
        }

        try {
            puntoTratarInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'puntoTratar.label', default: 'PuntoTratar'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'puntoTratar.label', default: 'PuntoTratar'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
