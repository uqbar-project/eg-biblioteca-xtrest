package org.uqbar.biblioteca.rest

import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import org.uqbar.biblioteca.model.Biblioteca
import org.uqbar.biblioteca.model.Libro
import org.uqbar.commons.model.exceptions.UserException
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
        return ok(this.biblioteca.searchLibros(string).toJson)
    }

    /**
     * Permite obtener un libro por su id.
     * 
     * Atiende requests de la forma GET /libros/17.
     */
    @Get("/libros/:id")
    def getLibroById() {
        try {
            var libro = this.biblioteca.getLibro(Integer.valueOf(id))
            if (libro === null) {
                return notFound(getErrorJson("No existe libro con el identificador " + id))
            } else {
                return ok(libro.toJson)
            }
        } catch (NumberFormatException exception) {
            return badRequest(getErrorJson("El id debe ser un número entero"))
        }
    }

    /**
     * Permite eliminar un libro por su id.
     * 
     * Atiende requests de la forma DELETE /libros/7.
     */
    @Delete('/libros/:id')
    def deleteLibroById() {
        try {
            val eliminadoOk = this.biblioteca.eliminarLibro(Integer.valueOf(id))
            return if (eliminadoOk) ok() else badRequest(getErrorJson("No existe el libro con identificador " + id))
        } catch (NumberFormatException exception) {
            return badRequest(getErrorJson("El id debe ser un número entero"))
        }
    }

    /**
     * Permite crear o modificar un libro.
     * 
     * Atiende requests de la forma POST /libros con un libro en el body (en formato JSON).
     */
    @Post("/libros")
    def createLibro(@Body String body) {
        try {
            val Libro libro = body.fromJson(Libro)
            try {
                this.biblioteca.setLibro(libro)
                return ok()
            } catch (UserException exception) {
                return badRequest(getErrorJson(exception.message))
            }
        } catch (UnrecognizedPropertyException exception) {
            return badRequest(getErrorJson("El body debe ser un Libro"))
        }
    }

    private def getErrorJson(String message) {
        '{ "error": "' + message + '" }'
    }

}
