### BEG SCRIPT INFO
#
# Header:
#
#         fname : "htrace.sh"
#         cdate : "12.07.2018"
#        author : "Michał Żurawski <trimstray@gmail.com>"
#      tab_size : "2"
#     soft_tabs : "yes"
#
# Description:
#
#   This Dockerfile builds a static htrace.sh in a Docker container.
#
#   For build:
#   - docker build --rm -t htrace.sh -f Dockerfile .
#
#   For init:
#   - docker run -it --entrypoint /usr/local/bin/htrace.sh --name htrace.sh \
#     --rm htrace.sh -d http://nmap.org
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

FROM debian:stretch

MAINTAINER trimstray "trimstray@gmail.com"

RUN \
  apt-get update && \
  apt-get install -y git ca-certificates openssl curl dnsutils bc

RUN \
  apt-get install -y --reinstall procps

RUN \
  git clone https://github.com/trimstray/htrace.sh.git && \
  cd htrace.sh && \
  bash setup.sh install

RUN \
  apt-get purge -y git && \
  apt-get clean && apt-get autoclean && \
  apt-get -y autoremove --purge && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/htrace.sh"]
CMD ["--help"]
