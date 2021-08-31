For the Jenkins job I've considered the following two options

1. Keep a Jenkins deployment running inside the cluster, and configure the SCM fetch 
2. Set up Jenkins to run in a stateless fashion as a k8s cronjob with state in persistent storage - with the options to start up a debug/config containers


Jenkins job
1. Probably what the demo author had in mind
2. Easier to configure

cronjob
1. "Cooler"
2. Harder to implement
3. Shows commitment to Infrastructure-as-code principles.

For now I'm selecting cronjob - 


Components
1. Using Jenkins from https://hub.docker.com/r/jenkins/jenkins jenkins/jenkins:lts-jdk11
2. Will

Resources:
https://github.com/jenkinsci/docker#preinstalling-plugins
https://www.digitalocean.com/community/tutorials/how-to-automate-jenkins-setup-with-docker-and-jenkins-configuration-as-code
https://github.com/smoogie/jenkins_docker_example
https://tomgregory.com/running-docker-in-docker-on-windows/
https://stackoverflow.com/questions/42541356/how-to-create-a-self-signed-ssl-certificate-for-use-with-tomcat
https://codefresh.io/howtos/using-docker-maven-maven-docker/

Known limitations
1. No authentication implemented in Jenkins