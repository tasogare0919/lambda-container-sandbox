#!/bin/bash

echo $GCLOUD_SERVICE_KEY | base64 -d > key.json

gcloud auth activate-service-account --key-file=key.json

gsutil -m rsync -r s3://$S3_BUCKET gs://$GCS_BUCKET