#!/bin/sh

account_id=$1
group_id=$2
service_id=$3
connection_id=$4
dt=$5
repo_path=$6

printf "\nDownloading logs files for $account_id/$group_id/$service_id/$connection_id for date $dt:\n"
gsutil -m cp -r gs://test-intermediate-store/connector/accountId=$account_id/groupId=$group_id/serviceId=$service_id/connectionId=$connection_id/dt=$dt/* $repo_path/mylog
#gsutil -m cp -r gs://fluent-bit-logs/fivetran/donkey.default/connector/accountId=$account_id/groupId=$group_id/serviceId=$service_id/connectionId=$connection_id/dt=$dt/* $repo_path/mylog