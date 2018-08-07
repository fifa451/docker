FROM python:3.6

ARG AWSCLI_VERSION="1.15.36"
ENV AWSCLI_VERSION $AWSCLI_VERSION

RUN apk --no-cache add \
	git \
	unzip \
	openssh-client \
	&&pip install --no-cache-dir \
	botocore>=1.10.45 \
	awscli==${AWSCLI_VERSION}\
	boto \
	boto3 \
	&&apk del 
	unzip \
