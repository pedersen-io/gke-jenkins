FROM build-jenkins-base

USER root

# dotnetcore
RUN curl -sOL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \ 
    curl -sOL https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb
RUN apt-get update && \
    apt-get install -y && \
    apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-6.0

ENTRYPOINT ["jenkins-slave"] 