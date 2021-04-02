FROM beta-base

ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID

## Update the certs

RUN wget ${APP_URL} -O /opt/${APP_NAME} \
    && chmod +x -R /opt/${APP_NAME} && \
    ln -s /opt/${APP_NAME} /usr/local/bin/${APP_NAME}