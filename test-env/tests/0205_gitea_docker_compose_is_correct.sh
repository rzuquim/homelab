#!/bin/bash

DOCKER_COMPOSE="/opt/gitea/docker-compose.yml"

if [ -f "$DOCKER_COMPOSE" ]; then
    echo "docker-compose.yml file exists."
else
    echo "docker-compose.yml file is missing."
    exit 1
fi

