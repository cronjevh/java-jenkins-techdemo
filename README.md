# java-jenkins-techdemo
A simple Jenkins pipeline for a sample Java app.

While not requested in the demo brief, a publicly visible [Azure DevOps Project jenkins-java-techdemo](https://dev.azure.com/cronjevh-techdemo/jenkins-java-techdemo) was created for this demo. (Using project management tools saves more time in the long run)

## Jenkins Pipeline

<u>Specifications</u>

1. Log  files saved to persistent storage.
2. SSL termination inside the container with self-signed certificates
3. Application to be accessible over both http and https.
4. Use Jenkins to poll Git every 15m for changes

<u>Toolset</u>

- Github for source control
- Minikube (using integrated version of Docker for Windows on WSL2)

<u>Assumptions</u>

- [Sample app](https://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/) is expected to run unmodified.
- 



## Optional Extras

.. nobody asked for, but still fun to do ..

1. Do a ngrok tunnel to make the app visible to the public Internet
2. Output Snyk scan results in the reports output.
