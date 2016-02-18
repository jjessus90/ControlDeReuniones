package ControlDeReuniones



import org.junit.*
import grails.test.mixin.*

@TestFor(PuntoTratarController)
@Mock(PuntoTratar)
class PuntoTratarControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/puntoTratar/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.puntoTratarInstanceList.size() == 0
        assert model.puntoTratarInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.puntoTratarInstance != null
    }

    void testSave() {
        controller.save()

        assert model.puntoTratarInstance != null
        assert view == '/puntoTratar/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/puntoTratar/show/1'
        assert controller.flash.message != null
        assert PuntoTratar.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/puntoTratar/list'


        populateValidParams(params)
        def puntoTratar = new PuntoTratar(params)

        assert puntoTratar.save() != null

        params.id = puntoTratar.id

        def model = controller.show()

        assert model.puntoTratarInstance == puntoTratar
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/puntoTratar/list'


        populateValidParams(params)
        def puntoTratar = new PuntoTratar(params)

        assert puntoTratar.save() != null

        params.id = puntoTratar.id

        def model = controller.edit()

        assert model.puntoTratarInstance == puntoTratar
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/puntoTratar/list'

        response.reset()


        populateValidParams(params)
        def puntoTratar = new PuntoTratar(params)

        assert puntoTratar.save() != null

        // test invalid parameters in update
        params.id = puntoTratar.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/puntoTratar/edit"
        assert model.puntoTratarInstance != null

        puntoTratar.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/puntoTratar/show/$puntoTratar.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        puntoTratar.clearErrors()

        populateValidParams(params)
        params.id = puntoTratar.id
        params.version = -1
        controller.update()

        assert view == "/puntoTratar/edit"
        assert model.puntoTratarInstance != null
        assert model.puntoTratarInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/puntoTratar/list'

        response.reset()

        populateValidParams(params)
        def puntoTratar = new PuntoTratar(params)

        assert puntoTratar.save() != null
        assert PuntoTratar.count() == 1

        params.id = puntoTratar.id

        controller.delete()

        assert PuntoTratar.count() == 0
        assert PuntoTratar.get(puntoTratar.id) == null
        assert response.redirectedUrl == '/puntoTratar/list'
    }
}
