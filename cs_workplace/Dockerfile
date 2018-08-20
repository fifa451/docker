FROM python:2.7
ARG AWSCLI_VERSION="1.15.36"
ARG PACKER_VERSION=1.2.4
ARG TERRAFORM_VERSION=0.11.7
ARG USERNAME=fifa451
ARG USERID=1000
ARG GROUPID=1000
ARG ANSIBLE_VERSION=2.6.2
ENV AWSCLI_VERSION $AWSCLI_VERSION
ENV PACKER_VERSION ${PACKER_VERSION}
ENV TERRAFORM_VERSION ${TERRAFORM_VERSION}
ENV USERNAME ${USERNAME}
ENV USERID ${USERID}
ENV GROUPID ${GROUPID}
ENV ANSIBLE_VERSION ${ANSIBLE_VERSION}
RUN apk --no-cache add \
	git \
	unzip \
	openssh-client \
    unzip \
    unzip \
    libffi \
    libffi-dev\
    openssl-dev \
    freetds-dev \
    alpine-sdk \
    # fix the pymssql # https://github.com/pymssql/pymssql/issues/520#issuecomment-352883344
	&&pip install --no-cache-dir \
	botocore>=1.10.45 \
	awscli==${AWSCLI_VERSION}\
	boto \
	boto3 \
    && wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O /tmp/packer.zip && \ 
    mkdir -p /opt/ && \
    cd /opt/ && /usr/bin/unzip /tmp/packer.zip  && \ 
    ln -s /opt/packer /usr/bin/packer && rm /tmp/packer.zip \
    &&wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform.zip && \
    mkdir -p /opt/ && \
    cd /opt/ && /usr/bin/unzip /tmp/terraform.zip  && \
    ln -s /opt/terraform /usr/bin/terraform && \
    chmod +x  /opt/terraform && \
    rm /tmp/terraform.zip \
    &&echo "#define DBVERSION_80 DBVERSION_71" >> /usr/include/sybdb.h && \
    pip --no-cache-dir install \
    ansible==${ANSIBLE_VERSION} \
    ansible-modules-hashivault \
    pycrypto \
    pymssql \
   &&apk del \
	unzip \
    unzip \
    unzip \
    alpine-sdk libffi libffi-dev freetds \

&&addgroup -g 500 ec2-user && adduser -D -G ec2-user -u 500 -h /home/ec2-user ec2-user && mkdir -p /home/ec2-user/work_dir&& chown ec2-user:ec2-user -R /home/ec2-user/work_dir
