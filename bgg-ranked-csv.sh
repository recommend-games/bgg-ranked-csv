#!/usr/bin/env bash

set -euo pipefail

SAVE_DIR="$(pwd)"
SOURCE_DIR="$(dirname "$(readlink --canonicalize "${BASH_SOURCE[0]}")")"
# TODO make argument
DATA_DIR="$(readlink --canonicalize "${SOURCE_DIR}/../bgg-ranking-historicals")"
OUTPUT_FILE="$(date --utc '+%Y-%m-%dT%H-%M-%S').csv"

mkdir --parents "${DATA_DIR}"

cd "${SOURCE_DIR}"
echo "Fetch BGG rankings and write results to <${DATA_DIR}/${OUTPUT_FILE}>"
./bgg-ranked-csv > "${DATA_DIR}/${OUTPUT_FILE}"
echo "Done fetching."

cd "${SAVE_DIR}"
