#!/usr/bin/env bash

ORIG_DIR="$(pwd)"
cd "$(dirname "$0")"
BIN_DIR="$(pwd)"

BUILD_ROOT="build"
OUTPUT_DIR="${BUILD_ROOT}/asciidoc/html5"
PDF_FILE="EOEPCA-master-system-design.pdf"

echo "Remove existing output directory"
find "${BUILD_ROOT}" -type f -exec rm -f {} \;

# Create output dirs and copy resources
echo "Create output directory: ${OUTPUT_DIR}"
mkdir -p "${OUTPUT_DIR}"
echo "Copy images/ to output directory"
cp -r src/docs/asciidoc/images "${OUTPUT_DIR}"
echo "Copy stylesheets/ to output directory"
cp -r src/docs/asciidoc/stylesheets "${OUTPUT_DIR}"

# Generate HTML
echo -n "Generating HTML output: "
docker run --user $(id -u):$(id -g) --rm -it -v $(pwd):/documents/ asciidoctor/docker-asciidoctor asciidoctor -r asciidoctor-diagram -D "${OUTPUT_DIR}" src/docs/asciidoc/index.adoc
rm -rf \?
echo "[done]"

# Generate PDF
if [ "$1" == "nopdf" ]
then
    echo "WARNING: Skipping generation of PDF file (${PDF_FILE})"
else
    echo -n "Generating PDF output (${PDF_FILE}): "
    docker run --user $(id -u):$(id -g) --rm -it -v $(pwd):/documents/ asciidoctor/docker-asciidoctor bash -c "cd src/docs/asciidoc && asciidoctor-pdf -r asciidoctor-diagram -D \"../../../${OUTPUT_DIR}\" -o \"${PDF_FILE}\" index.adoc"
    echo "[done]"
fi

cd "${ORIG_DIR}"
