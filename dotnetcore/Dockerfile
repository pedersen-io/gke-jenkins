FROM jenkins/jnlp-slave

USER root

# apt-get update, build essentials, gcloud, kubectl
RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common build-essential jq libapparmor-dev libseccomp-dev && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && \
    apt-get update -y && \
    apt-get install google-cloud-sdk -y && \
    apt-get install kubectl -y

# docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
        apt-key fingerprint 0EBFCD88 && \
        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
        apt-get update -qq && \
        apt-get install -qqy docker-ce && \
        usermod -aG docker jenkins
RUN gpasswd -a jenkins docker

# helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

# dotnetcore
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \ 
    wget -q https://packages.microsoft.com/config/debian/9/prod.list && \
    mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
RUN apt-get update && \
    apt-get install -y dotnet-sdk-2.1

ENTRYPOINT ["jenkins-slave"] 