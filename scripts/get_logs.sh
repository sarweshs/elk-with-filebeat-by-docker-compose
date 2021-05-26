#!/bin/sh

accountId=$1
groupId=$2
serviceId=$3
connectionId=$4
startDate=$5
endDate=$6

# clean the /mylog dir to make space for new log files
printf "\nCleaning the mylog/ dir to make space for new log files\n"
rm -rfv mylog/*

printf "\nCleaning Filebeat Registry dir to make space for new log files\n"
rm -rfv registry/*

# include the endDate in the query
endDate=$(date -j -v +1d -f "%Y-%m-%d" "$endDate" +%Y-%m-%d)
d="$startDate"
# loop over the date range
while [ "$d" != "$endDate" ]; do
    # download log files for each date
    ./scripts/copy_files_to_machine.sh $accountId $groupId $serviceId $connectionId $d

    d=$(date -j -v +1d -f "%Y-%m-%d" "$d" +%Y-%m-%d)
done
