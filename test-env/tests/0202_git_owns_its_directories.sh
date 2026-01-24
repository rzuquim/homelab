#!/bin/bash

GITEA_DIR="/opt/gitea"
PATHS=(
    "$GITEA_DIR"
    "$GITEA_DIR/data/gitea/conf"
    "/home/git/.ssh"
)

for path in "${PATHS[@]}"; do
    if [ -d "$path" ]; then
        echo "Directory exists: $path"
    else
        echo "Directory missing: $path"
        exit 1
    fi

    OWNER=$(stat -c '%U:%G' "$path")
    if [ "$OWNER" == "git:git" ]; then
        echo "Correct ownership for $path ($OWNER)"
    else
        echo "Incorrect ownership for $path. Found: $OWNER"
        exit 1
    fi
done
