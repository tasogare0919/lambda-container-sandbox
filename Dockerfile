FROM google/cloud-sdk:alpine

COPY s3-gcs-copy.sh s3-gcs-copy.sh
RUN chmod +x s3-gcs-copy.sh

ENTRYPOINT ["./s3-gcs-copy.sh"]