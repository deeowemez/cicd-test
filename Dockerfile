FROM jenkins/jenkins:lts

USER root

# Install Node.js (Debian way)
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

USER jenkins