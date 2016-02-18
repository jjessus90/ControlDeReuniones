package ControlDeReuniones

class Minuta {

    String identificador
    String lugar
    String objetivo
    Date fechaInicio
    String horaInicio
    Date fechaFin
    String horaFin
    String estadoMinuta
    String upload
    
    TipoReunion tipoReunion

    static hasMany =[usuario:Usuario, puntoTratar:PuntoTratar, acuerdo:Acuerdo]
    Usuario responsable

    static constraints = {
        identificador blank: false, unique: true
        fechaInicio nullable: true
        fechaFin nullable: true
        upload nullable:true
    }
    String toString(){
        return identificador
        
    }
}
