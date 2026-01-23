#!/bin/bash

echo "Testing container execution..."

if sudo docker run --rm hello-world | grep -q "Hello"; then
    echo "✅ Successfully ran hello-world container"
    exit 0
else
    echo "❌ Failed to run hello-world container"
    exit 1
fi
