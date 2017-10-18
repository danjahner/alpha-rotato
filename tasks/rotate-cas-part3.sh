#!/bin/bash

set -e

credhub l 

TOKEN="$(credhub --token)"
echo "$CREDHUB_CA_CERT" > ca.pem

wget https://s3.amazonaws.com/credhub-cli-tarballs/credhub-linux-1.5.0-beta.46.tgz
tar xvf credhub-linux-1.5.0-beta.46.tgz

echo $CAS_TO_ROTATE | jq -r .[] | while read object; do
  #Value of New CA is the previous value, before the stacked version
  NEWCAID="$(./credhub g -n $object --versions 2 --output-json | jq -r .versions[1].id)" 

  #Hackily unset the value to remove the prior certificate
  ./credhub set --type certificate --name $object --certificate "$(./credhub g --id $NEWCAID --output-json | jq -r .value.certificate)" --private "$(./credhub g --id $NEWCAID --output-json | jq -r .value.private_key)" 

  echo "Setting CA to new value: ${NEWCAID}\n"
done

