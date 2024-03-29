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
#     cd htrace.sh && build/build.sh
#
#   For init:
#     docker run --rm -it --name htrace.sh htrace.sh -u https://nmap.org -h
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
RUN apk add --no-cache git
RUN go install github.com/ssllabs/ssllabs-scan@latest
RUN go install github.com/maxmind/geoipupdate/cmd/geoipupdate@latest
RUN go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

FROM drwetter/testssl.sh:3.0 AS testssl

FROM alpine:3.14

LABEL org.opencontainers.image.authors="trimstray@gmail.com"

RUN \
  apk add --no-cache \
  bash \
  bc \
  bind-tools \
  ca-certificates \
  coreutils \
  curl \
  drill \
  git \
  gnupg \
  ncurses \
  openssl \
  procps \
  unzip \
  wget \
  jq \
  libmaxminddb \
  python3 \
  py3-pip \
  rsync \
  nghttp2

RUN apk add --no-cache nmap nmap-nselibs nmap-scripts

RUN \
  git clone --depth 1 https://github.com/scipag/vulscan /opt/scipag_vulscan && \
  ln -s /opt/scipag_vulscan /usr/share/nmap/scripts/vulscan

RUN apk add --no-cache php php7-curl php7-xml php7-dom

RUN \
  apk add --no-cache composer && \
  composer global require bramus/mixed-content-scan && \
  ln -s /root/.composer/vendor/bramus/mixed-content-scan/bin/mixed-content-scan /usr/bin/mixed-content-scan

RUN \
  apk add --no-cache nodejs npm && \
  npm config set unsafe-perm true && \
  npm install -g observatory-cli

RUN \
  git clone --depth 1 https://github.com/EnableSecurity/wafw00f /opt/wafw00f && \
  cd /opt/wafw00f && \
  python3 setup.py install

COPY --from=golang /go/bin/ssllabs-scan /usr/bin/ssllabs-scan
COPY --from=golang /go/bin/geoipupdate /usr/bin/geoipupdate
COPY --from=golang /go/bin/subfinder /usr/bin/subfinder
COPY --from=testssl /usr/local/bin/testssl.sh /usr/bin/testssl.sh
COPY --from=testssl /home/testssl/etc/ /etc/testssl/etc/

ARG GEOIP_ACCOUNT=0
ARG GEOIP_LICENSE=000000000000
RUN \
  mkdir -p /usr/local/etc/ && \
  echo -en "AccountID ${GEOIP_ACCOUNT}\\nLicenseKey ${GEOIP_LICENSE}\\nEditionIDs GeoLite2-Country GeoLite2-City" > /usr/local/etc/GeoIP.conf

RUN \
  mkdir -p /usr/local/share/GeoIP/ && \
  geoipupdate || true # skip error if fails due account

RUN \
  ln -s /usr/local/share/GeoIP /usr/share/

ENV TESTSSL_INSTALL_DIR /etc/testssl

WORKDIR /opt/htrace.sh

COPY bin /opt/htrace.sh/bin/
COPY lib /opt/htrace.sh/lib/
COPY src /opt/htrace.sh/src/
COPY static /opt/htrace.sh/static/
COPY dependencies.sh setup.sh config /opt/htrace.sh/

RUN ./setup.sh install

ENTRYPOINT ["/usr/local/bin/htrace.sh"]
CMD ["--help"]
