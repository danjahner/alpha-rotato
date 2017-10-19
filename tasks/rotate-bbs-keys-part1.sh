#!/bin/bash

set -e

credhub l 

echo $KEYS_TO_ROTATE | jq -r .[] | while read object; do
  #BBS stores the label of the encryption key, so we cannot just move the old key from label 'active-key' to 'inactive-key'
  #We must set the active key name in a variable and track it in the rotation
  OLDKEYNAME="$(credhub g -n ${object}_name --output-json | jq -r .value)"
  OLDKEY="$(credhub g -n $object --output-json | jq -r .value)"
  OLDKEYID="$(credhub g -n $object --output-json | jq -r .id)"

  NEWKEYNAME="$(credhub r -n ${object}_name --output-json | jq -r .value)"
  NEWKEY="$(credhub r -n $object --output-json | jq -r .value)"
  NEWKEYID="$(credhub g -n $object --output-json | jq -r .id)"

  JSON="$(cat <<EOF
{
  "list": [
    {
      "label": "${OLDKEYNAME}",
      "passphrase": "${OLDKEY}"
    },
    {
      "label": "${NEWKEYNAME}",
      "passphrase": "${NEWKEY}"
    }]
}
EOF
)"

  credhub s -t json -n "${object}_object" -v "${JSON}" > /dev/null

  printf "Rotating ${object}\n  Existing Value: ${OLDKEYID}\n  New Value: ${NEWKEYID}\n\n"

done

