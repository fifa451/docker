#FROM alpine
FROM base

ARG APP_VERSION
ARG APP_URL
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID

# ENV APP_VERSION ${APP_VERSION}
# ENV USERNAME ${USERNAME}
# ENV USERID ${USERID}
# ENV GROUPID ${GROUPID}
# ENV APP_NAME ${APP_NAME}

# ## Update the certs
# RUN apk add --no-cache \
#     unzip \
#     ca-certificates

# RUN [ -d /opt ] || mkdir /opt

## Get App
RUN apk add --no-cache \
    ${APP_NAME}>${APP_VERSION}-suffix

##
# WORKDIR /opt/

# ## Add Run User
# RUN addgroup -g ${GROUPID} ${USERNAME} && adduser -D -G ${USERNAME} -u ${USERID} -h /home/${USERNAME} ${USERNAME}

# ## Create app work dir for volumen map
# RUN mkdir -p /app && chown ${USERNAME}:${USERNAME} -R /app


# ENTRYPOINT [ "/opt/${APP_NAME}" ]
