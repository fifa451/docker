FROM alpine

ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID


RUN [ -d /opt ] || mkdir /opt

## Get App
RUN wget ${APP_URL} -O /opt/${APP_NAME}

##
WORKDIR /opt/

## unzip the file
RUN \
    /usr/bin/unzip  /opt/${APP_NAME}.zip

## Grant app execution permission
RUN chmod +x -R /opt/${APP_NAME}.zip

## Add Run User
RUN addgroup -g ${GROUPID} ${USERNAME} && adduser -D -G ${USERNAME} -u ${USERID} -h /home/${USERNAME} ${USERNAME}

## Create app work dir for volumen map
RUN mkdir -p /app && chown ${USERNAME}:${USERNAME} -R /app
