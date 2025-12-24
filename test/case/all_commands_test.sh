#!/bin/bash
# Quick test for all Gentoo-Update commands
# SPDX-License-Identifier: GPL-3.0-or-later

echo "============================================"
echo "Gentoo-Update Command Test Suite"
echo "============================================"
echo ""

PASSED=0
FAILED=0

# Colors
GREEN='\033[1;32m'
RED='\033[1;31m'
NC='\033[0m'

# Test helper function
test_cmd() {
	local cmd="$1"
	local expected="$2"
	local name="$3"
	
	echo -n "Testing: $name ... "
	OUTPUT=$(eval "$cmd" 2>&1)
	
	if echo "$OUTPUT" | grep -q "$expected"; then
		echo -e "${GREEN}✓${NC}"
		((PASSED++))
		return 0
	else
		echo -e "${RED}✗${NC}"
		((FAILED++))
		return 1
	fi
}

# Run tests with timeout to prevent hanging
test_cmd "timeout 1 ./gentoo-update --version 2>&1" "Gentoo-Update v0.1" "--version"
test_cmd "timeout 1 ./gentoo-update --help 2>&1" "USAGE:" "--help"
test_cmd "timeout 1 ./gentoo-update -h 2>&1" "USAGE:" "-h"
test_cmd "timeout 1 ./gentoo-update -V 2>&1" "Gentoo-Update v0.1" "-V"
test_cmd "timeout 1 ./gentoo-update -l 2>&1" "Available Package Updates" "--list"
test_cmd "timeout 1 ./gentoo-update --show-config 2>&1" "configuration" "--show-config"
test_cmd "timeout 1 ./gentoo-update --tray enable 2>&1" "autostart enabled" "--tray enable"
test_cmd "timeout 1 ./gentoo-update --tray disable 2>&1" "autostart disabled" "--tray disable"
test_cmd "timeout 1 ./gentoo-update --tray --enable 2>&1" "autostart enabled" "--tray --enable"
test_cmd "timeout 1 ./gentoo-update --tray --disable 2>&1" "autostart disabled" "--tray --disable"

echo ""
echo "============================================"
echo "Results:"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"
echo "============================================"

if [ $FAILED -eq 0 ]; then
	echo -e "${GREEN}✓ All tests passed!${NC}"
	exit 0
else
	echo -e "${RED}✗ Some tests failed!${NC}"
	exit 1
fi
