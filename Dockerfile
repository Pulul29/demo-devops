# Imagen que ejecuta el servicio demo-devops Sprin Boot
#
# Descripción: Esta imagen proporciona un entorno de ejecución para el servicio demo-devops desarrollado en SpringBoot.
# Autor: Paúl Aluisa <psaluisa@outlook.com>
# Versión: 1.0
# Fecha de creación: 27 de abril de 2023
#
# Uso:
# docker build -t demo-devops .
# docker run -d -p 9000:9000 demo-devops
#

# Utiliza imagen oficual openjdk con jdk17 basada en Alpine
FROM openjdk:17-jdk-alpine

# Agregar Etiquetas informativas de la imagen
LABEL maintainer="Paúl Aluisa <psaluisa@outlook.com>"
LABEL description="Imagen que ejecuta el servicio demo-devops Sprin Boot"

# Actualizar Paquetes
RUN apk update

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
# reconozca el puerto asignado como argumento 9000.
ENV PORT=9000

# Define los puertos que se expondrán 9000
EXPOSE 9000

# Se establece un HealthCheck del contenedor levantado con la imagen
HEALTHCHECK --interval=30s --timeout=60s --retries=3 \
	CMD wget --no-verbose --tries=1 \
	--spider http://localhost:9000/api/users/health \
	|| exit 1

# Define el comando por defecto para ejecutar cuando se inicie el contenedor
CMD ["java","-jar","demo-0.0.1.jar"]