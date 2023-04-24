FROM openjdk:17-jdk-alpine
ARG port
RUN addgroup -S execution && adduser -S paluisa -G execution
COPY target/demo-0.0.1.jar /app/demo-0.0.1.jar
RUN chown -R paluisa /app
USER paluisa
ENV PORT=${port}
EXPOSE ${port}
HEALTHCHECK --interval=30s --timeout=60s --retries=3 \
	CMD wget --no-verbose --tries=1 \
	--spider http://localhost:${PORT}/api/users \
	|| exit 1
ENTRYPOINT ["java","-jar","/app/demo-0.0.1.jar"]