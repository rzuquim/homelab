#!/bin/bash

if id "ansible" &>/dev/null; then
    echo "User 'ansible' exists."
    exit 0
else
    echo "User 'ansible' not found."
    exit 1
fi
