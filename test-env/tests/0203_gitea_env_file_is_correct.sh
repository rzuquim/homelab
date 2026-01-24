#!/bin/bash

ENV_FILE="/opt/gitea/.env"
USER_NAME="git"

if [ -f "$ENV_FILE" ]; then
    echo ".env file exists."
else
    echo ".env file is missing."
    exit 1
fi

OWNER=$(stat -c '%U:%G' "$ENV_FILE")
if [ "$OWNER" == "git:git" ]; then
    echo ".env file has correct ownership (git:git)."
else
    echo ".env file has incorrect ownership: $OWNER"
    exit 1
fi


if grep -q "GITEA_UID=[0-9]" "$ENV_FILE" && grep -q "GITEA_GID=[0-9]" "$ENV_FILE"; then
    echo ".env file contains valid UID/GID values."
else
    echo ".env file contains invalid or empty values."
    cat "$ENV_FILE"
    exit 1
fi

EXPECTED_UID=$(id -u "$USER_NAME")
EXPECTED_GID=$(id -g "$USER_NAME")

ACTUAL_UID=$(grep "GITEA_UID" "$ENV_FILE" | cut -d'=' -f2)
ACTUAL_GID=$(grep "GITEA_GID" "$ENV_FILE" | cut -d'=' -f2)

if [ "$ACTUAL_UID" == "$EXPECTED_UID" ]; then
    echo "UID matches"
else
    echo "UID mismatch: System($EXPECTED_UID) != .env($ACTUAL_UID)"
    exit 1
fi

if [ "$ACTUAL_GID" == "$EXPECTED_GID" ]; then
    echo "GID matches"
else
    echo "GID mismatch: System($EXPECTED_UID) != .env($ACTUAL_UID)"
    exit 1
fi
