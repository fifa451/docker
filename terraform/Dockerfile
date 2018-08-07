FROM alpine

ARG TERRAFORM_VERSION=0.11.7
ARG USERNAME=fifa451
ARG USERID=1000
ARG GROUPID=1000
ENV TERRAFORM_VERSION ${TERRAFORM_VERSION}
ENV USERNAME ${USERNAME}
ENV USERID ${USERID}
ENV GROUPID ${GROUPID}
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
    &&addgroup -g ${GROUPID} ${USERNAME} && adduser -D -G ${USERNAME} -u ${USERID} -h /home/${USERNAME} ${USERNAME} && mkdir -p /home/${USERNAME}/work_dir&& chown ${USERNAME}:${USERNAME} -R /home/${USERNAME}/work_dir
