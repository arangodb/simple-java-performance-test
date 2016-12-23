#!/bin/sh

build/bin/arangod --server.authentication false --database.directory perftest --server.endpoint tcp://127.0.0.1:8529 &

PID=$!
RETURN=1

while [ "$RETURN" != "0" ]; do
  curl -f -s 127.0.0.1:8529/_api/version
  RETURN=$?
done

set -e

./gradlew test --rerun-tasks
