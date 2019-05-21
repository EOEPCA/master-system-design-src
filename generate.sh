#!/usr/bin/env bash

ORIG_DIR="$(pwd)"
cd "$(dirname "$0")"
BIN_DIR="$(pwd)"

BUILD_ROOT="build"
OUTPUT_DIR="${BUILD_ROOT}/asciidoc/html5"
PDF_FILE="EOEPCA-master-system-design.pdf"

echo "Remove existing output directory"
rm -rf "${BUILD_ROOT}"

# Create output dirs and copy resources
echo "Create output directory: ${OUTPUT_DIR}"
mkdir -p "${OUTPUT_DIR}"
echo "Copy images/ to output directory"
cp -r src/docs/asciidoc/images "${OUTPUT_DIR}"
echo "Copy stylesheets/ to output directory"
cp -r src/docs/asciidoc/stylesheets "${OUTPUT_DIR}"

# Generate HTML
echo -n "Generating HTML output: "
docker run --rm -it -v $(pwd):/documents/ asciidoctor/docker-asciidoctor asciidoctor -D "${OUTPUT_DIR}" src/docs/asciidoc/index.adoc
echo "[done]"

# Generate PDF
echo -n "Generating PDF output (${PDF_FILE}): "
docker run --rm -it -v $(pwd):/documents/ asciidoctor/docker-asciidoctor asciidoctor-pdf -D "${OUTPUT_DIR}" -o "${PDF_FILE}" src/docs/asciidoc/index.adoc
echo "[done]"

cd "${ORIG_DIR}"
