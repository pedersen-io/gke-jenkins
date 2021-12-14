FROM build-jenkins-base

USER root

# dotnetcore
RUN curl -sOL https://download.visualstudio.microsoft.com/download/pr/bd94779d-c7c4-47fd-b80a-0088caa0afc6/40f115bbf4c068359e7a066fe0b03dbc/dotnet-sdk-6.0.101-linux-musl-x64.tar.gz && \
    mkdir -p $HOME/dotnet && \
    tar zxf dotnet-sdk-6.0.101-linux-musl-x64.tar.gz -C $HOME/dotnet
ENV DOTNET_ROOT=$HOME/dotnet
ENV PATH=$PATH:$HOME/dotnet

ENTRYPOINT ["jenkins-slave"] 