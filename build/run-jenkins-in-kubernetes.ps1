# Run on docker for config and debugging purposes
docker build . -t jenkins

# Deploy Jenkins to current kubectl context
kubectl apply -f jenkins-pvc.yaml
kubectl apply -f jenkins-svc.yaml
kubectl apply -f jenkins-deploy.yaml

# Create ServiceAccount for dynamic agents
kubectl create serviceaccount jenkins-k8s-agent-serviceaccount -n default