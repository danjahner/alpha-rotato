#!/bin/bash

set -x -e

credhub l 

echo $USERS_TO_GENERATE | jq -r .[] | while read object; do
  credhub generate --name $object --type user > /dev/null
done

