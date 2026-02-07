#!/bin/bash

set -eo pipefail

for f in ./util/*.sh; do
    source "$f";
done

BOX_NAME="sandbox"

export ANSIBLE_HOST_KEY_CHECKING=False

STABLE_PLAYBOOKS=(
  "../vps/docker/docker.ansible.yml"
  "../vps/gitea/gitea.ansible.yml"
  "../vps/nginx/nginx.ansible.yml"
  "../vps/firewall/iptables.ansible.yml"
)

# =====================================================
echo -e "${VIOLET}🚀 Starting Environment...${NC}"
# =====================================================

vagrant up $BOX_NAME
ansible $BOX_NAME -m ping
echo -e "${GREEN}✅${NC} Environt READY!"

# =====================================================
echo -e "${VIOLET}📋 Running Stable Playbooks...${NC}"
# =====================================================

for playbook in "${STABLE_PLAYBOOKS[@]}"; do
    echo -e "${YELLOW}\t📦 Running $playbook...${NC}"
    # NOTE: add --ask-vault-pass to test the sandbox with real secrets
    ansible-playbook "$playbook" --limit $BOX_NAME -e "env=sandbox"
done

