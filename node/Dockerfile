FROM build-jenkins-base

USER root

# node, angular-cli, vue-cli, npx
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn && \
    npm install -g @angular/cli && \
    npm install -g @vue/cli 

# chrome
RUN curl -sL https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && apt-get -y install google-chrome-stable

ENTRYPOINT ["jenkins-slave"]