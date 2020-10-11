FROM ubuntu:20.04

LABEL vendor="10Security.com"
LABEL maintainer="matt.tesauro@10security.com"
LABEL version="1.3.8"
LABEL description="Base image for container security project"

ENV DEBIAN_FRONTEND noninteractive

## Update OS and setup user + directory structure for appsecpipeline
RUN apt-get update && \
    apt-get upgrade -y && \
    mkdir /opt/cs-project && \
    useradd -m -d /home/csproj csproj -u 1337 && \
    chown csproj:csproj /opt/cs-project && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

WORKDIR /opt/cs-project
