#!/usr/bin/env bash

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
#   See README.md file for more information.
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


# The array that store call parameters.
# shellcheck disable=SC2034
__init_params=()
__script_params=("$@")

# Tasks for specific system version.
if [[ "$OSTYPE" == "darwin"* ]] ; then

  [ ! -z "$(brew --prefix)" ] && PATH=$(brew --prefix)/opt/gnu-getopt/bin:$(brew --prefix)/opt/gnu-sed/libexec/gnubin:$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH
  [ ! -z "$(composer global config bin-dir --absolute 2>/dev/null)" ] && PATH=$(composer global config bin-dir --absolute 2>/dev/null):$PATH

  # Store the name of the script and directory call.
  readonly _init_name="$(basename "$0")"
  # shellcheck disable=SC2001,SC2005
  readonly _init_directory=$(dirname "$(readlink "$0" || echo "$(echo "$0" | sed -e 's,\\,/,g')")")

elif [[ "$OSTYPE" == "linux-gnu" ]] || [[ "$OSTYPE" == "linux-musl" ]] ; then

  # Store the name of the script and directory call.
  readonly _init_name="$(basename "$0")"
  # shellcheck disable=SC2001,SC2005
  readonly _init_directory=$(dirname "$(readlink -f "$0" || echo "$(echo "$0" | sed -e 's,\\,/,g')")")

else

  printf "Unsupported system version.\\n"
  exit 1

fi

# Set root directory.
readonly _rel="${_init_directory}/.."

# Directory structure.
# shellcheck disable=SC2154
readonly _src="${_rel}/src"
readonly _lib="${_rel}/lib"
readonly _tmp="${_rel}/tmp"

# shellcheck disable=SC1090,SC1091
source "${_src}/settings"
# shellcheck disable=SC1090
source "${_src}/helpers"
# shellcheck disable=SC1090
source "${_src}/__init__"

readonly _version="v1.1.4"


# We pass arguments to the __main__ function.
# It is required if you want to run on arguments type $1, $2, ...
__main__ "${__script_params[@]}"

_exit_ "0"
