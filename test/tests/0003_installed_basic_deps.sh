#!/bin/bash

DEPS=("python3" "sudo" "curl")
MISSING=()

for pkg in "${DEPS[@]}"; do
    if ! command -v "$pkg" &>/dev/null; then
        MISSING+=("$pkg")
    fi
done

if [ ${#MISSING[@]} -eq 0 ]; then
    echo "All dependencies (${DEPS[*]}) are installed."
    exit 0
else
    echo "Missing dependencies: ${MISSING[*]}"
    exit 1
fi
