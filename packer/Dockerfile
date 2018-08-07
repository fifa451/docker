FROM alpine

ARG PACKER_VERSION=1.2.4
ENV PACKER_VERSION ${PACKER_VERSION}
RUN apk --no-cache add \
    unzip \
    && wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /tmp/packer.zip && \ 
    mkdir -p /opt/ && \
    cd /opt/ && /usr/bin/unzip /tmp/packer.zip  && \ 
    ln -s /opt/packer /usr/bin/packer && rm /tmp/packer.zip \
    &&apk del\
    unzip \

