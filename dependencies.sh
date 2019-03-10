#!/usr/bin/env bash

function _bye() {

  printf '  %s\n\n  \e[1;1;31m%s\e[m\n\n' \
         "Autoinstaller is not available on your system." \
         "For more info please see https://github.com/trimstray/htrace.sh/wiki/Requirements."

  exit 1

}

function _tread() {

  printf '  \e[1;1;30m%s\e[m: \e[1;1;37m%s\e[m\n    \e[1;1;30m%s\e[m: \e[1;1;37m%s\e[m\n\n' \
         "os_name" "$_os_name" \
         "os_id" "$_os_id"

  printf '  %s: ' "Please enter (Y) to continue"

  read _kvar

  if [[ "$_kvar" != "Y" ]] ; then echo ; exit 1 ; fi

  echo

}

# We check if we are a root user.
if [[ "$EUID" -ne 0 ]] ; then

  printf "EUID is not equal 0 (no root user)\\n"
  exit 1

fi

# Machine type.
if [[ "$OSTYPE" == "darwin"* ]] ; then

  _os_name="darwin"
  _os_version=""
  _os_id="darwin"

  readonly _dir=$(dirname "$(readlink "$0" || echo "$(echo "$0" | sed -e 's,\\,/,g')")")

elif [[ "$OSTYPE" == "linux-gnu" ]] || [[ "$OSTYPE" == "linux-musl" ]] ; then

  readonly _dir=$(dirname "$(readlink -f "$0" || echo "$(echo "$0" | sed -e 's,\\,/,g')")")

  if [[ -f /etc/os-release ]] ; then

    source /etc/os-release

    _os_name="$NAME"
    _os_version="$VERSION_ID"
    _os_id="$ID"
    _os_id_like="$ID_LIKE"

  elif type lsb_release >/dev/null 2>&1 ; then

    _os_name=$(lsb_release -si)
    _os_version=$(lsb_release -sr)

  elif [[ -f /etc/lsb-release ]] ; then

    source /etc/lsb-release

    _os_name="$DISTRIB_ID"
    _os_version="$DISTRIB_RELEASE"

  elif [[ -f /etc/debian_version ]] ; then

    _os_name="Debian"
    _os_version=$(cat /etc/debian_version)

  elif [[ -f /etc/redhat-release ]] ; then

    _os_name=$(awk '{print $1}' /etc/redhat-release)
    _os_version=$(awk '{print $4}' /etc/redhat-release)

  elif [[ -f /etc/centos-release ]] ; then

    _os_name=$(awk '{print $1}' /etc/centos-release)
    _os_version=$(awk '{print $4}' /etc/centos-release)

  else

    _bye

  fi

fi

# Global variables.
readonly _tmp="${_dir}/.tmp"

export GOROOT="/usr/lib/go"
export GOPATH="/opt/go"

mkdir -p "${_tmp}" && cd "${_tmp}"

printf "%s" "

  Before start please read all communication on the screen!

"

if [[ "$_os_name" == "darwin" ]] || \
   [[ "$_os_id" == "darwin" ]] || \
   [[ "$_os_id_like" == "darwin" ]] ; then

  _tread

  # System tools.
  brew install coreutils gnu-getopt gnu-sed openssl curl bc jq php72 \
  libmaxminddb geoipupdate python rsync

  brew install node composer

  # For Mozilla-Observatory.
  npm install -g observatory-cli

  # For Ssllabs API.
  brew install ssllabs-scan

  # For mixed-content-scan.
  composer global require bramus/mixed-content-scan

  # For testssl.sh.
  brew install testssl

  # For Nmap NSE Library.
  brew install nmap

  # For WhatWaf.
  git clone https://github.com/ekultek/whatwaf.git /opt/whatwaf
  cd /opt/whatwaf
  chmod +x whatwaf.py
  pip install -r requirements.txt
  ./setup.sh install
  cp ~/.whatwaf/.install/bin/whatwaf /usr/bin/whatwaf
  ./setup.sh uninstall

  # For Sublist3r
  git clone https://github.com/aboul3la/Sublist3r.git /opt/Sublist3r
  cd /opt/Sublist3r
  chmod +x sublist3r.py
  pip install -r requirements.txt
  ln -s /opt/Sublist3r/sublist3r.py /usr/bin/sublist3r.py

  geoipupdate

elif [[ "$_os_name" == "debian" ]] || \
     [[ "$_os_name" == "ubuntu" ]] || \
     [[ "$_os_id" == "debian" ]] || \
     [[ "$_os_id" == "ubuntu" ]] || \
     [[ "$_os_id_like" == "debian" ]] || \
     [[ "$_os_id_like" == "ubuntu" ]] ; then

  _tread

  # System tools.
  apt-get update

  apt-get install -y ca-certificates dnsutils gnupg apt-utils unzip openssl \
  curl bc jq mmdb-bin libmaxminddb0 libmaxminddb-dev python python-pip rsync

  apt-get install -y --reinstall procps

  wget -c https://github.com/maxmind/geoipupdate/releases/download/v4.0.2/geoipupdate_4.0.2_linux_amd64.deb &&
  dpkg -i geoipupdate_4.0.2_linux_amd64.deb

  # For Mozilla-Observatory.
  curl -sL https://deb.nodesource.com/setup_10.x | bash -
  apt-get install -y nodejs
  npm install -g observatory-cli

  # For Ssllabs API.
  apt-get install -y golang
  go get github.com/ssllabs/ssllabs-scan
  # It's important - PATH is hardcoded in src/settings.
  ln -s /opt/go/bin/ssllabs-scan /usr/bin/ssllabs-scan

  # PHP 7.0
  wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
  apt-get update
  apt-get install -y php7.0-curl php7.0-xml php7.0-cli php7.0-mbstring

  # For mixed-content-scan.
  curl -sS https://getcomposer.org/installer -o composer-setup.php
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer

  composer global require bramus/mixed-content-scan

  # It's important - PATH is hardcoded in src/settings.
  if [[ -d ${HOME}/.composer ]] ; then

    ln -s /root/.composer/vendor/bramus/mixed-content-scan/bin/mixed-content-scan \
    /usr/bin/mixed-content-scan

  elif [[ -d ${HOME}/.config/composer ]] ; then

    ln -s /root/.config/composer/vendor/bramus/mixed-content-scan/bin/mixed-content-scan \
    /usr/bin/mixed-content-scan

  fi

  # For testssl.sh.
  git clone --depth 1 https://github.com/drwetter/testssl.sh.git /opt/testssl.sh
  chmod +x /opt/testssl.sh/testssl.sh
  ln -s /opt/testssl.sh/testssl.sh /usr/bin/testssl.sh

  # For Nmap NSE Library.
  # apt-get install nmap
  wget https://nmap.org/dist/nmap-7.70-1.x86_64.rpm
  apt -y install alien
  alien nmap-7.70-1.x86_64.rpm
  dpkg -i nmap_7.70-2_amd64.deb

  # For WhatWaf.
  git clone https://github.com/ekultek/whatwaf.git /opt/whatwaf
  cd /opt/whatwaf
  chmod +x whatwaf.py
  pip install -r requirements.txt
  ./setup.sh install
  cp ~/.whatwaf/.install/bin/whatwaf /usr/bin/whatwaf
  ./setup.sh uninstall

  # For Sublist3r
  git clone https://github.com/aboul3la/Sublist3r.git /opt/Sublist3r
  cd /opt/Sublist3r
  chmod +x sublist3r.py
  pip install -r requirements.txt
  ln -s /opt/Sublist3r/sublist3r.py /usr/bin/sublist3r.py

  geoipupdate

else

  _bye

fi

cd "${_dir}" && rm -fr "${_tmp}"
