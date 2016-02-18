package ControlDeReuniones

class Usuario {

	transient springSecurityService

	String username
	String password
        String correoElectronico
        String nombre
        String organizacion
        String puesto
        String tipo
	boolean enabled
        boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

        static hasMany =[minuta:Minuta, acuerdo:Acuerdo]
        static belongsTo = [Minuta, Acuerdo]

	static constraints = {
		username blank: false, unique: true
		password blank: false
                correoElectronico blank: false, email:true
                nombre blank: false, matches: "[A-Z a-z´áéíóúñÁÉÍÓÚ]+"
                organizacion blank: false
                puesto blank: false

	}

	static mapping = {
		password column: '`password`'
	}

	Set<Rol> getAuthorities() {
		UsuarioRol.findAllByUsuario(this).collect { it.rol } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
        
        String toString(){
        return nombre
    }
}
