#!/bin/bash

echo "Checking if the ansible user is on docker group..."

if groups ansible | grep -q "\bdocker\b"; then
    echo "✅ Ansible user is in the docker group"
else
    echo "❌ Ansible user is MISSING the docker group"
    exit 1
fi
