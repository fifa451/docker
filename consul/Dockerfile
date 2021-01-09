FROM alpine-rc:3.10

ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID

WORKDIR /opt

## unzip the file
RUN \
    wget ${APP_URL} -O /opt/${APP_NAME}.zip \
    && unzip /opt/${APP_NAME}.zip \
    && chmod +x -R /opt/${APP_NAME} \
    && ln -s /opt/${APP_NAME} /usr/local/bin/${APP_NAME}
