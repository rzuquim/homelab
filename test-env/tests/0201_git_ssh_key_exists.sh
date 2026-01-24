#!/bin/bash

file_exists() {
    sudo [ -f "$1" ]
}

if file_exists "/home/git/.ssh/id_rsa" && file_exists "/home/git/.ssh/id_rsa.pub"; then
    echo "SSH keys for 'git' have been generated."
else
    echo "[FAIL] SSH keys for user are missing in /home/git/.ssh/"
    exit 1
fi
