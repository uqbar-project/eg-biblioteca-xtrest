package org.uqbar.biblioteca.model

import java.util.ArrayList
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.exceptions.UserException

@Accessors
class Biblioteca {
	
	var ArrayList<Libro> libros = new ArrayList
	
	/**
	 * Helper method para agregar un libro
	 */	
	def addLibro(int idLibro, String titulo) {
		this.setLibro(new Libro(idLibro, titulo))
	}
	
	def setLibro(Libro libro) {
		if (!libro.estaCompleto()) {
			throw new UserException("El libro debe estar completo");
		}
		eliminarLibro(libro.id) // Elimina un eventual duplicado con mismo id
		libros.add(libro)
	}
	
	def getLibro(int id) {
		libros.findFirst[ it.id == id ]
	}

	def eliminarLibro(Integer id) {
        libros.removeIf[ it.id == id ]
	}
		
	def searchLibros(String substring) {
		if (StringUtils.isBlank(substring)) {
			this.libros
		} else {
			this.libros.filter[ it.titulo.toLowerCase.contains(substring.toLowerCase) ].toList			
		}
	}
	
}
