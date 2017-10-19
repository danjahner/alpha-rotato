#!/bin/bash

set -e

credhub l 

echo $KEYS_TO_ROTATE | jq -r .[] | while read object; do
  OLDKEY="$(credhub g -n $object --output-json | jq .value.private_key)"
  OLDKEYID="$(credhub g -n $object --output-json | jq -r .id)"

  NEWKEY="$(credhub r -n $object --output-json | jq .value.private_key)"
  NEWKEYID="$(credhub g -n $object --output-json | jq -r .id)"
 
  JSON="$(cat <<EOF
{
  "active-key": {"signingKey":${NEWKEY}},
  "inactive-key": {"signingKey":${OLDKEY}}
}
EOF)"

  credhub s -t json -n "${object}_object" -v "${JSON}" > /dev/null

  printf "Rotating ${object}\n  Existing Value: ${OLDKEYID}\n  New Value: ${NEWKEYID}\n\n"

done

