#!/bin/bash

set -e

credhub l 

echo $KEYS_TO_ROTATE | jq -r .[] | while read object; do
  OLDKEYID="$(credhub g -n $object --versions 2 --output-json | jq -r .versions[1].id)"

  NEWKEY="$(credhub r -n $object --output-json | jq -r .value.private_key)"
  NEWKEYID="$(credhub g -n $object --output-json | jq -r .id)"

  credhub s -t json -n "${object}_object" -v "{\"object\":{\"active-key\":{\"signingKey\":\"${NEWKEY}\"}}}" > /dev/null

  printf "Rotating ${object}\n  Removed Value: ${OLDKEYID}\n  New Value: ${NEWKEYID}\n\n"

done

