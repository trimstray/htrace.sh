#!/usr/bin/env bash

set -eux

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"
echo $ROOT_DIR
cd $ROOT_DIR

docker build -t htrace.sh -f build/Dockerfile .