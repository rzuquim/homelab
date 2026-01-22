#!/bin/bash

USER_NAME=$(echo "$1" | tr -d '\r\n ')
USER_PUBLIC_KEY=$(echo "$2" | tr -d '\r')
HOME_DIR="/home/$USER_NAME"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [ -z "$USER_NAME" ]; then
    echo -e "${RED}ERROR: No developer user name provided!${NC}"
    exit 1
fi

if [ -z "$USER_PUBLIC_KEY" ]; then
    echo -e "${RED}ERROR: No developer public key provided!${NC}"
    exit 1
fi

# NOTE: installing basic tools
apt-get update && apt-get install -y \
    python3 \
    sudo \
    curl

if ! id "$USER_NAME" &>/dev/null; then
    useradd -m -s /bin/bash "$USER_NAME"
fi
echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME
chmod 0440 /etc/sudoers.d/$USER_NAME

mkdir -p "$HOME_DIR/.ssh"
chmod 700 "$HOME_DIR/.ssh"

echo "$USER_PUBLIC_KEY" >> "$HOME_DIR/.ssh/authorized_keys"
chmod 600 "$HOME_DIR/.ssh/authorized_keys"

# NOTE: Clean up duplicates for every 'vagrant provision'
sort -u "$HOME_DIR/.ssh/authorized_keys" -o "$HOME_DIR/.ssh/authorized_keys"

chown -R "$USER_NAME:$USER_NAME" "$HOME_DIR/.ssh"

echo -e "${GREEN}Developer key injected on VM.${NC}"

