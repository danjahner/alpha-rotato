#!/bin/bash

set -e

echo "$BOSH_JUMPBOX_SSH_KEY" > jump.pem
chmod 400 jump.pem

echo $USERS_TO_REVOKE_PRIOR | jq -r .[] | while read object; do
  # MySQL is not exposed publically, so we need to use BOSH SSH to send the mysql command
  user="$(credhub g -n $object --versions 2 --output-json | jq -r .versions[1].value.username)"

  bosh ssh mysql/0 --gw-private-key jump.pem -c "mysql -h${MYSQL_HOST} -u${MYSQL_USERNAME} -p${MYSQL_PASSWORD} -e\"DROP USER IF EXISTS ${user}\"";

  printf "Revoked access for user ${user}\n"
done

