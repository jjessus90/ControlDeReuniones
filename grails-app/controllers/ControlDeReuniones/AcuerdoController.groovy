package ControlDeReuniones

import org.springframework.dao.DataIntegrityViolationException

class AcuerdoController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [acuerdoInstanceList: Acuerdo.list(params), acuerdoInstanceTotal: Acuerdo.count()]
    }

    def create() {
        [acuerdoInstance: new Acuerdo(params)]
    }

    def save() {
        def acuerdoInstance = new Acuerdo(params)
        if (!acuerdoInstance.save(flush: true)) {
            render(view: "create", model: [acuerdoInstance: acuerdoInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'acuerdo.label', default: 'Acuerdo'), acuerdoInstance.id])
        redirect(action: "show", id: acuerdoInstance.id)
    }

    def show() {
        def acuerdoInstance = Acuerdo.get(params.id)
        if (!acuerdoInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'acuerdo.label', default: 'Acuerdo'), params.id])
            redirect(action: "list")
            return
        }

        [acuerdoInstance: acuerdoInstance]
    }

    def edit() {
        def acuerdoInstance = Acuerdo.get(params.id)
        if (!acuerdoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'acuerdo.label', default: 'Acuerdo'), params.id])
            redirect(action: "list")
            return
        }

        [acuerdoInstance: acuerdoInstance]
    }

    def update() {
        def acuerdoInstance = Acuerdo.get(params.id)
        if (!acuerdoInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'acuerdo.label', default: 'Acuerdo'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (acuerdoInstance.version > version) {
                acuerdoInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'acuerdo.label', default: 'Acuerdo')] as Object[],
                          "Another user has updated this Acuerdo while you were editing")
                render(view: "edit", model: [acuerdoInstance: acuerdoInstance])
                return
            }
        }

        acuerdoInstance.properties = params

        if (!acuerdoInstance.save(flush: true)) {
            render(view: "edit", model: [acuerdoInstance: acuerdoInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'acuerdo.label', default: 'Acuerdo'), acuerdoInstance.id])
        redirect(action: "show", id: acuerdoInstance.id)
    }

    def delete() {
        def acuerdoInstance = Acuerdo.get(params.id)
        if (!acuerdoInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'acuerdo.label', default: 'Acuerdo'), params.id])
            redirect(action: "list")
            return
        }

        try {
            acuerdoInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'acuerdo.label', default: 'Acuerdo'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'acuerdo.label', default: 'Acuerdo'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
