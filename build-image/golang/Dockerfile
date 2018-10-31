FROM jenkins/jnlp-slave

USER root

RUN apt-get update
RUN apt-get install -y software-properties-common

RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update -qq && \
    apt-get install -qqy docker-ce && \
    usermod -aG docker jenkins

RUN gpasswd -a jenkins docker

RUN apt-get -y install build-essential

RUN wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
RUN tar -xvf go1.10.1.linux-amd64.tar.gz
RUN mv go /usr/local

ENV GOROOT=/usr/local/go 
RUN echo $GOROOT
ENV PATH=$GOROOT/bin:$PATH 
RUN echo $PATH

RUN mkdir -p /home/jenkins/go/bin
RUN mkdir -p /home/jenkins/go/src
RUN chmod -R 777 /home/jenkins/go

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

USER jenkins

ENV GOROOT=/usr/local/go 
RUN echo $GOROOT
ENV GOPATH=/home/jenkins/go:/root/workspace/go
RUN echo $GOPATH
ENV PATH=/home/jenkins/go/bin:/root/workspace/go/bin:$PATH
RUN echo $GOPATH

ENTRYPOINT ["jenkins-slave"]