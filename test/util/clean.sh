#!/bin/bash

function clean() {
    if [ "$CLEAN_ENV" = true ]; then
        echo -e "${VIOLET}🧹 Destroying Test Environment...${NC}"
        vagrant destroy -f "$TEST_BOX_NAME"
    else
        echo -e "${YELLOW}⚠️  Skipping 'vagrant destroy' (--no-clean)${NC}"
    fi
}
