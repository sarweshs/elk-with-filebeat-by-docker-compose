#!/bin/sh

repo_path=$1

echo "Starting the stack...."
docker-compose -f $repo_path/docker-compose.yml up -d

while [[ "$response" != *'"key":"logstash'* ]]
do
   response="$(curl -sX POST "http://localhost:9200/*/_search?ignore_unavailable=true" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '{"size":0,"aggs":{"indices":{"terms":{"field":"_index","size":200}}}}')"
   echo "Waiting...."
   sleep 30
done

echo "Processing the logs...."
sleep 30

echo "Creating Index....."

data="$(curl -sX POST "http://localhost:5601/api/saved_objects/index-pattern/logstash" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
  "attributes": {
    "title": "logstash-*",
    "timeFieldName": "time"
  }
}
')"

echo "Index Created....."

echo "Opening Browser....."

#open http://localhost:5601/app/kibana#/discover
open http://localhost:5601/app/discover#/?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15y,to:now))&_a=(columns:!(),filters:!(),index:logstash,interval:auto,query:(language:kuery,query:''),sort:!(!(time,desc)))