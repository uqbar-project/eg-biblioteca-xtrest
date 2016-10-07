package org.uqbar.biblioteca.model

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Biblioteca {
	
	var ArrayList<Libro> libros = new ArrayList
		
	def setLibro(Libro libro) {
		libros.add(libro)
	}
	
	def getLibro(int id) {
		libros.findFirst[ it.id == id ]
	}

	def eliminarLibro(Integer id) {
		libros.remove(this.getLibro(id))
	}
		
	def searchLibros(String substring) {
		if (substring == null) {
			this.libros
		} else {
			this.libros.filter[ it.titulo.toLowerCase.contains(substring.toLowerCase) ].toList			
		}
	}
	
}
