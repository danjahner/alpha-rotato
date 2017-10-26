#!/bin/bash

set -e

credhub l 

echo $KEYS_TO_ROTATE | jq -r .[] | while read object; do
  # Namespace with director and deployment name if no leading slash
  if [ ! "$(echo $object | head -c 1)" == "/" ]
    object="/${BOSH_NAME}/${BOSH_DEPLOYMENT}/${object}"
  fi

  OLDKEYID="$(credhub g -n $object --versions 2 --output-json | jq -r .versions[1].id)"

  NEWKEY="$(credhub g -n $object --output-json | jq .value.private_key)"
  NEWKEYID="$(credhub g -n $object --output-json | jq -r .id)"

  JSON="$(cat <<EOF
{
  "active-key": {"signingKey":${NEWKEY}}
}
EOF
)"

  credhub s -t json -n "${object}_object" -v "$JSON" > /dev/null

  printf "Rotating ${object}\n  Removed Value: ${OLDKEYID}\n  New Value: ${NEWKEYID}\n\n"

done

