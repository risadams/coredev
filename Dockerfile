FROM ubuntu:24.10

LABEL version="1.1.0"
LABEL author="Ris Adams"

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LANG=C.UTF-8

## Install Dependencies
RUN <<EOF
add-apt-repository ppa:dotnet/dotnet8
apt-get update
apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev
apt-get install -y wget apt-transport-https software-properties-common
EOF

# Install NVM, Node, NPM
ENV NVM_DIR=/root/.nvm
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash

# Load NVM and install Node.js and npm
RUN . "$NVM_DIR/nvm.sh" && \
    nvm install node && \
    nvm use node && \
    nvm alias default node && \
    node -v && \
    npm -v

# Install the .NET SDK
RUN apt-get update && \
    apt-get install -y dotnet-sdk-8.0

# Install the .NET Runtime
RUN apt-get install -y dotnet-runtime-8.0

CMD ["/bin/bash","-l"]