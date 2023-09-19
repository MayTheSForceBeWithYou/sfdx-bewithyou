FROM ubuntu:22.04

LABEL maintainer="Nate Pepper <MayTheSForceBeWithYou@gmail.com>"

USER root

COPY ./entrypoint.bash /

RUN apt -y update
RUN apt -y install curl
RUN apt -y install bash
RUN apt -y install wget
RUN apt -y install software-properties-common
RUN apt -y install apt-transport-https
RUN apt -y install gnupg
RUN apt -y install jq
RUN apt -y install git
RUN apt -y install gh
RUN apt -y install openjdk-17-jdk

# Install node v20
RUN apt -y install ca-certificates
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt update
RUN apt -y install nodejs -y

RUN npm install -g sfdx-cli
RUN sfdx plugins install @salesforce/sfdx-scanner
RUN echo y | sfdx plugins install sfdx-hardis
RUN echo y | sfdx plugins install sfdx-git-delta

RUN chmod 755 /entrypoint.bash

USER nobody

ENTRYPOINT [ "/entrypoint.bash" ]
