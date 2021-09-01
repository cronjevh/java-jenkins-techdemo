# URL Shortener service architecture

## Summary

Deploying the [yourls](https://yourls.org/) open source PHP based project to an existing Kubernetes cluster is proposed for a quickly attainable working service with established security and reliability parameters.

Alternatives architectures considered

| Alternative                      | Description                                                  |
| -------------------------------- | ------------------------------------------------------------ |
| Azure Function/AWS Lambda        | If compute costs are a concern, or no Kubernetes cluster is available, then a serverless option would work. Additional work expected to adapt yourls or similar to start when needed. |
| Azure Container Services /ECS    | If no Kubernetes cluster with the necessary capacity is available, ACS may be considered. The lack of fast storage with ACS could cause performance issues unless a managed MySQL instance is available |
| Azure Web Apps/Elastic Beanstalk | While it may be possible to run the PHP app frontend cheaply on a hosted Web App Service, having to obtain a Mysql database backing service would negate the cost advantage. Additional work needed to deploy app to cloud web hosting service. |



## Toolset

1. [Yourls - Official Image | Docker Hub](https://hub.docker.com/_/yourls)
2. [Mysql - Official Image | Docker Hub](https://hub.docker.com/_/mysql)
3. Pre-existing [Azure Kubernetes Services Cluster](https://azure.microsoft.com/en-us/services/kubernetes-service/) configured with [cert-manager](https://cert-manager.io/docs/installation/helm/) and [externalDNS](https://github.com/helm/charts/tree/master/stable/external-dns) and a dedicated namespace "url-shortener" with compute limit availability of
   1. 2000m CPU
   2. 1 Gi memory
   3. 10GB StandardSSD managed disk persistent volume (for MySQL)

## Diagram

High level architecture for a standard Kubernetes deployment depicted underneath.

![](./src/images/URL Shortener Diagram.svg)