#FROM alpine
FROM beta-base

ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID


RUN wget ${APP_URL} -O /opt/${APP_NAME}.zip \
    && unzip /opt/${APP_NAME}.zip -d /opt \
    && chmod +x /opt/${APP_NAME} \
    && ln -s /opt/${APP_NAME} /usr/local/bin/${APP_NAME}
COPY --from=sops:latest /opt/sops /usr/local/bin/sops
