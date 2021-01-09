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


USERNAME=$USER
USERID=$(id $USER -u)
GROUPID=$(id $USER -g)

echo "Build Based"
docker build \
--build-arg APP_VERSION=${APP_VERSION} \
--build-arg APP_NAME=${APP_NAME} \
--build-arg APK_PKG="${APK_PKG}" \
--build-arg USERNAME=${USERNAME} \
--build-arg USERID=${USERID} \
--build-arg GROUPID=${GROUPID} \
--rm -t ${APP_NAME}:${APP_VERSION} .
docker tag ${APP_NAME}:${APP_VERSION} ${APP_NAME}:latest

echo
echo "Finishing build the base images"
echo