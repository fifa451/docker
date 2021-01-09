FROM python:3.7-alpine


ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG APK_PKG
ARG USERNAME
ARG USERID
ARG GROUPID

## Update the certs
RUN \
    apk add --no-cache ${APK_PKG} \
    && addgroup -g ${GROUPID} ${USERNAME} && adduser -D -G ${USERNAME} -u ${USERID} -h /home/${USERNAME} ${USERNAME} \
    && mkdir -p /app \
    && chown ${USERNAME}:${USERNAME} -R /app