FROM jenkins/jenkins:lts

# Switch to root to install packages
USER root

# Install Node.js and npm
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Switch back to jenkins user
USER jenkins
