# Utiliza imagen oficual openjdk con jdk17 basada en Alpine
FROM openjdk:17-jdk-alpine

# Se crea el argumento puerto. 
# Para recibir como entrada el valor del puerto.
ARG port

# Actualizar Paquetes
RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash

# Se crea un nuevo grupo y usuario para la ejecución del contenedor
RUN addgroup -S execution && \
    adduser -S paluisa -G execution

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos necesarios al contenedor
COPY target/demo-0.0.1.jar demo-0.0.1.jar

# Modifica el dueño de la carpeta de trabajo al nuevo usuario 
RUN chown -R paluisa ../app

# Se estable el nuevo usuario para la ejecución del contenedor
USER paluisa

# Se asigna la variable de entorno PORT para que la aplicación
# reconozca el puerto asignado como argumento.
ENV PORT=${port}

# Define los puertos que se expondrán
EXPOSE ${port}

# Se establece un HealthCheck del contenedor levantado con la imagen
HEALTHCHECK --interval=30s --timeout=60s --retries=3 \
	CMD wget --no-verbose --tries=1 \
	--spider http://localhost:${PORT}/api/users/health \
	|| exit 1

# Define el comando por defecto para ejecutar cuando se inicie el contenedor
CMD ["java","-jar","demo-0.0.1.jar"]