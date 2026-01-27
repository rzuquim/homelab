#!/bin/bash

run_playbook() {
    local test_name=$1
    local pb_id=$(echo "$test_name" | cut -c 1-2)
    local playbook="${PLAYBOOK_MAP[$pb_id]}"

    echo -e "${YELLOW}\t📦 Running $playbook...${NC}"
    
    # We use -v (verbose) so you can see why a playbook fails in the logs
    ansible-playbook "$playbook" --limit test -e "env=test"
    
    if [ $? -eq 0 ]; then
        PLAYBOOK_RUN_HISTORY[$pb_id]=true
        return 0
    else
        return 1
    fi
}
