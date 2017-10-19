#!/bin/bash

set -e

wget https://s3.amazonaws.com/credhub-cli-tarballs/credhub-linux-1.5.0-beta.46.tgz
tar xvf credhub-linux-1.5.0-beta.46.tgz

./credhub l 

echo $KEYS_TO_ROTATE | jq -r .[] | while read object; do
  OLDKEYID="$(./credhub g -n $object --versions 2 --output-json | jq -r .versions[1].id)"

  NEWKEYNAME="$(credhub g -n ${object}_name --output-json | jq -r .value)"
  NEWKEY="$(./credhub g -n $object --output-json | jq -r .value)"
  NEWKEYID="$(./credhub g -n $object --output-json | jq -r .id)"

  ./credhub s -t json -n "${object}_object" -v "{\"list\":[{\"label\":\"${NEWKEYNAME}\",\"passphrase\":\"${NEWKEY}\"}]}" > /dev/null

  printf "Rotating ${object}\n  Removed Value: ${OLDKEYID}\n  New Value: ${NEWKEYID}\n\n"

done

