# Run on docker for config and debugging purposes
docker build . -t jenkins
# docker run --name  jenkinscontainer `
#     --group-add 0 `
#     -p 8080:8080 `
#     -v C:\Repos\java-jenkins-techdemo\build\.persistentstorage:/var/jenkins_home `
#     -v "//var/run/docker.sock:/var/run/docker.sock" `
#     jenkins