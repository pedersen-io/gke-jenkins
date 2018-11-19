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

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get -y install google-chrome-stable

ENTRYPOINT ["jenkins-slave"]
