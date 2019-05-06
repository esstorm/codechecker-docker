#!/usr/bin/env bash

export PATH=$PATH:/home/casper/codechecker/build/CodeChecker/bin
. /home/casper/codechecker/venv/bin/activate

exec "$@"
