#!/bin/bash

if [ ! -f version ]
then
    echo "Cannot find version file"
    exit 1
fi

doc_help(){
    
    echo "Setting up alias"
    echo ""
}

. version


APP_NAME=${1:-$APP_NAME}
APP_VERSION=${2:-$APP_VERSION}

USERNAME=$USER
USERID=$(id $USER -u)
GROUPID=$(id $USER -g)


if [ -z "${APP_NAME}" ]
then
    echo "Please pass your app name"
    exit 1
fi

docker build \
--build-arg APP_VERSION=${APP_VERSION} \
--build-arg APP_NAME=${APP_NAME} \
--build-arg APP_URL=${APP_URL} \
--build-arg USERNAME=${USERNAME} \
--build-arg USERID=${USERID} \
--build-arg GROUPID=${GROUPID} \
--rm -t ${APP_NAME}:${APP_VERSION} .

docker tag ${APP_NAME}:${APP_VERSION} ${APP_NAME}:latest

echo
echo "You can add following alias to your ~/.bash_aliases"
echo
echo alias ${APP_NAME}='"'$(pwd)/${APP_NAME}'"'
echo
