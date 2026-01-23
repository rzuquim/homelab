#!/bin/bash

function depends_on_playbook() {
    local test_name=$1
    local pb_id=$(echo "$test_name" | cut -c 1-2)

    if [[ ! "$pb_id" =~ ^[0-9]{2}$ ]]; then
        echo -e "${RED}❌ PANIC: Test '$test_name' must start with a 2-digit numeric prefix (00-99).${NC}"
        exit 1
    fi

    # NOTE: basic test no playbook required
    if [[ "$pb_id" == "00" ]]; then
        return 1
    fi

    if [[ -z "${PLAYBOOK_MAP[$pb_id]}" ]]; then
        echo -e "${RED}❌ PANIC: No playbook mapped for prefix '$pb_id' (found in '$test_name').${NC}"
        echo -e "Check your PLAYBOOK_MAP definitions."
        exit 1
    fi

    # NOTE: Check if already run
    if [[ -z "${PLAYBOOK_RUN_HISTORY[$pb_id]}" ]]; then
        return 0 # Needs to run
    else
        return 1 # Already ran
    fi
}
