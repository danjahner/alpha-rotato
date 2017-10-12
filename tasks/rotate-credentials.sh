#!/bin/bash

set -x -e

credhub l 

echo $CREDS_TO_ROTATE | jq -r .[] | while read object; do
  credhub regenerate --name $object > /dev/null
done

