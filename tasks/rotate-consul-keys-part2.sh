#!/bin/bash

set -e

credhub l 

echo $KEYS_TO_ROTATE | jq -r .[] | while read object; do
  OLDKEYID="$(credhub g -n $object --versions 2 --output-json | jq -r .versions[1].id)"

  NEWKEY="$(credhub g -n $object --output-json | jq -r .value)"
  NEWKEYID="$(credhub g -n $object --output-json | jq -r .id)"

  credhub s -t json -n "${object}_list" -v "{\"list\":[\"${NEWKEY}\"]}" > /dev/null

  printf "Rotating ${object}\n   New Value: ${NEWKEYID}\n   Removed Value: ${OLDKEYID}\n\n"

done

