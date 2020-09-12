FROM build-jenkins-base

USER root

# go
RUN wget https://dl.google.com/go/go1.15.2.linux-amd64.tar.gz && \
    tar -xvf go1.15.2.linux-amd64.tar.gz && \
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
    go install github.com/golang/mock/mockgen && \
    download_url=$(curl -s https://api.github.com/repos/go-swagger/go-swagger/releases/latest | jq -r '.assets[] | select(.name | contains("'"$(uname | tr '[:upper:]' '[:lower:]')"'_amd64")) | .browser_download_url') && \
    curl -o /usr/local/bin/swagger -L'#' "$download_url" && \
    chmod +x /usr/local/bin/swagger
ENV GOROOT=/usr/local/go 
ENV GOPATH=/home/jenkins/go:/root/workspace/go 
ENV PATH=/home/jenkins/go/bin:/root/workspace/go/bin:$PATH

ENTRYPOINT ["jenkins-slave"]