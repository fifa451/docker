FROM python:3.7-alpine

ARG APP_VERSION
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID

ENV VIRTUAL_ENV=/opt/${APP_NAME}
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apk --no-cache add \
    groff \
    py3-virtualenv \
    libffi \
    libffi-dev\
    openssl-dev \
    freetds-dev \
    alpine-sdk \
    openssh-client\
    git \
    && addgroup -g ${GROUPID} ${USERNAME} \
    && adduser -D -G ${USERNAME} -u ${USERID} -h /home/${USERNAME} ${USERNAME} \
    && mkdir -p /app && chown ${USERNAME}:${USERNAME} -R /app \
    && python -m venv $VIRTUAL_ENV
RUN \
    pip --no-cache-dir install \
    pycrypto \
    cython \
    ansible-modules-hashivault \
    wheel \
    molecule \
    docker \
    XenAPI \
    jinja2 \
    PyYAML \
    cryptography \
    botocore \
    boto \
    boto3 \
    redis \
    pywinrm>=0.3.0 \ 
    ansible-runner \
    ${APP_NAME}==${APP_VERSION}
RUN \
    pip --no-cache-dir install \
    pymssql==2.1.4
COPY --from=packer:latest /opt/packer /usr/local/bin/packer
