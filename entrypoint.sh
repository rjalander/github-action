#!/bin/sh

set -e

echo "Sending CDEvent";

echo "source: $INPUT_SOURCE"
echo "subject_id: $INPUT_SUBJECT_ID"
echo "subject_pipeline_name: $INPUT_SUBJECT_PIPELINE_NAME"
echo "subject_url: $INPUT_SUBJECT_URL"
echo "events_broker_url: $INPUT_EVENTS_BROKER_URL"

publish=$(echo 'hi')

echo "$publish" >> "${HOME}/${GITHUB_ACTION}.log"

ce_id=$(uuidgen)

events_broker="http://10.101.1.117:8010/default/events-broker"

curl -v -X POST \
  -H "Ce-Id: $ce_id" -H "Ce-Specversion: 1.0" -H "Ce-Type: cd.change.merged.v1" -H "Ce-Source: $INPUT_SOURCE" -H "Content-Type: application/json" \
  -d '{"gitRepository": "'"$INPUT_SOURCE"'", "gitRevision": "'"$INPUT_SUBJECT_ID"'"}' \
  "$events_broker"


# Write output to STDOUT
echo "$output"
