#!/usr/bin/env bash

set -eo pipefail

# Create mount directory for service
mkdir -p $MNT_DIR

echo "Mounting GCS Fuse."
gcsfuse --debug_gcs --debug_fuse $BUCKET $MNT_DIR 
echo "Mounting completed. $MNT_DIR is mounted on $BUCKET."


./meilisearch --db-path "$MNT_DIR/db/" --dumps-dir "$MNT_DIR/dumps/" --snapshot-dir "$MNT_DIR/snapshots/" --http-addr '0.0.0.0:7700'

# Exit immediately when one of the background processes terminate.
# wait -n
# [END cloudrun_fuse_script]