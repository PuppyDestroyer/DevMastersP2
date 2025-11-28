# Usa una imagen base oficial de Go para compilar la aplicación (Etapa Builder)
FROM golang:1.21 AS builder

# Habilita la compilación estática para que el binario funcione en la base 'scratch'
ENV CGO_ENABLED=0

# Establece el directorio de trabajo dentro del contenedor temporal
WORKDIR /app

# Copia los archivos de código fuente y la carpeta de la imagen
COPY main.go .
COPY Imagen/ ./Imagen/ 

# Compila la aplicación Go con flags para generar un binario estático
RUN go build -o /app/webserver -a -tags netgo -ldflags '-extldflags "-static"' ./main.go


# Usa una imagen base más pequeña y segura para la ejecución final (scratch)
FROM scratch

# Establece el directorio de trabajo
WORKDIR /

# Copia el binario compilado y la carpeta de imagen
COPY --from=builder /app/webserver /webserver
COPY --from=builder /app/Imagen/ /Imagen/

# El contenedor escuchará en el puerto 8080
EXPOSE 8080

# *** ¡CRUCIAL! Define el comando que se ejecutará al iniciar el contenedor. ***
CMD ["/webserver"]