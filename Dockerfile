FROM ubuntu:18.04

RUN apt-get update && apt-get install curl python3.7 python-pip wget gnupg -y
RUN pip install --upgrade pip
RUN yes|pip install awscli

RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
RUN echo $CLOUD_SDK_REPO
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y
RUN yes no|gcloud init

COPY s3-gcs-bq-transfer.sh s3-gcs-bq-transfer.sh
RUN chmod +x s3-gcs-bq-transfer.sh
ENTRYPOINT ["./s3-gcs-bq-transfer.sh"]