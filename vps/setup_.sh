#!/bin/bash

####################
# Basic
####################
sudo apt update && sudo apt upgrade -y

####################
# Docker
####################

while ! docker info >/dev/null 2>&1; do
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo "Error: Docker daemon failed to start within timeout."
        exit 1
    fi
    ((COUNT++))
    sleep 1
done




####################
# Firewall
####################
sudo apt install -y ufw

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp      # SSH
sudo ufw allow 80/tcp      # HTTP
sudo ufw allow 443/tcp     # HTTPS

# TODO: Swarm Internal Ports (ONLY allow these from your other node's IP)
# Replace <OTHER_NODE_IP> with your second VPS IP
# sudo ufw allow from <OTHER_NODE_IP> to any port 2377 proto tcp
# sudo ufw allow from <OTHER_NODE_IP> to any port 7946 proto tcp
# sudo ufw allow from <OTHER_NODE_IP> to any port 7946 proto udp
# sudo ufw allow from <OTHER_NODE_IP> to any port 4789 proto udp

sudo ufw --force enable

