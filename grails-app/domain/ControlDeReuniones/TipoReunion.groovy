package ControlDeReuniones

class TipoReunion {

    String nombre
    String descripcion
    String estado

    static hasMany = [minuta:Minuta]

    static constraints = {
        nombre blank: false
        estado inList: ["Activo","Inactivo"]
    }
    
    String toString(){
        return nombre        
    }
}
