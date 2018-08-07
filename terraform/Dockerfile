FROM alpine

ARG TERRAFORM_VERSION=0.11.7
ENV TERRAFORM_VERSION ${TERRAFORM_VERSION}
RUN apk add --no-cache \
    unzip \ 
    &&wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip && \ 
    mkdir -p /opt/ && \
    cd /opt/ && /usr/bin/unzip /tmp/terraform.zip  && \ 
    ln -s /opt/terraform /usr/bin/terraform && \
    chmod +x  /opt/terraform && \
    rm /tmp/terraform.zip \
    &&apk del \
    unzip \
    &&addgroup -g 1000 rchen && adduser -D -G rchen -u 1000 -h /home/rchen rchen && mkdir -p /home/rchen/work_dir&& chown rchen:rchen -R /home/rchen/work_dir
