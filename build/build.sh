#!/usr/bin/env bash

set -eux

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null && pwd )"

docker build -t htrace.sh -f build/Dockerfile "${ROOT_DIR}"
