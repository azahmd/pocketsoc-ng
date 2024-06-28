FROM opensearchproject/opensearch:latest

COPY ./config/internal_users.yml /usr/share/opensearch/config/opensearch-security/

COPY ./config/roles.yml /usr/share/opensearch/config/opensearch-security/

COPY ./config/roles_mapping.yml /usr/share/opensearch/config/opensearch-security/

COPY ./config/securityadmin_demo.sh /usr/share/opensearch/config/securityadmin_demo.sh

USER root
RUN chmod +x /usr/share/opensearch/config/securityadmin_demo.sh

USER opensearch
