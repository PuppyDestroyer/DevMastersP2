# Usa una imagen base oficial de Go para compilar la aplicación (Etapa Builder)
FROM golang:1.21 AS builder

# Habilita la compilación estática
ENV CGO_ENABLED=0

# Establece el directorio de trabajo dentro del contenedor temporal
WORKDIR /app

# Copia los archivos de código fuente y la carpeta de la imagen
COPY main.go .
COPY Imagen/ ./Imagen/

# Compila la aplicación Go
RUN go build -o /app/webserver ./main.go

# Usa una imagen base mínima para la ejecución final
FROM alpine

# Establece el directorio de trabajo
WORKDIR /

# Copia el binario compilado y la carpeta de imagen
COPY --from=builder /app/webserver /webserver
COPY --from=builder /app/Imagen/ /Imagen/

# El contenedor escuchará en el puerto 80
EXPOSE 80

# Define el comando que se ejecutará al iniciar el contenedor
CMD ["/webserver"]
