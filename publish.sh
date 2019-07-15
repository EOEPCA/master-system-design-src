#!/usr/bin/env bash

ORIG_DIR="$(pwd)"
cd "$(dirname "$0")"
BIN_DIR="$(pwd)"

./gradlew -b build.publish.gradle gitPublishPush

cd "${ORIG_DIR}"
