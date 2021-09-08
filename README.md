# java-jenkins-techdemo
> This project is purely intended as a sandbox demonstration environment for creating a containerised CI/CD pipeline with Jenkins for a sample Java app. Nothing in here should be used anywhere other than in a local testing environment for educational purposes.

A simple Jenkins pipeline for a sample Java app.



## Jenkins Pipeline

<u>Specifications</u>

1. Log  files saved to persistent storage.
2. SSL termination inside the container with self-signed certificates
3. Application to be accessible over both http and https.
4. Use Jenkins to poll Git every 15m for changes

<u>Toolset</u>

- Github for source control (this repo)
- Minikube (shown in the project running on Docker for Windows on WSL2)
- Azure DevOps Public Project [jenkins-java-techdemo](https://dev.azure.com/cronjevh-techdemo/jenkins-java-techdemo) for work tracking band backlog.
- [Typora](https://typora.io/) for markdown formatting

<u>Assumptions</u>

- [Tomcat Sample app](https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/) is expected to run unmodified. 

## Usage

Fork this project .. 

Assuming Powershell is available, with a kubectl context set to local Kubernetes

```powershell
cd .\build
.\run-jenkins-in-kubernetes.ps1 # Deployes Jenkins with custom values based on official repo
```

Jenkins builds and deploys the ./src/Dockerfile and updates a k8s deployment in the local cluster which can be accessed through https://localhost:30810/sample/

![image-20210901131904263](./doc/images/README/image-20210901131904263.png)

## Known loose ends

1. Maven was incorporated just 'for the sake of using Maven' - and really all that's being done is that Maven's capability of running arbitrary bash scripts are used to trigger a normal Docker Build of a Dockerfile. 
2. Dockerfile buil should include automated test suites - there's little to test at this stage.
3. [Snyk Docker security scans](https://dev.azure.com/cronjevh-techdemo/jenkins-java-techdemo/_workitems/edit/18) should be included as part of the Docker build process.

