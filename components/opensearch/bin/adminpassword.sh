#! /bin/bash

set -e

echo "Generating password hash..."

if [ -z "$OPENSEARCH_INITIAL_ADMIN_PASSWORD" ]; then

  echo "ERROR: OPENSEARCH_INITIAL_ADMIN_PASSWORD environment is not set!"
  exit 1

fi

PASSWORD_HASH=$(/usr/share/opensearch/plugins/opensearch-security/tools/hash.sh -p "$OPENSEARCH_INITIAL_ADMIN_PASSWORD")
PASSWORD_HASH=$(echo "$PASSWORD_HASH" | grep -v '\*')

if [ -z "$PASSWORD_HASH" ]; then
  echo "ERROR: failed to generate password hash!"
  exit 1
fi

USERFILE="/usr/share/opensearch/config/opensearch-security/internal_users.yml"

cat << EOF > $USERFILE
_meta:
  type: "internalusers"
  config_version: 2

# Define your internal users here

## PocketSOC users

admin:
  hash: "$PASSWORD_HASH"
  reserved: true
  backend_roles:
  - "admin"
  description: "PocketSOC-NG admin user"

kibanaserver:
  hash: "$PASSWORD_HASH"
  reserved: true
  backend_roles:
  - "admin"
  description: "PocketSOC-NG OpenSearch Dashboards user"
EOF
