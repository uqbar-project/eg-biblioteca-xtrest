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
	
}
