package org.uqbar.biblioteca.app

import org.uqbar.biblioteca.model.Biblioteca
import org.uqbar.biblioteca.model.Libro
import org.uqbar.biblioteca.rest.BibliotecaRestAPI
import org.uqbar.xtrest.api.XTRest

class BibliotecaApp {
	
	def static void main(String[] args) {
		var biblioteca = new Biblioteca
		biblioteca.setLibro(new Libro(5, "Ficciones"))
		biblioteca.setLibro(new Libro(7, "El Aleph"))
		biblioteca.setLibro(new Libro(11, "Historia universal de la infamia"))
		biblioteca.setLibro(new Libro(13, "El informe de Brodie"))
		biblioteca.setLibro(new Libro(17, "El libro de arena"))

        XTRest.startInstance(new BibliotecaRestAPI(biblioteca), 9000)
    }
	
}