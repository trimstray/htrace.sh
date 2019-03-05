#!/usr/bin/env bash

# shellcheck disable=SC2034
_arg="$1"

if [[ "$OSTYPE" == "darwin"* ]] ; then

  [ ! -z "$(brew --prefix)" ] && PATH=$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH

  readonly _dir=$(dirname "$(readlink "$0" || echo "$(echo "$0" | sed -e 's,\\,/,g')")")

elif [[ "$OSTYPE" == "linux-gnu" ]] ; then

  readonly _dir=$(dirname "$(readlink -f "$0" || echo "$(echo "$0" | sed -e 's,\\,/,g')")")

else

  printf "Unsupported system version.\\n"
  exit 1

fi

if [[ "$1" == "install" ]] ; then

  printf "%s\\n" "Create symbolic link to /usr/local/bin"

  if [[ -e "${_dir}/bin/htrace.sh" ]] ; then

    if [[ ! -e "/usr/local/bin/htrace.sh" ]] ; then

      ln -s "${_dir}/bin/htrace.sh" /usr/local/bin

    fi

  fi

  printf "%s\\n" "Create man page to /usr/local/man/man8"

  if [[ -e "${_dir}/static/man8/htrace.sh.8" ]] ; then

    if [[ ! -e "/usr/local/man/man8/htrace.sh.8.gz" ]] ; then

      mkdir -p /usr/local/man/man8
      cp "${_dir}/static/man8/htrace.sh.8" /usr/local/man/man8
      gzip /usr/local/man/man8/htrace.sh.8

    fi

  fi

elif [[ "$1" == "uninstall" ]] ; then

  printf "%s\\n" "Remove symbolic link from /usr/local/bin"

  if [[ -L "/usr/local/bin/htrace.sh" ]] ; then

    unlink /usr/local/bin/htrace.sh

  fi

  printf "%s\\n" "Remove man page from /usr/local/man/man8"

  if [[ -e "/usr/local/man/man8/htrace.sh.8.gz" ]] ; then

    rm /usr/local/man/man8/htrace.sh.8.gz

  fi

else

  printf "Usage:\\n  ./setup.sh install     (Install)\\n  ./setup.sh uninstall   (Uninstall)\\n"

fi

exit 0
