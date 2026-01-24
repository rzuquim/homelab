#!/bin/bash

if id "git" &>/dev/null; then
    echo "User 'git' exists."
    exit 0
else
    echo "User 'git' not found."
    exit 1
fi

if [ -d "/home/git" ]; then
    echo "Home directory for git exists."
else
    echo "Home directory for git user is missing."
    exit 1
fi
