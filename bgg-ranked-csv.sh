#!/bin/bash

set -e

OUTPUT_FILE="$(date --utc '+%Y-%m-%dT%H-%M-%S').csv"
SOURCE_DIR='/data/bgg-ranking-historicals'

mkdir -p "${SOURCE_DIR}"

cd "${SOURCE_DIR}"
bgg-ranked-csv > "${OUTPUT_FILE}"
