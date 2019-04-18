#!/usr/bin/env bash
set -e

APP_EXE="/opt/jira"
if [ -f "${APP_EXE}" ]
then
    exec $APP_EXE $@
fi

exec "$@"