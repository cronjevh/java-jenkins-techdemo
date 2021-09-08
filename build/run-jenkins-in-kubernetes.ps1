# From https://github.com/jenkinsci/helm-charts/tree/main/charts/jenkins
# Requires kubernetes cluster with connected kubectl and helm3
# helm repo add jenkins https://charts.jenkins.io
# helm repo update

kubectl create namespace jenkins-controller
kubectl create namespace jenkins-agent
kubectl create namespace sampleapp

helm upgrade --install jenkins  `
    -n jenkins-controller `
    -f values.yaml `
    jenkins/jenkins

kubectl apply -f additional-rbac.yaml

# To clean up when when
# helm delete jenkins -n jenkins-controller