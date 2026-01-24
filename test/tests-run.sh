#!/bin/bash

set -eo pipefail

for f in ./util/*.sh; do
    source "$f";
done

TEST_BOX_NAME="test"
TESTS_DIR="./tests"
RESULT=0
CLEAN_ENV=true

export ANSIBLE_HOST_KEY_CHECKING=False

declare -A PLAYBOOK_RUN_HISTORY=()
declare -A PLAYBOOK_MAP=( \
    ["01"]="../vps/docker/docker.ansible.yml" \
    ["02"]="../vps/gitea/gitea.ansible.yml" \
)


# Parsing args
for arg in "$@"; do
    case "$arg" in
        --no-clean)
            echo "eita!"
            CLEAN_ENV=false
            ;;
        *)
            echo "Unknown option: $arg"
            exit 1
            ;;
    esac
done

# Ensuring pristine test environment
clean

# =====================================================
echo -e "${VIOLET}🚀 Starting Test Environment...${NC}"
# =====================================================

# NOTE: Ensure a clean environment by destroying any existing box first
vagrant up $TEST_BOX_NAME

ansible test -m ping
echo -e "${GREEN}✅${NC} Test environt READY!"

# =====================================================
echo -e "${VIOLET}🧪 Running Tests...${NC}"
# =====================================================
mapfile -t tests < <(find "$TESTS_DIR" -maxdepth 1 -name "*.sh" | sort)

if [ ${#tests[@]} -eq 0 ]; then
    echo -e "${RED}⚠️  No tests found in $TESTS_DIR${NC}"
    clean
    exit 1
fi

# NOTE: Disable 'exit on error' so we can perform cleanup even if a test fails
set +e 

for test_path in "${tests[@]}"; do
    test_name=$(basename "$test_path")

    if depends_on_playbook "$test_name"; then  
        run_playbook "$test_name" || {
            echo -e "${RED}❌ Playbook failed. Aborting.${NC}"
            exit 1 
        }
    fi

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

clean
exit $RESULT
