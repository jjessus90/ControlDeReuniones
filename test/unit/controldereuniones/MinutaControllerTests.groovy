package ControlDeReuniones



import org.junit.*
import grails.test.mixin.*

@TestFor(MinutaController)
@Mock(Minuta)
class MinutaControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/minuta/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.minutaInstanceList.size() == 0
        assert model.minutaInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.minutaInstance != null
    }

    void testSave() {
        controller.save()

        assert model.minutaInstance != null
        assert view == '/minuta/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/minuta/show/1'
        assert controller.flash.message != null
        assert Minuta.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/minuta/list'


        populateValidParams(params)
        def minuta = new Minuta(params)

        assert minuta.save() != null

        params.id = minuta.id

        def model = controller.show()

        assert model.minutaInstance == minuta
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/minuta/list'


        populateValidParams(params)
        def minuta = new Minuta(params)

        assert minuta.save() != null

        params.id = minuta.id

        def model = controller.edit()

        assert model.minutaInstance == minuta
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/minuta/list'

        response.reset()


        populateValidParams(params)
        def minuta = new Minuta(params)

        assert minuta.save() != null

        // test invalid parameters in update
        params.id = minuta.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/minuta/edit"
        assert model.minutaInstance != null

        minuta.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/minuta/show/$minuta.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        minuta.clearErrors()

        populateValidParams(params)
        params.id = minuta.id
        params.version = -1
        controller.update()

        assert view == "/minuta/edit"
        assert model.minutaInstance != null
        assert model.minutaInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/minuta/list'

        response.reset()

        populateValidParams(params)
        def minuta = new Minuta(params)

        assert minuta.save() != null
        assert Minuta.count() == 1

        params.id = minuta.id

        controller.delete()

        assert Minuta.count() == 0
        assert Minuta.get(minuta.id) == null
        assert response.redirectedUrl == '/minuta/list'
    }
}
