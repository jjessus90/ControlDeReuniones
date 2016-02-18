package ControlDeReuniones

class Acuerdo {

    String descripcionAcuerdo
    Date fechaCompromiso
    String estado
    String seguimiento

    Minuta minuta

    static hasMany = [usuario:Usuario, corresponsable:Usuario]

    static constraints = {
        estado inList: ["Pendiente", "Parcial", "Realizado", "Delegado", "Cancelado"]
        
    }
    
    String toString(){
        return descripcionAcuerdo
    }
    
}
