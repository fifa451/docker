#!/bin/bash

DOCKER_DIR=$(dirname $0)
DOCKER_CMD=$(basename $0)

if [ ! -f $DOCKER_DIR/version ];then
    echo "Cannot find version file"
    exit 1
fi
# get app info
. $DOCKER_DIR/version

# map drives
docker run -it --rm \
-u $(id $USER -u) \
-w /app \
-v $(pwd):/app \
-v "${HOME}/.aws:${HOME}/.aws" \
-v "${HOME}/.ssh:${HOME}/.ssh" \
-v "${SSH_AUTH_SOCK}:/ssh-agent" \
-e "SSH_AUTH_SOCK=/ssh-agent" \
$APP_NAME:${APP_VERSION} $DOCKER_CMD $@
