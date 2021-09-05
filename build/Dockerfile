# pushed to cronjevh/jenkins-with-plugins:0.0.1
FROM jenkins/jenkins:lts-jdk11
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt