#!/usr/bin/env bash

ORIG_DIR="$(pwd)"
cd "$(dirname "$0")"
BIN_DIR="$(pwd)"

BUILD_ROOT="build"
OUTPUT_DIR="${BUILD_ROOT}/asciidoc/html5"

cd "${OUTPUT_DIR}"
xdg-open "http://localhost:8000" >/dev/null 2>&1
python3 -m http.server

cd "${ORIG_DIR}"
