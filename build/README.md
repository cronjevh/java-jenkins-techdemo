# Jenkins containerised CI/CD

## tl;dr

Windows - (links to [chocolatey install](https://chocolatey.org/install)) Connected to a [minikube](https://community.chocolatey.org/packages/Minikube) instance with [kubectl](https://community.chocolatey.org/packages/kubernetes-cli) and  [helm](https://community.chocolatey.org/packages/kubernetes-helm) available on the path, run

```
.\run-jenkins-in-minikube.ps1
```

## What does it it do?

1. Creates namespaces required for helm values.yaml
2. Deploys the [Jenkins Helm Chart](https://github.com/jenkinsci/helm-charts) with values from (take note of where to get admin password)
   1. Jenkins is deployed with a preset [Configuration as Code | Jenkins plugin](https://plugins.jenkins.io/configuration-as-code/)
   2. which includes a prepopulated [Jobs DSL](https://plugins.jenkins.io/job-dsl/) configuration which is linked jobs.groovy in this repo.
   3. the Jobs DSL configuration runs a [Jenkinsfile pipeline](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/), also from source at ..\src\Jenkinsfile
3. Applies rbac definitions to match values.yaml

Once Jenkins is up and running, set up port forwarding by running

```
minikube service --url jenkins -n jenkins-controller
```

to see the log files for the Java sample app that gets deployed run (create the folder if it doesn't exist)

```
minikube mount c:\minikube:/tmp/hostpath-provisioner/sampleapp/sampleapp-pvc
```



## Components

Docker images 

- [cronjevh/jenkins-with-plugins - Docker Hub](cronjevh/jenkins-with-plugins - Docker Hub) (see ./jenkins-controller/Dockerfile)
  - based on the standard Jenkins Docker release with plugins slipstreamed into the image
- [cronjevh/jenkins-maven-docker- Docker Hub](https://hub.docker.com/repository/docker/cronjevh/jenkins-maven-docker) (see ./jenkins-agent/Dockerfile)
   - a convoluted (and insecure - look out for root user) attempt to use Maven in the containerisation process. 

## Resources from the Web

- https://github.com/jenkinsci/docker#preinstalling-plugins
- https://www.digitalocean.com/community/tutorials/how-to-automate-jenkins-setup-with-docker-and-jenkins-configuration-as-code
- https://github.com/smoogie/jenkins_docker_example
- https://tomgregory.com/running-docker-in-docker-on-windows/
- https://stackoverflow.com/questions/42541356/how-to-create-a-self-signed-ssl-certificate-for-use-with-tomcat
- https://codefresh.io/howtos/using-docker-maven-maven-docker/
- https://pushbuildtestdeploy.com/jenkins-on-kubernetes-building-docker-images/
- https://support.cloudbees.com/hc/en-us/articles/360038636511-Kubernetes-Plugin-Authenticate-with-a-ServiceAccount-to-a-remote-cluster

## Known limitations

The cronjevh/jenkins-maven-docker Dockerfile runs as root. While it's never ok to run as root, for this tech demo, the risks are accepted because:

1. This is only intended for running in a local, minikube instance for prototyping purposes.
2. The Jenkins agent and deployed sample app are running in dedicate namespaces with least privilege access.

Additionally, it's far from 'proper' to mix the Helm chart which has dynamic values, with hardcoded values in the repo yaml files. For the the time being, incorporating the changes into the Helm chart will have to stay [on the backlog.](https://dev.azure.com/cronjevh-techdemo/jenkins-java-techdemo/_workitems/edit/34)

