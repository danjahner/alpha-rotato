#!/bin/bash

set -x -e

credhub l 

echo $CREDS_TO_ROTATE | jq -r .[] | while read object; do
  # Namespace with director and deployment name if no leading slash
  if [ ! "$(echo $object | head -c 1)" == "/" ]
    object="/${BOSH_NAME}/${BOSH_DEPLOYMENT}/${object}"
  fi

  credhub regenerate --name $object > /dev/null
done

