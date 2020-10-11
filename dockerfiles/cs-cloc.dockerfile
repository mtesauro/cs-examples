FROM 10security/cs-base:1.3.8

LABEL vendor="10Security.com"
LABEL maintainer="matt.tesauro@10security.com"
LABEL version="1.82"
LABEL description="Container with cloc, a statistics utility to count lines of code"

ENV DEBIAN_FRONTEND noninteractive

## Update OS and install cloc
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget cloc && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

## Install ssllabs-scan

ARG SSLLAB=1.4.0

RUN wget -qO- https://github.com/ssllabs/ssllabs-scan/releases/download/v${SSLLAB}/ssllabs-scan_${SSLLAB}-linux64.tgz | tar xvz -C /usr/bin --strip-components=1

COPY ./cloc.bash /usr/bin/

RUN chmod 775 /usr/bin/cloc.bash

## Change to csproj user
USER csproj

ENTRYPOINT ["cloc.bash"]
