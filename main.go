package main

import (
	"fmt"
	"net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/html; charset=utf-8")

	// HTML a servir: Muestra el mensaje y una imagen
	htmlContent := `
		<!DOCTYPE html>
		<html>
		<head>
			<title>Mi Aplicación Go</title>
		</head>
		<body>
			<h1>Soy alumno de la UOC</h1>
			<img src="/Imagen/img_producto1.jpg" alt="Logo Go" style="width:800px;">
		</body>
		</html>
	`
	fmt.Fprintf(w, htmlContent)
}
func main() {
	// 1. Define el manejador para la página principal
	http.HandleFunc("/", handler)

	fileServer := http.FileServer(http.Dir("./Imagen"))
	http.Handle("/Imagen/", http.StripPrefix("/Imagen/", fileServer))

	fmt.Println("Servidor iniciado en http://localhost:8080") // Iniciar el servidor en el puerto 8080

	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Printf("Error al iniciar el servidor: %s\n", err)
	}
}
