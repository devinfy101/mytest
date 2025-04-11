#!/bin/bash

TOPIC_FILE="topic-definitions.yaml"

# Check for yq
command -v yq >/dev/null || { echo "yq is required to parse YAML"; exit 1; }

# Loop through topics
yq e '.topics[]' "$TOPIC_FILE" | yq -e '.topics[] | [.name, .partitions, .replicationFactor] | @tsv' "$TOPIC_FILE" | while IFS=$'\t' read -r NAME PARTITIONS REPLICAS; do
  echo "Creating topic: $NAME"
  /etc/confluent-7.8.0/bin/kafka-topics --create --bootstrap-server localhost:9092 \
    --replication-factor "$REPLICAS" \
    --partitions "$PARTITIONS" \
    --topic "$NAME"
done
