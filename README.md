# RESTful Web Services Demo en XTrest

Demostración de uso de [xtrest](https://github.com/uqbar-project/xtrest) sobre cómo declarar y probar una API REST con operaciones CRUD y búsqueda.


## Implementación 

| package | descripción |
| --- | --- |
| `org.uqbar.biblioteca.model`      | Modelo de dominio (Biblioteca y Libro) |
| `org.uqbar.biblioteca.controller` | Definición Xtrest de la API REST (detalles [más abajo](#api-rest-en-ejemplos)) |
| `org.uqbar.biblioteca.app`        | El `main` que levanta un servidor HTTP y inicializa el modelo con libros de prueba |


## API REST en ejemplos

| operación     | request                   | response        | descripción | 
| --- | --- | --- | --- |
| buscar libros | `GET /libros?string=Ficc` | 200 OK          | Lista de libros que contengan `ficc` (ignorando mayúsculas/minúsculas) |
| | | | |
| obtener libro | `GET /libros/7`           | 200 OK          | Un libro con el id indicado (`7`) |
|               | `GET /libros/88888`       | 404 Not Found   | No hay libro con el id indicado (`88888`) |
|               | `GET /libros/Ficc`        | 400 Bad Request | Id mal formado (`Ficc` no es un entero) |
| | | | |
| crear libro   | `POST /libros` (BODY bien)| 200 OK          | El libro recibido en el BODY (formato JSON) ahora pertenece a la biblioteca |
|               | `POST /libros` (BODY mal) | 400 Bad Request | No pudo leerse al BODY como instancia de `org.uqbar.biblioteca.model.Libro` |
| | | | |
| borrar libro  | `DELETE /libros/7`        | 200 OK          | Borra el libro con id `7` |
|               | `DELETE /libros/88888`    | 200 OK          | No hay libro con id `88888` pero es tolerado silenciosamente |
|               | `DELETE /libros/Ficc`     | 400 Bad Request | Id mal formado (`Ficc` no es un entero) |

**Atención**: La implementación usa formato JSON en el BODY, tanto en los request como en response.


## Modo de uso simple

1. Clonar este repositorio.
2. Importar a Eclipse como **Maven project**.
3. Ejecutar `org.uqbar.biblioteca.app.BibliotecaApp`, que levanta servidor en el puerto 9000.
4. Probar la API REST
   * en el navegador: <http://localhost:9000/libros>;
   * en [Postman](https://www.getpostman.com/), importar [este archivo](Biblioteca.postman_collection.json) que provee varios ejemplos de request listos para usar.
