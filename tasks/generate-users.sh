#!/bin/bash

set -x -e

credhub l 

echo $USERS_TO_GENERATE | jq -r .[] | while read object; do
  # Namespace with director and deployment name if no leading slash
  if [ ! "$(echo $object | head -c 1)" == "/" ] 
    object="/${BOSH_NAME}/${BOSH_DEPLOYMENT}/${object}"
  fi 

  credhub generate --name $object --type user > /dev/null
done

