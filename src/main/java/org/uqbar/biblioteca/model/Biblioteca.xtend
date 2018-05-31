package org.uqbar.biblioteca.model

import java.util.ArrayList
import java.util.List
import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Biblioteca {
	
	val List<Libro> libros = new ArrayList
	
	/**
	 * Helper method para agregar un libro
	 */	
	def addLibro(int idLibro, String titulo) {
		this.setLibro(new Libro(idLibro, titulo))
	}
	
	def setLibro(Libro libro) {
		libro.validar()
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
