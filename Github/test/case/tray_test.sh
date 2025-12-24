#!/bin/bash
# Test script for Gentoo-Update tray functionality
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASSED=0
FAILED=0

echo "========================================="
echo "Gentoo-Update Tray Test Suite"
echo "========================================="
echo ""

# Test 1: --tray --enable
echo -n "Testing: ./gentoo-update --tray enable ... "
OUTPUT=$(timeout 2 ./gentoo-update --tray enable 2>&1 || true)
if echo "$OUTPUT" | grep -q "Systray applet autostart enabled"; then
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -e "${RED}✗ FAIL${NC}"
	echo "Output: $OUTPUT"
	((FAILED++))
fi

# Test 2: --tray --disable
echo -n "Testing: ./gentoo-update --tray disable ... "
OUTPUT=$(timeout 2 ./gentoo-update --tray disable 2>&1 || true)
if echo "$OUTPUT" | grep -q "Systray applet autostart disabled"; then
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -e "${RED}✗ FAIL${NC}"
	echo "Output: $OUTPUT"
	((FAILED++))
fi

# Test 3: --tray --enable (with dashes)
echo -n "Testing: ./gentoo-update --tray --enable ... "
OUTPUT=$(timeout 2 ./gentoo-update --tray --enable 2>&1 || true)
if echo "$OUTPUT" | grep -q "Systray applet autostart enabled"; then
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -e "${RED}✗ FAIL${NC}"
	echo "Output: $OUTPUT"
	((FAILED++))
fi

# Test 4: --tray --disable (with dashes)
echo -n "Testing: ./gentoo-update --tray --disable ... "
OUTPUT=$(timeout 2 ./gentoo-update --tray --disable 2>&1 || true)
if echo "$OUTPUT" | grep -q "Systray applet autostart disabled"; then
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -e "${RED}✗ FAIL${NC}"
	echo "Output: $OUTPUT"
	((FAILED++))
fi

echo ""
echo "========================================="
echo "Test Results:"
echo -e "  ${GREEN}Passed: $PASSED${NC}"
echo -e "  ${RED}Failed: $FAILED${NC}"
echo "========================================="

if [ $FAILED -eq 0 ]; then
	echo -e "${GREEN}All tray tests passed!${NC}"
	exit 0
else
	echo -e "${RED}Some tests failed!${NC}"
	exit 1
fi
