#FROM alpine
FROM beta-base

ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID

RUN wget ${APP_URL} -O /opt/${APP_NAME}.tar.gz \
    && tar -xzf  /opt/${APP_NAME}.tar.gz /opt/${APP_NAME} \
    && chmod +x /opt/${APP_NAME} \
    && ln -s /opt/${APP_NAME} /usr/local/bin/${APP_NAME}
