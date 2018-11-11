FROM jenkins/jnlp-slave

USER root

RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common build-essential

# RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
#     apt-key fingerprint 0EBFCD88 && \
#     add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
#     apt-get update -qq && \
#     apt-get install -qqy docker-ce && \
#     usermod -aG docker jenkins

# RUN gpasswd -a jenkins docker

RUN wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz && \
    tar -xvf go1.10.1.linux-amd64.tar.gz && \
    mv go /usr/local

ENV GOROOT=/usr/local/go 
ENV PATH=$GOROOT/bin:$PATH 

USER jenkins

RUN mkdir -p /home/jenkins/go && \
    mkdir -p /home/jenkins/go/bin && \
    mkdir -p /home/jenkins/go/src && \
    mkdir -p /home/jenkins/go/pkg && \
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

ENV GOROOT=/usr/local/go 
ENV GOPATH=/home/jenkins/go:/root/workspace/go 
ENV PATH=/home/jenkins/go/bin:/root/workspace/go/bin:$PATH

ENTRYPOINT ["jenkins-slave"]