FROM build-jenkins-base

USER root

# dotnetcore
RUN curl --output dotnet-install.sh https://dot.net/v1/dotnet-install.sh
RUN chmod +x dotnet-install.sh && \
    ./dotnet-install.sh

ENTRYPOINT ["jenkins-slave"] 