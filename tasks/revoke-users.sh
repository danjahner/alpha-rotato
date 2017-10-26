#!/bin/bash

set -e

CREDHUB_SERVER="${BOSH_ENVIRONMENT}:8844"
CREDHUB_CLIENT="$BOSH_CLIENT"
CREDHUB_SECRET="$BOSH_CLIENT_SECRET"
CREDHUB_CA_CERT="$BOSH_CA_CERT"
echo "$BOSH_JUMPBOX_SSH_KEY" > jump.pem
chmod 400 jump.pem

credhub l
mysqladmin="$(credhub g -n ${MYSQL_PASSWORD_REF} --output-json | jq -r .value)"

echo $USERS_TO_REVOKE_PRIOR | jq -r .[] | while read object; do
  # MySQL is not exposed publically, so we need to use BOSH SSH to send the mysql command
  user="$(credhub g -n $object --versions 2 --output-json | jq -r .versions[1].value.username)"

  bosh ssh mysql/0 --gw-private-key jump.pem -c "mysql -u${MYSQL_USERNAME} -p${mysqladmin} -e\"DROP USER IF EXISTS ${user}\"";

  printf "Revoked access for user ${user}\n"
done

