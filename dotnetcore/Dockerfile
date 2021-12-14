FROM build-jenkins-base

USER root

# dotnetcore
RUN curl -sOL https://dot.net/v1/dotnet-install.sh
RUN chmod +x dotnet-install.sh
RUN ./dotnet-install.sh

ENTRYPOINT ["jenkins-slave"] 