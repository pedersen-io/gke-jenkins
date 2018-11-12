FROM jenkins/jnlp-slave

USER root

RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common build-essential jq libapparmor-dev libseccomp-dev

RUN curl https://sdk.cloud.google.com | bash && \
    mv google-cloud-sdk /opt
ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV PATH=/opt/google-cloud-sdk/bin:$PATH
RUN gcloud components install kubectl

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg && \
    mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/ && \ 
    wget -q https://packages.microsoft.com/config/debian/9/prod.list && \
    mv prod.list /etc/apt/sources.list.d/microsoft-prod.list

RUN apt-get update && \
    apt-get install -y dotnet-hosting-2.0.9

ENTRYPOINT ["jenkins-slave"]