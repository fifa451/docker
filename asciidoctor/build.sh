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


APP_VERSION=${1:-$APP_VERSION}
APP_NAME=${2:-$APP_NAME}

USERNAME=$USER
USERID=$(id $USER -u)
GROUPID=$(id $USER -g)


docker build \
--build-arg APP_VERSION=${APP_VERSION} \
--build-arg APP_NAME=${APP_NAME} \
--build-arg USERNAME=${USERNAME} \
--build-arg USERID=${USERID} \
--build-arg GROUPID=${GROUPID} \
--rm -t ${APP_NAME}:${APP_VERSION} .


echo
echo "You can add following alias to your ~/.bash_aliases"
echo
echo alias ${APP_NAME}='"'$(pwd)/${APP_NAME}'"'
echo
