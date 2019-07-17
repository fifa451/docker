FROM alpine

ARG TERRAFORM_VERSION=0.11.7
ARG TERRAFORM_DOCS_VERSION=0.6.0
ARG USERNAME=fifa451
ARG USERID=1000
ARG GROUPID=1000
ENV TERRAFORM_VERSION ${TERRAFORM_VERSION}
ENV TERRAFORM_DOCS_VERSION ${TERRAFORM_DOCS_VERSION}
ENV USERNAME ${USERNAME}
ENV USERID ${USERID}
ENV GROUPID ${GROUPID}
RUN apk add --no-cache \
    unzip \
    ca-certificates \
    zip \
    git \
    openssh-client && \ 
    mkdir -p /opt/ && \ 
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip && \
    wget https://github.com/segmentio/terraform-docs/releases/download/v${TERRAFORM_DOCS_VERSION}/terraform-docs-v${TERRAFORM_DOCS_VERSION}-linux-amd64 -O /opt/terraform-docs && \
    cd /opt/ && \
    /usr/bin/unzip /tmp/terraform.zip  && \
    ln -s /opt/terraform /usr/bin/terraform && \
    ln -s /opt/terraform-docs /usr/bin/terraform-docs && \
    chmod +x  /opt/terraform /opt/terraform-docs && \
    rm /tmp/terraform.zip \
    &&addgroup -g ${GROUPID} ${USERNAME} && adduser -D -G ${USERNAME} -u ${USERID} -h /home/${USERNAME} ${USERNAME} && mkdir -p /home/${USERNAME}/work_dir&& chown ${USERNAME}:${USERNAME} -R /home/${USERNAME}/work_dir
# &&apk del \
