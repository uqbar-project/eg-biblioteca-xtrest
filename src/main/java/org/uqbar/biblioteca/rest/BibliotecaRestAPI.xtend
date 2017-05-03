package org.uqbar.biblioteca.rest

import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import org.uqbar.biblioteca.model.Biblioteca
import org.uqbar.biblioteca.model.Libro
import org.uqbar.commons.model.UserException
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.http.ContentType
import org.uqbar.xtrest.json.JSONUtils

/**
 * API Rest de la Biblioteca, implementada con XtRest.
 */
@Controller
class BibliotecaRestAPI {
    extension JSONUtils = new JSONUtils

	Biblioteca biblioteca

    new(Biblioteca biblioteca) {
        this.biblioteca = biblioteca
    }

    /**
     * Permite buscar libros que contengan cierto string en su título, u obtener todos los libros.
     *  
     * Atiende requests de la forma GET /libros y GET /libros?string=xxx.
     */
    @Get("/libros")
    def getLibros(String string) {
        response.contentType = ContentType.APPLICATION_JSON
       	ok(this.biblioteca.searchLibros(string).toJson)
    }

    /**
     * Permite obtener un libro por su id.
     * 
     * Atiende requests de la forma GET /libros/17.
     */
    @Get("/libros/:id")
    def getLibroById() {
        response.contentType = ContentType.APPLICATION_JSON
        try {        	
            var libro = this.biblioteca.getLibro(Integer.valueOf(id))
            if (libro == null) {
            	notFound(getErrorJson("No existe libro con ese id"))
            } else {
            	ok(libro.toJson)
            }
        }
        catch (NumberFormatException ex) {
        	badRequest(getErrorJson("El id debe ser un numero entero"))
        }
    }

    /**
     * Permite eliminar un libro por su id.
     * 
     * Atiende requests de la forma DELETE /libros/7.
     */
    @Delete('/libros/:id')
    def deleteLibroById() {
        response.contentType = ContentType.APPLICATION_JSON
        try {
            this.biblioteca.eliminarLibro(Integer.valueOf(id))
            ok()
        }
        catch (NumberFormatException ex) {
        	badRequest(getErrorJson("El id debe ser un numero entero"))
        }
    }

    /**
     * Permite crear o modificar un libro.
     * 
     * Atiende requests de la forma POST /libros con un libro en el body (en formato JSON).
     */
    @Post("/libros")
    def createLibro(@Body String body) {
        response.contentType = ContentType.APPLICATION_JSON
        try {
	        val Libro libro = body.fromJson(Libro)
	        try {
				this.biblioteca.setLibro(libro)
				ok()	        	
	        } 
	        catch (UserException exception) {
	        	badRequest(getErrorJson(exception.message))
	        }
        } 
        catch (UnrecognizedPropertyException exception) {
        	badRequest(getErrorJson("El body debe ser un Libro"))
        }
    }


    private def getErrorJson(String message) {
        '{ "error": "' + message + '" }'
    }

}