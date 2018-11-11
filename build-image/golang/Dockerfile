FROM jenkins/jnlp-slave

USER root

RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common build-essential jq libapparmor-dev libseccomp-dev

RUN curl https://sdk.cloud.google.com | bash && \
    mv google-cloud-sdk /opt
ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV PATH=/opt/google-cloud-sdk/bin:$PATH
RUN gcloud components install kubectl

RUN wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz && \
    tar -xvf go1.10.1.linux-amd64.tar.gz && \
    mv go /usr/local

ENV GOROOT=/usr/local/go 
ENV PATH=$GOROOT/bin:$PATH 

RUN mkdir -p /home/jenkins/go/bin && \
    mkdir -p /home/jenkins/go/src && \
    mkdir -p /home/jenkins/go/pkg && \
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh && \
    go get github.com/golang/mock/gomock && \
    go install github.com/golang/mock/mockgen

ENV GOROOT=/usr/local/go 
ENV GOPATH=/home/jenkins/go:/root/workspace/go 
ENV PATH=/home/jenkins/go/bin:/root/workspace/go/bin:$PATH

ENTRYPOINT ["jenkins-slave"]