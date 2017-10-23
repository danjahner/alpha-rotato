#!/bin/bash

set -e

credhub l 

TOKEN="$(credhub --token)"
echo "$CREDHUB_CA_CERT" > ca.pem

echo $CAS_TO_ROTATE | jq -r .[] | while read object; do
  #Existing Value
  OLDCAID="$(credhub g -n $object --output-json | jq -r .id)"

  #Generate New Value and Assign ID
  credhub regenerate --name $object > /dev/null
  NEWCAID="$(credhub g -n $object --output-json | jq -r .id)"

  #Hackily set the value to include the prior certificate for gradual rotation
  OLDCA="$(credhub g --id $OLDCAID --output-json | jq -r .value.certificate)"
  NEWCA="$(credhub g --id $NEWCAID --output-json | jq -r .value.certificate)"
  credhub set --type certificate --name $object --certificate "${NEWCA}\n${OLDCA}" --private "$(credhub g --id $NEWCAID --output-json | jq -r .value.private_key)" > /dev/null

  STACKEDID="$(credhub g -n $object --output-json | jq -r .id)"
  
  printf "Rotating ${object}\n  Existing Value: ${OLDCAID}\n  New Value: ${NEWCAID}\n  Stacked Value: ${STACKEDID}\n\n"
 
done

