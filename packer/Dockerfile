FROM ansible:2.8.11

ARG APP_VERSION
RUN apk --no-cache add \
    unzip \
    && wget https://releases.hashicorp.com/packer/${APP_VERSION}/packer_${APP_VERSION}_linux_amd64.zip -O /tmp/packer.zip && \ 
    mkdir -p /opt/ && \
    cd /opt/ && /usr/bin/unzip /tmp/packer.zip  && \ 
    ln -s /opt/packer /usr/bin/packer && rm /tmp/packer.zip

