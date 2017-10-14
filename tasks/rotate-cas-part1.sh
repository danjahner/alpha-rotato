#!/bin/bash

set -x -e

credhub l 

TOKEN="$(credhub --token)"
echo "$CREDHUB_CA_CERT" > ca.pem

echo $CAS_TO_ROTATE | jq -r .[] | while read object; do
  credhub regenerate --name $object > /dev/null
  #Hackily set the value to include the prior certificate for gradual rotation
  credhub set --type certificate --name $object --certificate "$(credhub g -n $object --versions 2 --output-json | jq -r .versions[0].value.certificate & credhub g -n $object --versions 2 --output-json | jq -r .versions[1].value.certificate)" --private "$(credhub g -n $object --output-json | jq -r .value.private_key)"
done
