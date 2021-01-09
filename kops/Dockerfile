FROM beta-base

ARG APP_VERSION
ARG APP_NAME
ARG APP_URL
ARG USERNAME
ARG USERID
ARG GROUPID

## Get App
RUN wget ${APP_URL} -O /opt/${APP_NAME} \
    && chmod +x  /opt/${APP_NAME} \
    && ln -s  /opt/${APP_NAME} /usr/bin/${APP_NAME}