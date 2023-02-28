#!/usr/bin/env bash

set -euo pipefail

SAVE_DIR="$(pwd)"
SOURCE_DIR="$(dirname "$(readlink --canonicalize "${BASH_SOURCE[0]}")")"
# TODO make argument
DATA_DIR="$(readlink --canonicalize "${SOURCE_DIR}/../bgg-ranking-historicals")"
OUTPUT_FILE="$(date --utc '+%Y-%m-%dT%H-%M-%S').csv"

mkdir --parents "${DATA_DIR}"

echo "Fetch BGG rankings and write results to <${DATA_DIR}/${OUTPUT_FILE}>"
cd "${SOURCE_DIR}"
source '.env' || echo 'Unable to read .env'
./bgg-ranked-csv > "${DATA_DIR}/${OUTPUT_FILE}"
echo "Done fetching."

echo "Commit results to repo <${DATA_DIR}>"
cd "${DATA_DIR}"
git add "${DATA_DIR}/${OUTPUT_FILE}"
git commit --no-gpg-sign \
    --message "Added ${OUTPUT_FILE}"

echo "Push new commits to remote repos"
for REMOTE in $(git remote); do
    echo "Pushing to <${REMOTE}>"
    git push "${REMOTE}" || echo "Unable to push to <${REMOTE}>…"
done
echo "Done."

cd "${SAVE_DIR}"
