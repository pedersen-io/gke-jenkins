FROM jenkins/jnlp-slave

USER root

RUN apt-get update -qq && \
    apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common build-essential jq libapparmor-dev libseccomp-dev

RUN curl https://sdk.cloud.google.com | bash && \
    mv google-cloud-sdk /opt
ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1
ENV PATH=/opt/google-cloud-sdk/bin:$PATH
RUN gcloud components install kubectl

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
    apt-get install -y nodejs

RUN npm install -g @angular/cli

ENTRYPOINT ["jenkins-slave"]