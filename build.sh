#!/bin/bash -x
cd $1

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


docker build \
--build-arg APP_VERSION=${APP_VERSION} \
--build-arg APP_NAME=${APP_NAME} \
--build-arg APP_URL=${APP_URL} \
--build-arg USERNAME=${USERNAME} \
--build-arg USERID=${USERID} \
--build-arg GROUPID=${GROUPID} \
--rm -t ${APP_NAME}:${APP_VERSION} . \
&& docker tag ${APP_NAME}:${APP_VERSION} ${APP_NAME}:latest

if [ $? -eq 0 ]
then
    echo "Setup Symbolic link"
    echo
    [ -f /usr/local/bin/${APP_NAME} ]|| sudo ln -s  $(pwd)/${APP_NAME} /usr/local/bin/${APP_NAME}
    echo
    echo "You can add following alias to your ~/.bash_aliases"
    echo
    echo alias ${APP_NAME}='"'$(pwd)/${APP_NAME}'"'
    echo
else
    echo "Docker Image $1 build failed"
fi