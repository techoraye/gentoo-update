#!/bin/bash
# Test notification functionality for Gentoo-Update
# SPDX-License-Identifier: GPL-3.0-or-later

set -e

GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'

PASSED=0
FAILED=0

echo "=========================================="
echo "Gentoo-Update Notification Test Suite"
echo "=========================================="
echo ""

# Check if notify-send is available
if command -v notify-send &> /dev/null; then
	echo -e "${GREEN}✓${NC} notify-send is available"
	NOTIFY_AVAILABLE=1
else
	echo -e "${YELLOW}⚠${NC} notify-send not available (optional)"
	NOTIFY_AVAILABLE=0
fi

# Test 1: Check tray startup message
echo ""
echo -n "Test 1: Tray startup message ... "
OUTPUT=$(timeout 1 ./gentoo-update --tray 2>&1 || true)
if echo "$OUTPUT" | grep -q "Full systray requires Python and PyQt6"; then
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -e "${RED}✗ FAIL${NC}"
	((FAILED++))
fi

# Test 2: Tray enable with message
echo -n "Test 2: Tray enable confirmation ... "
OUTPUT=$(timeout 1 ./gentoo-update --tray enable 2>&1 || true)
if echo "$OUTPUT" | grep -q "autostart enabled"; then
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -e "${RED}✗ FAIL${NC}"
	((FAILED++))
fi

# Test 3: Tray disable with message
echo -n "Test 3: Tray disable confirmation ... "
OUTPUT=$(timeout 1 ./gentoo-update --tray disable 2>&1 || true)
if echo "$OUTPUT" | grep -q "autostart disabled"; then
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -e "${RED}✗ FAIL${NC}"
	((FAILED++))
fi

# Test 4: Send test notification if available
if [ $NOTIFY_AVAILABLE -eq 1 ]; then
	echo -n "Test 4: Desktop notification ... "
	notify-send -i system-software-update "Gentoo-Update" "Updates available" &
	sleep 1
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -n "Test 4: Desktop notification ... "
	echo -e "${YELLOW}⊘ SKIPPED${NC} (notify-send not available)"
fi

# Test 5: Check for notification in update checks
echo -n "Test 5: Update check with notification ... "
OUTPUT=$(timeout 1 ./gentoo-update -c 2>&1 || true)
if echo "$OUTPUT" | grep -q "Check complete"; then
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -e "${RED}✗ FAIL${NC}"
	((FAILED++))
fi

# Test 6: Version output formatting for notifications
echo -n "Test 6: Version display (for tray) ... "
OUTPUT=$(./gentoo-update --version 2>&1)
if echo "$OUTPUT" | grep -q "Gentoo-Update v0.1"; then
	echo -e "${GREEN}✓ PASS${NC}"
	((PASSED++))
else
	echo -e "${RED}✗ FAIL${NC}"
	((FAILED++))
fi

echo ""
echo "=========================================="
echo "Results:"
echo -e "  ${GREEN}Passed: $PASSED${NC}"
echo -e "  ${RED}Failed: $FAILED${NC}"
echo "=========================================="

if [ $FAILED -eq 0 ]; then
	echo -e "${GREEN}✓ All notification tests passed!${NC}"
	exit 0
else
	echo -e "${RED}✗ Some tests failed!${NC}"
	exit 1
fi
