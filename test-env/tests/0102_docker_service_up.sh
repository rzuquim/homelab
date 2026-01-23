#!/bin/bash

echo "Checking Docker daemon and socket..."

if ! systemctl is-active --quiet docker; then
    echo "❌ Docker service is not running (systemd)"
    exit 1
fi

if ! sudo docker info &> /dev/null; then
    echo "❌ Docker daemon is running but not responding to 'docker info'"
    exit 1
fi

echo "✅ Docker daemon is healthy"
exit 0
