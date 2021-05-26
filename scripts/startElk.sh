#!/bin/sh
echo "Starting the stack...."
docker-compose -f ~/fivetran/hackathon-2021/elk-with-filebeat/docker-compose.yml up -d

while [[ "$response" != *'"key":"logstash'* ]]
do
   response="$(curl -X POST "http://localhost:9200/*/_search?ignore_unavailable=true" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d '{"size":0,"aggs":{"indices":{"terms":{"field":"_index","size":200}}}}')"
   echo "Wating...."
   sleep 30
done

echo "Processing the logs...."
sleep 30

echo "Creating Index....."

data="$(curl -X POST "http://localhost:5601/api/saved_objects/index-pattern/logstash" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'
{
  "attributes": {
    "title": "logstash-*",
    "timeFieldName": "time"
  }
}
')"

echo "Index Created....."

echo "Opening Browser....."

open http://localhost:5601/app/kibana#/discover
