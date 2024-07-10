#!/bin/bash

echo "OPENSEARCH_INITIAL_ADMIN_PASSWORD: $OPENSEARCH_INITIAL_ADMIN_PASSWORD"


/usr/share/opensearch/opensearch-docker-entrypoint.sh &

until curl -s -f http://localhost:9200 >/dev/null; do
    sleep 5
done

/usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh \
    -cd /usr/share/opensearch/config/opensearch-security \
    -icl -nhnv \
    -cacert /usr/share/opensearch/config/root-ca.pem \
    -cert /usr/share/opensearch/config/kirk.pem \
    -key /usr/share/opensearch/config/kirk-key.pem

wait

