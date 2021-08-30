FROM bitnami/java:1.8 as builder
WORKDIR /app
RUN wget https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war

FROM tomcat
COPY --from=builder /app /usr/local/tomcat
WORKDIR /usr/local/tomcat
EXPOSE 8080
CMD ["java", "-jar", "sample.war"]