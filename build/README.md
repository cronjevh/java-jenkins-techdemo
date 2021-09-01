# Jenkins containerised CI/CD

For the Jenkins job I've considered the following two options

1. Keep a Jenkins deployment running inside the cluster, and configure the SCM fetch 
2. Set up Jenkins to run in a stateless fashion as a k8s cronjob with state in persistent storage - with the options to start up a debug/config containers

I decided on doing option 1, as the more 'declarative' option, but had to eventually settle for option 2 due to time constraints.

## Components

1. Using Jenkins from https://hub.docker.com/r/jenkins/jenkins jenkins/jenkins:lts-jdk11
2. Custom Jenkins Dockerfile incl. docker-in-docker configuration, Powershell as well Jenkins plugins (not fully utilised yet)
3. Jenkinsfile with a Pipeline configuration (which currently still needs to be manually copy/pasted to the Jenkins Job)
4. Kubernetes definitions incl persistent storage for running Jenkins locally on nodeport  http://localhost:30808

## Resources from the Web

https://github.com/jenkinsci/docker#preinstalling-plugins
https://www.digitalocean.com/community/tutorials/how-to-automate-jenkins-setup-with-docker-and-jenkins-configuration-as-code
https://github.com/smoogie/jenkins_docker_example
https://tomgregory.com/running-docker-in-docker-on-windows/
https://stackoverflow.com/questions/42541356/how-to-create-a-self-signed-ssl-certificate-for-use-with-tomcat
https://codefresh.io/howtos/using-docker-maven-maven-docker/

## Known limitations

1. No authentication implemented in Jenkins - insecure
2. Git credentials needs to be added manually with Jenkins credentials manager
3. Maven or Ant scripts not used for containerisation (I didn't give this much thought as the Dockerfile build seems perfectly adequate for this use case.)