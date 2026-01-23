#!/bin/bash

if sudo sudo -l -U ansible | grep -q "(ALL) NOPASSWD: ALL"; then
    echo "User 'ansible' has sudo privileges."
    exit 0
else
    echo "User 'ansible' does NOT have sudo privileges."
    exit 1
fi
