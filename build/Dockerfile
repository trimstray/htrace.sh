### BEG SCRIPT INFO
#
# Header:
#
#         fname : "Dockerfile"
#         cdate : "12.07.2018"
#        author : "Michał Żurawski <trimstray@gmail.com>"
#      tab_size : "2"
#     soft_tabs : "yes"
#
# Description:
#
#   This Dockerfile builds a static htrace.sh in a Docker container.
#
#   - converted Dockerfile to Alpine Linux
#     author: https://github.com/davidneudorfer
#
#   For build:
#     docker build --rm -t htrace.sh -f Dockerfile .
#
#   For init:
#     docker run --rm -it --name htrace.sh htrace.sh -u http://nmap.org -h
#
#   For debug:
#     docker exec -it htrace.sh /bin/bash
#     docker run --rm -it --entrypoint /bin/bash --name htrace.sh htrace.sh
#
# License:
#
#   htrace.sh, Copyright (C) 2018  Michał Żurawski
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see <http://www.gnu.org/licenses/>.
#
### END SCRIPT INFO

FROM golang:alpine AS golang
RUN apk update && apk add --no-cache git
RUN go get github.com/ssllabs/ssllabs-scan

FROM alpine:latest AS builder
RUN \
  apk add --no-cache nodejs-current npm && rm -rf /var/cache/apk/* \
  && npm config set unsafe-perm true && npm install -g observatory-cli
RUN \
  apk add --no-cache composer php7-curl php7-xml && rm -rf /var/cache/apk/* \
  && composer global require bramus/mixed-content-scan

FROM drwetter/testssl.sh:stable AS testssl

FROM alpine:latest

MAINTAINER trimstray "trimstray@gmail.com"

RUN \
  apk add --no-cache \
    bash \
    bc \
    bind-tools \
    ca-certificates \
    coreutils \
    curl \
    drill \
    geoip \
    git \
    gnupg \
    ncurses \
    nmap \
    openssl \
    procps \
    unzip \
    wget \
    jq \
  && rm -rf /var/cache/apk/*

COPY --from=golang /go/bin/ssllabs-scan /usr/bin/ssllabs-scan
COPY --from=builder /usr/lib/node_modules/observatory-cli/index.js /usr/bin/observatory
COPY --from=builder /root/.composer/vendor/bramus/mixed-content-scan/bin/mixed-content-scan /usr/bin/mixed-content-scan
COPY --from=testssl /usr/local/bin/testssl.sh /usr/local/bin/testssl.sh

RUN \
  mkdir -p /opt/git && cd /opt/git \
  && git clone https://github.com/trimstray/htrace.sh.git \
  && cd htrace.sh \
  && mkdir -p /opt/git/htrace.sh/log/ \
  && ln -s /usr/local/bin/testssl.sh /usr/local/bin/testssl \
  && bash setup.sh install

ENTRYPOINT ["/usr/local/bin/htrace.sh"]
CMD ["--help"]
