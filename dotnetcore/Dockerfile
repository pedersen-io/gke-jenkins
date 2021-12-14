FROM build-jenkins-base

USER root

# dotnetcore
RUN curl -sOL https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-6.0

ENTRYPOINT ["jenkins-slave"] 