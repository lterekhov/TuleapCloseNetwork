#!/bin/bash

CONTAINER_NAME=${1}

#|command               |:path to file in container                |./path to file system                   |                              
#nginx
mkdir -p ./logs/nginx
docker cp $CONTAINER_NAME:/var/log/nginx/access.log                 ./logs/nginx/access.log
docker cp $CONTAINER_NAME:/var/log/nginx/error.log                  ./logs/nginx/error.log

#php-fpm
mkdir -p ./logs/phpfpm
docker cp $CONTAINER_NAME:/var/opt/remi/php73/log/php-fpm/error.log ./logs/phpfpm/error.log

#apache
mkdir -p ./logs/apache
docker cp $CONTAINER_NAME:/var/log/httpd/access_log                 ./logs/apache/access_log
docker cp $CONTAINER_NAME:/var/log/httpd/error_log                  ./logs/apache/error_log

#tuleap
mkdir -p ./logs/tuleap
docker cp $CONTAINER_NAME:/var/log/tuleap/codendi_syslog            ./logs/tuleap/codendi_syslog
docker cp $CONTAINER_NAME:/var/log/tuleap/cvslog                    ./logs/tuleap/cvslog
docker cp $CONTAINER_NAME:/var/log/tuleap/ldap_syslog               ./logs/tuleap/ldap_syslog
docker cp $CONTAINER_NAME:/var/log/tuleap/git_syslog                ./logs/tuleap/git_syslog
docker cp $CONTAINER_NAME:/var/log/tuleap/git_http_error_log        ./logs/tuleap/git_http_error_log
docker cp $CONTAINER_NAME:/var/log/tuleap/rest_api_log              ./logs/tuleap/rest_api_log
docker cp $CONTAINER_NAME:/var/log/tuleap/burndown_syslog           ./logs/tuleap/burndown_syslog
docker cp $CONTAINER_NAME:/var/log/tuleap/burnup_syslog             ./logs/tuleap/burnup_syslog
docker cp $CONTAINER_NAME:/var/log/tuleap/project_xml_import_syslog ./logs/tuleap/project_xml_import_syslog
docker cp $CONTAINER_NAME:/var/log/tuleap/statistics_syslog         ./logs/tuleap/statistics_syslog
docker cp $CONTAINER_NAME:/var/log/tuleap/tv3_tv5_migration_syslog  ./logs/tuleap/tv3_tv5_migration_syslog
docker cp $CONTAINER_NAME:/var/log/tuleap/archive_deleted_item.log  ./logs/tuleap/archive_deleted_item.log
docker cp $CONTAINER_NAME:/var/log/tuleap/botMattermost_syslog      ./logs/tuleap/botMattermost_syslog
docker cp $CONTAINER_NAME:/var/log/tuleap/worker_log                ./logs/tuleap/worker_log
docker cp $CONTAINER_NAME:/var/log/tuleap/openid_connect_client.log ./logs/tuleap/openid_connect_client.log
docker cp $CONTAINER_NAME:/var/log/tuleap/mail_syslog               ./logs/tuleap/mail_syslog



