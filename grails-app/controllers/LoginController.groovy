import grails.converters.JSON

import javax.servlet.http.HttpServletResponse

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.core.context.SecurityContextHolder as SCH
import org.springframework.security.web.WebAttributes
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter


class LoginController {

	/**
	 * Dependency injection for the authenticationTrustResolver.
	 */
	def authenticationTrustResolver

	/**
	 * Dependency injection for the springSecurityService.
	 */
	def springSecurityService

	/**
	 * Default action; redirects to 'defaultTargetUrl' if logged in, /login/auth otherwise.
	 */

        def index = {
            
		if (springSecurityService.isLoggedIn()) {

                    def principal = springSecurityService.principal
                    /*println ":: DATOS DE SESIÓN ::"
                    println "Usuario: " + principal.username
                    println "Rol: " + principal.authorities
                    println "IdUsuario : " + springSecurityService.getCurrentUser ()
                    println "Rol: " + principal.authorities*/
                    //usuario = Usuario.get(principal.id)

                    String role = principal.authorities
                    if (role.equals("[ROLE_Administrador]")){
                        //println "Entro a sesion de administrador"
                        redirect(controller:"login", action:"inicioAdministrador")//Se creo el def inicio
                    }else if (role.equals("[ROLE_Responsable]")){
                        //println "Entro al else"
                        redirect(controller:"login", action:"inicioResponsable")//Se creo el def inicio
                    }else if (role.equals("[ROLE_Participante]")){
                        //println "Entro al else"
                        //redirect(controller:"login", action:"inicioResponsable")//Se creo el def inicio
                        redirect(controller:"login", action:"deniedp")
                    }else if (role.equals("[ROLE_NO_ROLES]")){
                        //println "Entro al else"
                        render(view:"../index")
                    }
                    /*redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl*/
		}
		else {
			redirect action: 'auth', params: params
		}
	}

        /**
         *  Muestra el menú correspondiente al administrador de la aplicación
         */

        def inicioAdministrador = {
            render(view:"../menuAdministrador")
        }

        /**
         *  Muestra el menú correspondiente a los responsables de minutas
         */

        def inicioResponsable = {
            render(view:"../menuResponsable")
        }
        
    def deniedp={
     if (springSecurityService.isLoggedIn() &&
				authenticationTrustResolver.isRememberMe(SCH.context?.authentication)) {
			// have cookie but the page is guarded with IS_AUTHENTICATED_FULLY
			redirect action: 'full', params: params
		}
    }

	/**
	 * Show the login page.
	 */
	def auth = {

		def config = SpringSecurityUtils.securityConfig

		if (springSecurityService.isLoggedIn()) {
			redirect uri: config.successHandler.defaultTargetUrl
			return
		}

		String view = 'auth'
		String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
		render view: view, model: [postUrl: postUrl,
		                           rememberMeParameter: config.rememberMe.parameter]
	}

	/**
	 * The redirect action for Ajax requests.
	 */
	def authAjax = {
		response.setHeader 'Location', SpringSecurityUtils.securityConfig.auth.ajaxLoginFormUrl
		response.sendError HttpServletResponse.SC_UNAUTHORIZED
	}

	/**
	 * Show denied page.
	 */
	def denied = {
		if (springSecurityService.isLoggedIn() &&
				authenticationTrustResolver.isRememberMe(SCH.context?.authentication)) {
			// have cookie but the page is guarded with IS_AUTHENTICATED_FULLY
			redirect action: 'full', params: params
		}
	}

	/**
	 * Login page for users with a remember-me cookie but accessing a IS_AUTHENTICATED_FULLY page.
	 */
	def full = {
		def config = SpringSecurityUtils.securityConfig
		render view: 'auth', params: params,
			model: [hasCookie: authenticationTrustResolver.isRememberMe(SCH.context?.authentication),
			        postUrl: "${request.contextPath}${config.apf.filterProcessesUrl}"]
	}

	/**
	 * Callback after a failed login. Redirects to the auth page with a warning message.
	 */
	def authfail = {

		def username = session[UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY]
		String msg = ''
		def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
		if (exception) {
			if (exception instanceof AccountExpiredException) {
				msg = g.message(code: "springSecurity.errors.login.expired")
			}
			else if (exception instanceof CredentialsExpiredException) {
				msg = g.message(code: "springSecurity.errors.login.passwordExpired")
			}
			else if (exception instanceof DisabledException) {
				msg = g.message(code: "springSecurity.errors.login.disabled")
			}
			else if (exception instanceof LockedException) {
				msg = g.message(code: "springSecurity.errors.login.locked")
			}
			else {
				msg = "Usuario o Contraseña incorrectos, inténtalo de nuevo."
			}
		}

		if (springSecurityService.isAjax(request)) {
			render([error: msg] as JSON)
		}
		else {
			flash.message = msg
			redirect action: 'auth', params: params
		}
	}

	/**
	 * The Ajax success redirect url.
	 */
	def ajaxSuccess = {
		render([success: true, username: springSecurityService.authentication.name] as JSON)
	}

	/**
	 * The Ajax denied redirect url.
	 */
	def ajaxDenied = {
		render([error: 'access denied'] as JSON)
	}
}
