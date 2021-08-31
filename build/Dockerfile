FROM jenkins/jenkins:lts-jdk11
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root
RUN curl -sSL https://get.docker.com/ | sh

# Install kubectl from Docker Hub.
COPY --from=bitnami/kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/kubectl
RUN chmod +x /usr/local/bin/kubectl

# Install required packages
RUN apt-get update \
 && apt-get install -y curl gnupg apt-transport-https genisoimage wget \
 && rm -rf /var/lib/apt/lists/*

# Install PowerShell from Microsoft’s repository
# The jenkins:lts image is based on Debian 9 (Stretch)
# For information about how to install PowerShell in Debian 9, see the following link:
# https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-6#debian-9
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 #&& wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
 #&& dpkg -i packages-microsoft-prod.deb \
 ###
 #&& sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/microsoft.list' \
 #&& apt-get update \
 #&& apt-get install -y aspnetcore-runtime-3.1 \
 && wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb \
 # Register the Microsoft repository GPG keys
 && dpkg -i packages-microsoft-prod.deb \
 && apt-get update \
 #&& apt-get install -y powershell aspnetcore-runtime-3.1 \
 && apt-get install -y powershell \
 && rm -rf /var/lib/apt/lists/*

# USER jenkins

# I wouldn't normally dream of running anyhthing as root, but while the group-add 0
# command works fine for docker, I couldn't find the equivalent for k8s in a reasonable
# time period (container privileged didn't work). Don't tun this Dockerfile for anything
# other than testing, only on your local machine.