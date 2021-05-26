#!/bin/sh
echo "Downloading Logs......"
accountId=$1
groupId=$2
serviceId=$3
connectionId=$4
startDate=$5
endDate=$6

./scripts/get_logs.sh $accountId $groupId $serviceId $connectionId $startDate $endDate
echo "Logs Downloaded...."