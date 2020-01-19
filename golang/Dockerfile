FROM jenkins/jnlp-slave

 USER root

RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common build-essential jq libapparmor-dev libseccomp-dev

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
        echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
        apt-get update && \
        apt-get install -y kubectl

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

RUN wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz && \
    tar -xvf go1.10.1.linux-amd64.tar.gz && \
    mv go /usr/local

ENV GOROOT=/usr/local/go 
ENV GOBIN=$GOROOT/bin
ENV PATH=$GOROOT/bin:$PATH 

RUN mkdir -p /home/jenkins/go/bin && \
    mkdir -p /home/jenkins/go/src && \
    mkdir -p /home/jenkins/go/pkg && \
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && \
    go get golang.org/x/tools/go/packages && \
    go get github.com/golang/mock/gomock && \
    go install github.com/golang/mock/mockgen

RUN download_url=$(curl -s https://api.github.com/repos/go-swagger/go-swagger/releases/latest | \
    jq -r '.assets[] | select(.name | contains("'"$(uname | tr '[:upper:]' '[:lower:]')"'_amd64")) | .browser_download_url') && \
    curl -o /usr/local/bin/swagger -L'#' "$download_url" && \
    chmod +x /usr/local/bin/swagger

ENV GOROOT=/usr/local/go 
ENV GOPATH=/home/jenkins/go:/root/workspace/go 
ENV PATH=/home/jenkins/go/bin:/root/workspace/go/bin:$PATH

ENTRYPOINT ["jenkins-slave"]