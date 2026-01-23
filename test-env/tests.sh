#!/bin/bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
VIOLET="\e[38;2;238;130;238m"
NC='\033[0m' # No Color

TEST_BOX_NAME="test"
TESTS_DIR="./tests"
RESULT=0

export ANSIBLE_HOST_KEY_CHECKING=False

# =====================================================
echo -e "${VIOLET}🚀 Starting Test Environment...${NC}"
# =====================================================

# Ensure a clean environment by destroying any existing box first
vagrant destroy -f $TEST_BOX_NAME > /dev/null 2>&1
vagrant up $TEST_BOX_NAME

ansible test -m ping
echo -e "${GREEN}✅${NC} Test environt READY!"

# =====================================================
echo -e "${VIOLET}🧪 Running Tests...${NC}"
# =====================================================
mapfile -t tests < <(find "$TESTS_DIR" -maxdepth 1 -name "*.sh" | sort)

if [ ${#tests[@]} -eq 0 ]; then
    echo -e "${RED}⚠️  No tests found in $TESTS_DIR${NC}"
    vagrant destroy -f $TEST_BOX_NAME
    exit 1
fi

# NOTE: Disable 'exit on error' so we can perform cleanup even if a test fails
set +e 

for test_path in "${tests[@]}"; do
    test_name=$(basename "$test_path")
    echo -ne "\t$test_name${NC}... "

    vagrant upload "$test_path" "/tmp/$test_name" $TEST_BOX_NAME > /dev/null
    
    test_output=$(vagrant ssh $TEST_BOX_NAME -c "chmod +x /tmp/$test_name && /tmp/$test_name" 2>&1)
    test_status=$?

    if [ $test_status -eq 0 ]; then
        echo -e "${GREEN}✅PASS${NC}"
    else 
        echo -e "${RED}❌FAIL${NC}"
        echo -e "${RED}--- Output ---${NC}"
        echo "$test_output"
        echo -e "${RED}--------------${NC}"

        RESULT=1
        break
    fi
done

# =====================================================
echo -e "${VIOLET}🧹 Destroying Test Environment...${NC}"
# =====================================================
vagrant destroy -f $TEST_BOX_NAME

exit $RESULT
