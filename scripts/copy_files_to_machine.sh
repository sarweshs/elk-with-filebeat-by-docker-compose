#!/bin/sh

accountId=$1
groupId=$2
serviceId=$3
connectionId=$4
dt=$5

printf "\nDownloading logs files for $accountId/$groupId/$serviceId/$connectionId for date $dt:\n"
gsutil -m cp -r gs://test-intermediate-store/connector/accountId=$accountId/groupId=$groupId/serviceId=$serviceId/connectionId=$connectionId/dt=$dt/* ~/fivetran/hackathon-2021/elk-with-filebeat/mylog
#gsutil -m cp -r gs://fluent-bit-logs/fivetran/donkey.default/connector/accountId=$accountId/groupId=$groupId/serviceId=$serviceId/connectionId=$connectionId/dt=$dt/* ~/elk-with-filebeat/mylog