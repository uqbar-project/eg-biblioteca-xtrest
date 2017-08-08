package org.uqbar.biblioteca.app

import org.uqbar.biblioteca.model.Biblioteca
import org.uqbar.biblioteca.rest.BibliotecaRestAPI
import org.uqbar.xtrest.api.XTRest

class BibliotecaApp {
	
	def static void main(String[] args) {
		val biblioteca = new Biblioteca => [
			addLibro(5, "Ficciones")
			addLibro(7, "El Aleph")
			addLibro(11, "Historia universal de la infamia")
			addLibro(13, "El informe de Brodie")
			addLibro(17, "El libro de arena")
		]

        XTRest.startInstance(9000, new BibliotecaRestAPI(biblioteca))
    }
	
}