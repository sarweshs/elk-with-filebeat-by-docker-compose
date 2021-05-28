#!/bin/sh

account_id=$1
group_id=$2
service_id=$3
connection_id=$4
start_date=$5
end_date=$6
repo_path=$7
env=$8

# clean or create the /mylog dir
if [ -d "$repo_path/mylog" ]; then
  printf "\nCleaning the mylog/ dir to make space for new log files...\n"
  rm -rfv $repo_path/mylog/*
else
  mkdir $repo_path/mylog
fi

printf "\nCleaning Filebeat Registry dir to make space for new log files...\n"
rm -rfv registry/*

# include the end_date in the query
end_date=$(date -j -v +1d -f "%Y-%m-%d" "$end_date" +%Y-%m-%d)
d="$start_date"
# loop over the date range
while [ "$d" != "$end_date" ]; do
    # download log files for each date
    ./scripts/copy_files_to_machine.sh $account_id $group_id $service_id $connection_id $d $repo_path $env

    d=$(date -j -v +1d -f "%Y-%m-%d" "$d" +%Y-%m-%d)
done
