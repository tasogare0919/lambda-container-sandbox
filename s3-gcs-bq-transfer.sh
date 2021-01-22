#!/bin/bash
export AWS_DEFAULT_REGION=ap-northeast-1
export SNAPSHOT_NAME_BEFORE=`aws rds describe-db-cluster-snapshots --snapshot-type automated --query 'DBClusterSnapshots[0].DBClusterSnapshotIdentifier' --output text`
export SNAPSHOT_NAME=`echo ${SNAPSHOT_NAME_BEFORE} | cut -c 5-`

echo $GCLOUD_SERVICE_KEY | base64 -d > key.json
gcloud auth activate-service-account --key-file=key.json

# S3 -> GCS 転送
gsutil -m rsync -r s3://$S3_BUCKET/$SNAPSHOT_NAME/xxx gs://$GCS_BUCKET

# GCS -> BQ の読み込み
#fitmealprod_acess_logs
bq load \
--replace=true \
--source_format=PARQUET \
xxx.xxx \
"gs://$GCS_BUCKET/xxxx/*"         