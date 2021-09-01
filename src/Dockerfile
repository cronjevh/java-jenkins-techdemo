FROM bitnami/java:1.8 as builder

ARG keystorePass

WORKDIR /app
RUN wget https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war

FROM tomcat
COPY --from=builder /app /usr/local/tomcat/webapps
RUN /usr/local/openjdk-11/bin/keytool -genkey -keyalg RSA -noprompt -alias tomcat -dname "CN=localhost, OU=NA, O=NA, L=NA, S=NA, C=NA" -keystore /usr/local/tomcat/conf/keystore.jks -validity 9999 -storepass changeme -keypass changeme
ADD ./src/server.xml /usr/local/tomcat/conf
WORKDIR /usr/local/tomcat
EXPOSE 8080 8443

CMD ["catalina.sh", "run"]