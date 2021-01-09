FROM alpine

ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID

ENV APP_VERSION ${APP_VERSION}
ENV USERNAME ${USERNAME}
ENV USERID ${USERID}
ENV GROUPID ${GROUPID}
ENV APP_NAME ${APP_NAME}
ENV APP_URL ${APP_URL}

## Update the certs
RUN apk add --no-cache \
    unzip \
    ca-certificates

RUN [ -d /opt ] || mkdir /opt

## Get App
RUN wget ${APP_URL} -O /opt/${APP_NAME}.zip

##
WORKDIR /opt/

## unzip the file
RUN \
    /usr/bin/unzip  /opt/${APP_NAME}.zip

## Grant app execution permission
RUN chmod +x -R /opt/${APP_NAME}.zip  && \
    ln -s /opt/${APP_NAME} /bin/${APP_NAME}

## Add Run User
RUN addgroup -g ${GROUPID} ${USERNAME} && adduser -D -G ${USERNAME} -u ${USERID} -h /home/${USERNAME} ${USERNAME}

## Create app work dir for volumen map
RUN mkdir -p /app && chown ${USERNAME}:${USERNAME} -R /app
