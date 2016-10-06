package org.uqbar.biblioteca.model

import java.util.HashMap

class Biblioteca {
	
	var libroById = new HashMap<Integer, Libro>
		
	def setLibro(Libro libro) {
		libroById.put(libro.id, libro)
	}
	
	def getLibro(Integer id) {
		libroById.get(id)
	}

	def eliminarLibro(Integer id) {
		libroById.remove(id)
	}
		
	def getLibros() {
		libroById.values
	}
	
	def searchLibros(String substring) {
		if (substring == null) {
			this.libros
		} else {
			this.libros.filter[ it.titulo.toLowerCase.contains(substring.toLowerCase) ].toList			
		}
	}
	
}
