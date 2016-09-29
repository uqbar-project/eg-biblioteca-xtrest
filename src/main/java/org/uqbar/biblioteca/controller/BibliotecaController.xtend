package org.uqbar.biblioteca.controller

import org.uqbar.biblioteca.model.Biblioteca
import org.uqbar.biblioteca.model.Libro
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils

@Controller
class BibliotecaController {
    extension JSONUtils = new JSONUtils
	Biblioteca biblioteca
	
	new(Biblioteca biblioteca) {
		this.biblioteca = biblioteca
	}
	
    @Get("/libros")
    def getLibros() {
        response.contentType = "application/json"
        ok(this.biblioteca.getLibros.toJson)
    }

    @Get("/libros/:id")
    def getLibroById() {
        response.contentType = "application/json"
        try {        	
            var libro = this.biblioteca.getLibro(Integer.valueOf(id))
            if (libro == null) {
            	notFound('{ "error": "No existe libro con ese id" }')
            } else {
            	ok(libro.toJson)
            }
        }
        catch (NumberFormatException ex) {
        	badRequest('{ "error": "El id debe ser un numero entero" }')
        }
    }

    @Delete('/libros/:id')
    def deleteLibroById() {
        response.contentType = "application/json"
        try {
            this.biblioteca.eliminarLibro(Integer.valueOf(id))
            ok()
        }
        catch (NumberFormatException ex) {
        	badRequest('{ "error": "El id debe ser un numero entero" }')
        }
    }

    @Post("/libros")
    def createLibro(@Body String body) {
        response.contentType = "application/json"
        var Libro libro = body.fromJson(typeof(Libro))
        this.biblioteca.setLibro(libro)
    	ok()
    }

}