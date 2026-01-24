#!/bin/bash

APP_INI="/opt/gitea/data/gitea/conf/app.ini"

if [ -f "$APP_INI" ]; then
    echo "app.ini file exists."
else
    echo "app.ini file is missing."
    exit 1
fi

OWNER=$(stat -c '%U:%G' "$APP_INI")
if [ "$OWNER" == "git:git" ]; then
    echo "app.ini file has correct ownership (git:git)."
else
    echo "app.ini file has incorrect ownership: $OWNER"
    exit 1
fi

