#FROM python:3.6
FROM python:2.7

ARG ANSIBLE_VERSION=2.6.2
ENV ANSIBLE_VERSION ${ANSIBLE_VERSION}
RUN apk --no-cache add \
    libffi \
    libffi-dev\
    openssl-dev \
    freetds-dev \
    alpine-sdk \
    # fix the pymssql # https://github.com/pymssql/pymssql/issues/520#issuecomment-352883344
    &&echo "#define DBVERSION_80 DBVERSION_71" >> /usr/include/sybdb.h && \
    pip --no-cache-dir install \
    ansible==${ANSIBLE_VERSION} \
    ansible-modules-hashivault \
    pycrypto \
    pymssql \
    &&apk del \
    alpine-sdk libffi libffi-dev freetds \
