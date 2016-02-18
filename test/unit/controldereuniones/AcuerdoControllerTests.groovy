package ControlDeReuniones



import org.junit.*
import grails.test.mixin.*

@TestFor(AcuerdoController)
@Mock(Acuerdo)
class AcuerdoControllerTests {


    def populateValidParams(params) {
      assert params != null
      // TODO: Populate valid properties like...
      //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/acuerdo/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.acuerdoInstanceList.size() == 0
        assert model.acuerdoInstanceTotal == 0
    }

    void testCreate() {
       def model = controller.create()

       assert model.acuerdoInstance != null
    }

    void testSave() {
        controller.save()

        assert model.acuerdoInstance != null
        assert view == '/acuerdo/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/acuerdo/show/1'
        assert controller.flash.message != null
        assert Acuerdo.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/acuerdo/list'


        populateValidParams(params)
        def acuerdo = new Acuerdo(params)

        assert acuerdo.save() != null

        params.id = acuerdo.id

        def model = controller.show()

        assert model.acuerdoInstance == acuerdo
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/acuerdo/list'


        populateValidParams(params)
        def acuerdo = new Acuerdo(params)

        assert acuerdo.save() != null

        params.id = acuerdo.id

        def model = controller.edit()

        assert model.acuerdoInstance == acuerdo
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/acuerdo/list'

        response.reset()


        populateValidParams(params)
        def acuerdo = new Acuerdo(params)

        assert acuerdo.save() != null

        // test invalid parameters in update
        params.id = acuerdo.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/acuerdo/edit"
        assert model.acuerdoInstance != null

        acuerdo.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/acuerdo/show/$acuerdo.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        acuerdo.clearErrors()

        populateValidParams(params)
        params.id = acuerdo.id
        params.version = -1
        controller.update()

        assert view == "/acuerdo/edit"
        assert model.acuerdoInstance != null
        assert model.acuerdoInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/acuerdo/list'

        response.reset()

        populateValidParams(params)
        def acuerdo = new Acuerdo(params)

        assert acuerdo.save() != null
        assert Acuerdo.count() == 1

        params.id = acuerdo.id

        controller.delete()

        assert Acuerdo.count() == 0
        assert Acuerdo.get(acuerdo.id) == null
        assert response.redirectedUrl == '/acuerdo/list'
    }
}
