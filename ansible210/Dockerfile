FROM python:3.8-alpine AS base

ARG APP_VERSION
ARG USERNAME=ansible
ARG GROUPID=1000
ARG USERID=1000
ARG APP_NAME=ansible

ENV VIRTUAL_ENV=/opt/${APP_NAME}
ENV PATH="$VIRTUAL_ENV/bin:$PATH"


RUN apk --no-cache add \
    curl \
    libffi \
    libffi-dev\
    openssl-dev \
    openssh-client\
    py3-virtualenv \
    git \
    alpine-sdk \
    && python3 -m venv $VIRTUAL_ENV \
    && curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 - \
    && . ~/.poetry/env

COPY pyproject.toml poetry.lock ./

RUN . ~/.poetry/env && poetry install


FROM python:3.8-alpine

LABEL VERSION="ansible-2.10.7"

ARG APP_VERSION
ARG USERNAME=ansible
ARG GROUPID=1000
ARG USERID=1000
ARG APP_NAME=ansible

ENV VIRTUAL_ENV=/opt/${APP_NAME}
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# install some required pacakges
RUN apk add \
    openssl-dev \
    openssh-client\
    git \
    curl \
    && mkdir -p /app \
    && addgroup -g ${GROUPID} ${USERNAME} \
    && adduser -D -G ${USERNAME} -u ${USERID} -h /home/${USERNAME} ${USERNAME} \
    && mkdir -p /app && chown ${USERNAME}:${USERNAME} -R /app
# install some tools copy some
COPY --from=base /opt/ansible /opt/ansible
COPY --from=quay.io/helmpack/chart-testing:latest /usr/local/bin/kubectl /usr/local/bin/helm /usr/local/bin/
WORKDIR /app
CMD [ "sleep","infinitly" ]