#!/bin/bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

function create_user() {
    local USER_NAME=$(echo "$1" | tr -d '\r\n ')
    local USER_PUBLIC_KEY=$(echo "$2" | tr -d '\r')
    local HOME_DIR="/home/$USER_NAME"

    if id "$USER_NAME" &>/dev/null; then
        echo -e "${YELLOW}WARN: user $USER_NAME already exists!${NC}"
        return 1
    fi

    useradd -m -s /bin/bash "$USER_NAME"

    echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME
    chmod 0440 /etc/sudoers.d/$USER_NAME

    mkdir -p "$HOME_DIR/.ssh"
    chmod 700 "$HOME_DIR/.ssh"

    echo "$USER_PUBLIC_KEY" >> "$HOME_DIR/.ssh/authorized_keys"
    chmod 600 "$HOME_DIR/.ssh/authorized_keys"

    # NOTE: removing possible duplicates
    sort -u "$HOME_DIR/.ssh/authorized_keys" -o "$HOME_DIR/.ssh/authorized_keys"

    chown -R "$USER_NAME:$USER_NAME" "$HOME_DIR/.ssh"
}

# Installing basic tools
apt-get update && apt-get install -y \
    python3 \
    sudo \
    curl

# TODO: move to homelab.rzuquim.com/ansible_pub_key
ANSIBLE_PUB_KEY_URL=https://raw.githubusercontent.com/rzuquim/homelab/refs/heads/main/vps/ansible_key.pub
ANSIBLE_USER=ansible
ANSIBLE_PUB_KEY=$(curl -s "$ANSIBLE_PUB_KEY_URL")
create_user "$ANSIBLE_USER" "$ANSIBLE_PUB_KEY"

echo -e "${GREEN}Ansible user setup complete.${NC}"
