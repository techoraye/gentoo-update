#!/bin/bash
# Basic test suite for Gentoo-Update
# SPDX-License-Identifier: GPL-3.0-or-later

# Set up environment
export GENTOO_UPDATE_LIBDIR="./src/lib"

# Colors for output
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

# Test counter
PASSED=0
FAILED=0

test_help() {
	echo -n "Testing --help... "
	if ./gentoo-update --help > /dev/null 2>&1; then
		echo -e "${GREEN}✓${NC}"
		((PASSED++))
	else
		echo -e "${RED}✗${NC}"
		((FAILED++))
	fi
}

test_version() {
	echo -n "Testing --version... "
	if ./gentoo-update --version | grep -q "Gentoo-Update v"; then
		echo -e "${GREEN}✓${NC}"
		((PASSED++))
	else
		echo -e "${RED}✗${NC}"
		((FAILED++))
	fi
}

test_check() {
	echo -n "Testing --check... "
	if ./gentoo-update --check > /dev/null 2>&1; then
		echo -e "${GREEN}✓${NC}"
		((PASSED++))
	else
		echo -e "${RED}✗${NC}"
		((FAILED++))
	fi
}

test_list() {
	echo -n "Testing --list... "
	if ./gentoo-update --list > /dev/null 2>&1; then
		echo -e "${GREEN}✓${NC}"
		((PASSED++))
	else
		echo -e "${RED}✗${NC}"
		((FAILED++))
	fi
}

test_show_config() {
	echo -n "Testing --show-config... "
	if ./gentoo-update --show-config > /dev/null 2>&1; then
		echo -e "${GREEN}✓${NC}"
		((PASSED++))
	else
		echo -e "${RED}✗${NC}"
		((FAILED++))
	fi
}

main() {
	echo "Running Gentoo-Update Test Suite"
	echo "=================================="
	
	test_help
	test_version
	test_check
	test_list
	test_show_config
	
	echo ""
	echo "Results:"
	echo "--------"
	echo -e "Passed: ${GREEN}${PASSED}${NC}"
	echo -e "Failed: ${RED}${FAILED}${NC}"
	
	if [ $FAILED -eq 0 ]; then
		echo -e "${GREEN}All tests passed!${NC}"
		exit 0
	else
		echo -e "${RED}Some tests failed!${NC}"
		exit 1
	fi
}

main "$@"
