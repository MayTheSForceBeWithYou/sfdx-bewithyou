FROM ubuntu

LABEL maintainer="Nate Pepper <MayTheSForceBeWithYou@gmail.com>"

USER root

COPY ./entrypoint.bash /

RUN apt -y update
RUN apt -y install \
    curl \
    bash \
    wget \
    software-properties-common \
    apt-transport-https \
    gnupg \
    nodejs \
    jq \
    git \
    gh \
    openjdk-17-jdk

RUN chmod 755 /entrypoint.bash

USER nobody

ENTRYPOINT [ "/entrypoint.bash" ]
