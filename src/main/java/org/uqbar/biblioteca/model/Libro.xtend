package org.uqbar.biblioteca.model

import org.apache.commons.lang.StringUtils
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Libro {
	int id
	String titulo
	
	new() {
		this.id = 0
		this.titulo = ""
	}
	
	new(int id, String titulo) {
		this.id = id
		this.titulo = titulo
	}
	
	def estaCompleto() {
		StringUtils.isNotBlank(titulo) 
	}
	
}