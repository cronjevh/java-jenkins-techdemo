# From https://github.com/jenkinsci/helm-charts/tree/main/charts/jenkins
# Requires kubernetes cluster with connected kubectl and helm3
# helm repo add jenkins https://charts.jenkins.io
# helm repo update

kubectl create namespace jcasc

helm upgrade --install jcasc  `
    -n jcasc `
    ../jcasc-helm

helm delete jcasc -n jcasc