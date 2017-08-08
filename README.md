# RESTful Web Services Demo en XTrest

[![Build Status](https://travis-ci.org/uqbar-project/eg-biblioteca-xtrest.svg?branch=master)](https://travis-ci.org/uqbar-project/eg-biblioteca-xtrest)

Demostración de uso de [xtrest](https://github.com/uqbar-project/xtrest) sobre cómo declarar y probar una API REST con operaciones CRUD y búsqueda.


## Implementación 

| package | descripción |
| --- | --- |
| `org.uqbar.biblioteca.model`      | Modelo de dominio (Biblioteca y Libro) |
| `org.uqbar.biblioteca.rest`       | Definición Xtrest de la API REST (detalles [más abajo](#api-rest-en-ejemplos)) |
| `org.uqbar.biblioteca.app`        | El `main` que levanta un servidor HTTP y inicializa un modelo con libros de prueba |


## API REST en ejemplos

| operation                 | request                   | response status | response description | 
| --- | --- | --- | --- |
| obtener todos los libros  | `GET /libros`             | 200 OK          | Lista de todos los libros |
| | | | |
| obtener un libro por id   | `GET /libros/7`           | 200 OK          | Un libro con el id indicado (`7`) |
|                           | `GET /libros/88888`       | 404 Not Found   | No hay libro con el id indicado (`88888`) |
|                           | `GET /libros/Ficc`        | 400 Bad Request | Id mal formado (`Ficc` no es un entero) |
| | | | |
| buscar libros por título  | `GET /libros?string=Ficc` | 200 OK          | Lista de libros que contengan `ficc` (ignorando mayúsculas/minúsculas) |
| | | | |
| crear/modificar libro     | `POST /libros` (BODY bien)| 200 OK          | El libro recibido en el BODY (formato JSON) ahora pertenece a la biblioteca |
|                           | `POST /libros` (BODY mal) | 400 Bad Request | No pudo leerse al BODY como instancia de `org.uqbar.biblioteca.model.Libro` |
| | | | |
| borrar libro              | `DELETE /libros/7`        | 200 OK          | Borra el libro con id `7` |
|                           | `DELETE /libros/88888`    | 200 OK          | No hay libro con id `88888` pero es tolerado silenciosamente |
|                           | `DELETE /libros/Ficc`     | 400 Bad Request | Id mal formado (`Ficc` no es un entero) |

**Atención**: La implementación usa formato JSON en el BODY, tanto en request como en response.


## Modo de uso

### Cómo levantar

#### Opción A: Desde Eclipse

1. Importar este proyecto en Eclipse como **Maven project**.
2. Ejecutar `org.uqbar.biblioteca.app.BibliotecaApp`, que levanta servidor en el puerto 9000.

#### Opción B: Desde línea de comandos

1. Generar jar con dependencias: `mvn clean compile assembly:single`
2. Ejecutar el jar generador: `java -jar target/biblioteca-xtrest-0.0.1-SNAPSHOT-jar-with-dependencies.jar`

Esta opción requiere menos recursos de sistema porque no es necesario ejecutar Eclipse.

### Cómo probar

Probar los [ejemplos de API REST](#api-rest-en-ejemplos)
   * en el navegador: <http://localhost:9000/libros>;
   * en [Postman](https://www.getpostman.com/), importar [este archivo](Biblioteca.postman_collection.json) que provee varios ejemplos de request listos para usar.
