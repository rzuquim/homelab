#!/bin/bash

echo "Checking Docker binary..."

if ! command -v docker &> /dev/null; then
    echo "❌ Docker binary not found in PATH"
    exit 1
fi

DOCKER_VER=$(docker --version)
echo "✅ Found: $DOCKER_VER"
exit 0
