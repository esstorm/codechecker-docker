#!/usr/bin/env bash

export PATH=$PATH:/home/casper/codechecker/build/CodeChecker/bin
. /home/casper/codechecker/venv/bin/activate

# Wait for up to 300 secs
echo '=> Waiting for postgres container to be available'
/wait-for-it.sh -t 300 db:5432

echo '=> Postgres is available!'

CodeChecker server --postgresql --not-host-only \
    --db-host db --db-port 5432 \
    --db-username codechecker --db-name codechecker_config &

CodeChecker cmd products add Default --name "Default Product" \
  --postgresql \
  --db-host db --db-port 5432 \
  --db-username codechecker --db-name default_product
