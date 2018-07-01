FROM jenkins/jnlp-slave

USER root

RUN apt-get update
RUN apt-get -y install build-essential

RUN wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
RUN tar -xvf go1.10.1.linux-amd64.tar.gz
RUN mv go /usr/local

ENV GOROOT=/usr/local/go 
RUN echo $GOROOT
ENV PATH=$GOROOT/bin:$PATH 
RUN echo $PATH

RUN mkdir -p /home/jenkins/go/bin

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

USER jenkins

ENV GOROOT=/usr/local/go 
RUN echo $GOROOT
ENV GOPATH=/home/jenkins/go:/root/workspace 
RUN echo $GOPATH
ENV PATH=/home/jenkins/go/bin:/root/workspace/bin:$PATH
RUN echo $PATH

ENTRYPOINT ["jenkins-slave"]