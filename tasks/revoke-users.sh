#!/bin/bash

set -e

echo $USERS_TO_REVOKE_PRIOR | jq -r .[] | while read object; do
  user="$(credhub g -n $object --versions 2 --output-json | jq -r .versions[1].value.username)"
  mysql -h ${MYSQL_HOST} -u ${MYSQL_USERNAME} -p ${MYSQL_PASSWORD} -e "DROP USER IF EXISTS ${user};"

  printf "Revoked access for user ${user}\n"
done

