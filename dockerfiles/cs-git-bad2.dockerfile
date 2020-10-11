FROM 10security/cs-base:1.3.8

LABEL vendor="10Security.com"
LABEL maintainer="matt.tesauro@10security.com"
LABEL version="2.25.1"
LABEL description="Container with fake secrets purposefully added"

ENV DEBIAN_FRONTEND noninteractive

## Update OS and install git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

## Set Environmental variables for git checkouts

ARG CLOUD_PROVIDER_SECRET_KEY

COPY ./git.bash /usr/bin/

RUN chmod 775 /usr/bin/git.bash

## Change to csproj user
USER csproj

ENTRYPOINT ["git.bash"]
