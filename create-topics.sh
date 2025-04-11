#!/bin/bash

TOPIC_FILE="topic-definitions.yaml"

if ! command -v yq &> /dev/null; then
  echo "yq is required to parse YAML"
  exit 1
fi

TOPICS=$(yq e '.topics[]' $TOPIC_FILE)

for row in $(yq e '.topics | length' $TOPIC_FILE); do
  NAME=$(yq e ".topics[$row].name" $TOPIC_FILE)
  PARTITIONS=$(yq e ".topics[$row].partitions" $TOPIC_FILE)
  REPLICAS=$(yq e ".topics[$row].replicationFactor" $TOPIC_FILE)

  echo "Creating topic: $NAME"
  cd /etc/confluent-7.8.0/
  kafka-topics --create --bootstrap-server localhost:9092 \
    --replication-factor $REPLICAS \
    --partitions $PARTITIONS \
    --topic $NAME
done

