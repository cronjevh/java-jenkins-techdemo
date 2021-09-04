FROM jenkins/inbound-agent:alpine as jnlp

FROM maven:3.6.3-jdk-11-slim

RUN apt-get update && \
    apt-get install -y \
        git \
        libfontconfig1 \
        libfreetype6 && \
    apt-get upgrade -y curl

COPY --from=jnlp /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=jnlp /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

USER root

# Install Docker client
ARG DOCKER_VERSION=18.03.0-ce
ARG DOCKER_COMPOSE_VERSION=1.21.0
RUN curl -fsSL https://download.docker.com/linux/static/stable/`uname -m`/docker-$DOCKER_VERSION.tgz | tar --strip-components=1 -xz -C /usr/local/bin docker/docker
RUN curl -fsSL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose

RUN touch /debug-flag

COPY --from=bitnami/kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]exit
