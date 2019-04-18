FROM ubuntu:18.04

ARG APP_VERSION
ARG APP_NAME
ARG USERNAME
ARG USERID
ARG GROUPID

ENV APP_VERSION ${APP_VERSION}
ENV USERNAME ${USERNAME}
ENV USERID ${USERID}
ENV GROUPID ${GROUPID}
ENV APP_NAME ${APP_NAME}
ENV JIRA_API_TOKEN ""

## install required packages
RUN apt-get update -y && apt-get install wget ca-certificates pass --no-install-recommends -y

RUN [ -d /opt ] || mkdir /opt

## Get App
RUN wget https://github.com/Netflix-Skunkworks/go-jira/releases/download/v${APP_VERSION}/jira-linux-amd64 -O /opt/${APP_NAME}


## Add Run User
RUN addgroup --gid ${GROUPID} ${USERNAME} && adduser --gecos --quiet --disabled-password --ingroup ${USERNAME} -uid ${USERID} ${USERNAME}

## Create app work dir for volumen map
RUN mkdir -p /app && chown ${USERNAME}:${USERNAME} -R /app

## Grant app execution permission
RUN chmod +x  /opt/${APP_NAME} && chown ${USERNAME} /opt/${APP_NAME}

## Cleanup

RUN apt-get clean -y

# # ## Add entrypoint and make sure entry point is executeble
ADD entrypoint.sh /opt/entrypoint

ENTRYPOINT [ "/opt/entrypoint" ]
