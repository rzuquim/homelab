#!/bin/bash
set -e

echo "Starting Docker daemon..."
service docker start

echo "Waiting for Docker to initialize..."
MAX_RETRIES=10
COUNT=0

while ! docker info >/dev/null 2>&1; do
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo "Error: Docker daemon failed to start within timeout."
        exit 1
    fi
    ((COUNT++))
    sleep 1
done
echo "Docker is up and running!"

# NOTE: Without exec, the entrypoint remains PID 1, and it might "swallow" signals
#       making the container take 10 seconds to stop because Docker has to force-kill it.
#       `exec` replaces the shell process with the command we pass on the Dockerfile.
#       Now, bash becomes PID 1, and it will respond instantly when you try to stop the container.
exec "$@"
