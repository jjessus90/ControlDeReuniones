package ControlDeReuniones



import org.junit.*
import grails.test.mixin.*

@TestFor(TipoReunionController)
@Mock(TipoReunion)
class TipoReunionControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/tipoReunion/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.tipoReunionInstanceList.size() == 0
        assert model.tipoReunionInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.tipoReunionInstance != null
    }

    void testSave() {
        controller.save()

        assert model.tipoReunionInstance != null
        assert view == '/tipoReunion/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/tipoReunion/show/1'
        assert controller.flash.message != null
        assert TipoReunion.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/tipoReunion/list'


        populateValidParams(params)
        def tipoReunion = new TipoReunion(params)

        assert tipoReunion.save() != null

        params.id = tipoReunion.id

        def model = controller.show()

        assert model.tipoReunionInstance == tipoReunion
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/tipoReunion/list'


        populateValidParams(params)
        def tipoReunion = new TipoReunion(params)

        assert tipoReunion.save() != null

        params.id = tipoReunion.id

        def model = controller.edit()

        assert model.tipoReunionInstance == tipoReunion
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/tipoReunion/list'

        response.reset()


        populateValidParams(params)
        def tipoReunion = new TipoReunion(params)

        assert tipoReunion.save() != null

        // test invalid parameters in update
        params.id = tipoReunion.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/tipoReunion/edit"
        assert model.tipoReunionInstance != null

        tipoReunion.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/tipoReunion/show/$tipoReunion.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        tipoReunion.clearErrors()

        populateValidParams(params)
        params.id = tipoReunion.id
        params.version = -1
        controller.update()

        assert view == "/tipoReunion/edit"
        assert model.tipoReunionInstance != null
        assert model.tipoReunionInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/tipoReunion/list'

        response.reset()

        populateValidParams(params)
        def tipoReunion = new TipoReunion(params)

        assert tipoReunion.save() != null
        assert TipoReunion.count() == 1

        params.id = tipoReunion.id

        controller.delete()

        assert TipoReunion.count() == 0
        assert TipoReunion.get(tipoReunion.id) == null
        assert response.redirectedUrl == '/tipoReunion/list'
    }
}
