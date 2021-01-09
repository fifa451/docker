FROM ubuntu:18.04

ARG APP_VERSION
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID
ARG APP_URL

ENV APP_VERSION ${APP_VERSION}
ENV USERNAME ${USERNAME}
ENV USERID ${USERID}
ENV GROUPID ${GROUPID}
ENV APP_NAME ${APP_NAME}
# ENV JIRA_API_TOKEN ""

## install required packages
RUN apt-get update -y
RUN apt-get install wget ca-certificates --no-install-recommends -y
RUN apt-get install libgtk-3-0  --no-install-recommends -y
RUN apt-get install libx11-xcb1 libasound2 libcanberra-gtk3-module libxkbfile1 --no-install-recommends -y


RUN [ -d /opt ] || mkdir /opt

## Get App
RUN wget $APP_URL -O /tmp/${APP_NAME}.deb


## Add Run User
RUN addgroup --gid ${GROUPID} ${USERNAME} && adduser --gecos --quiet --disabled-password --ingroup ${USERNAME} -uid ${USERID} ${USERNAME}

## Create app work dir for volumen map
RUN mkdir -p /app && chown ${USERNAME}:${USERNAME} -R /app

## Grant app execution permission
RUN apt-get install --no-install-recommends /tmp/${APP_NAME}.deb -y

## Cleanup

RUN apt-get clean -y

# # ## Add entrypoint and make sure entry point is executeble
#ADD entrypoint.sh /opt/entrypoint

ENTRYPOINT [ "/usr/bin/slack" ]

