#!/bin/bash

set -eo pipefail

for f in ./util/*.sh; do
    source "$f";
done

BOX_NAME="sandbox"

export ANSIBLE_HOST_KEY_CHECKING=False

STABLE_PLAYBOOKS=(
  "../vps/install/docker.yml"
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
    ansible-playbook "$playbook" --limit $BOX_NAME
done

