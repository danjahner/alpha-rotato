#!/bin/bash

set -e

credhub l 

TOKEN="$(credhub --token)"
echo "$CREDHUB_CA_CERT" > ca.pem

echo $CAS_TO_ROTATE | jq -r .[] | while read object; do
  #Latest Value
  STACKEDID="$(credhub g -n $object --output-json | jq -r .id)"

  #Value of New CA is the previous value, before the stacked version
  NEWCAID="$(credhub g -n $object --versions 2 --output-json | jq -r .versions[1].id)" 

  #Hackily unset the value to remove the prior certificate
  credhub set --type certificate --name $object --certificate "$(credhub g --id $NEWCAID --output-json | jq -r .value.certificate)" --private "$(credhub g --id $NEWCAID --output-json | jq -r .value.private_key)" > /dev/null

  printf "Removing old CA for ${object}\n  Stacked Value: ${STACKEDID}\n  New Value: ${NEWCAID}\n\n"

done

