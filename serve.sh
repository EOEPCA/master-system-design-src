#!/usr/bin/env bash

ORIG_DIR="$(pwd)"
cd "$(dirname "$0")"
BIN_DIR="$(pwd)"

DEFAULT_PORT="9000"

PORT="$1"
if [ -z "${PORT}" ]
then
  PORT="${DEFAULT_PORT}"
fi

BUILD_ROOT="build"
OUTPUT_DIR="${BUILD_ROOT}/asciidoc/html5"

cd "${OUTPUT_DIR}"
xdg-open "http://localhost:${PORT}" >/dev/null 2>&1
python3 -m http.server "${PORT}"

cd "${ORIG_DIR}"
