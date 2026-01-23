#!/bin/bash

SSH_DIR="/home/ansible/.ssh"
KEY_FILE="$SSH_DIR/authorized_keys"

if sudo test -s "$KEY_FILE"; then
    OWNER=$(sudo stat -c '%U' "$SSH_DIR")
    if [ "$OWNER" == "ansible" ]; then
        echo "Public key exists and permissions look correct."
        exit 0
    else
        echo "Error: $SSH_DIR is owned by $OWNER, not ansible."
        exit 1
    fi
else
    echo "Authorized keys file is missing or empty."
    exit 1
fi
