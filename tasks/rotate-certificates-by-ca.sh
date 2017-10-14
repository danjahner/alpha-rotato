#!/bin/bash

set -x -e

credhub l 

TOKEN="$(credhub --token)"

echo $SIGNED_BY_TO_ROTATE | jq -r .[] | while read object; do
  curl https://${CREDHUB_SERVER}/api/v1/bulk-regenerate \
  -X POST \
  -H "authorization: ${TOKEN}" \
  -H 'content-type: application/json' \
  -d "{\"signed_by\": \"${object}\"" \ 
  -k
done

