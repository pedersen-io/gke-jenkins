FROM jenkins/jnlp-slave

USER root
RUN apt-get update
RUN apt-get -y install build-essential

RUN wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
RUN tar -xvf go1.10.1.linux-amd64.tar.gz
RUN mv go /usr/local

USER jenkins

ENV GOROOT=/usr/local/go
ENV GOPATH=/root/workspace
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH

USER root

RUN mkdir -p /root/workspace/bin
RUN chown jenkins /root/workspace/bin

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

USER jenkins

ENTRYPOINT ["jenkins-slave"]