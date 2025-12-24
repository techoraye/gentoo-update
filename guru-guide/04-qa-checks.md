# Step 4: QA Checks

Run quality assurance checks to ensure the ebuild meets Gentoo standards.

## 4.1 Run pkgcheck

Comprehensive QA tool for Gentoo packages:

```bash
cd guru

# Basic check on metetch
pkgcheck scan app-misc/metetch/

# Detailed output
pkgcheck scan --verbose app-misc/metetch/
```

### Expected Output (for passing check)
```
0 errors, 0 warnings, 0 info messages
```

### Common Warnings (Usually OK for initial submission)
- `MissingSlotOperator`: Can be ignored if no slot dependency
- `UnstableKeywordAlerted`: Normal for ~amd64 (testing)
- `MissingVCS`: OK if using stable version

---

## 4.2 Run pkgdev Check

pkgdev-specific checks:

```bash
cd guru

# Check commits (if any changes made yet)
pkgdev check --commits

# Or check current directory
pkgdev check app-misc/metetch/
```

### Expected Output
```
Scanning commits...
app-misc/metetch: 0 errors
```

---

## 4.3 Advanced pkgcheck Scans

Network-based checks for more thorough validation:

```bash
cd guru

# Check with network access (for upstream verification)
pkgcheck scan --net app-misc/metetch/

# Check against latest profiles
pkgcheck scan --profiles default/linux/amd64 app-misc/metetch/
```

### What These Check
- Network connectivity of upstream URLs
- Compatibility with different architectures
- Package slot conflicts
- Dependency resolution

---

## 4.4 Check for License Issues

Verify proprietary license handling:

```bash
cd guru/app-misc/metetch

# Check license declaration
grep "^LICENSE=" metetch-0.5.3.ebuild

# Should output: LICENSE="proprietary"
```

### License Verification
```bash
# Check that LICENSE file is installed
grep -i "LICENSE\|license" metetch-0.5.3.ebuild

# Should reference LICENSE file in src_install
```

---

## 4.5 Verify Dependencies Resolution

Check that all dependencies can be resolved:

```bash
# Test dependency resolution
emerge --pretend app-misc/metetch

# Output should show:
# - ncurses (will be compiled, built-in, or pre-installed)
# - curl (will be compiled, built-in, or pre-installed)
# - cmake (buildtime dependency)
```

### If Dependencies Can't Be Found
```bash
# Check if packages exist
emerge --search ncurses
emerge --search curl
emerge --search cmake

# Install missing ones
sudo emerge --ask ncurses curl cmake
```

---

## 4.6 Test Ebuild Download Phase

Verify source download without building:

```bash
cd guru/app-misc/metetch

# Clean any previous attempts
ebuild metetch-0.5.3.ebuild clean

# Just download (no compilation)
ebuild metetch-0.5.3.ebuild fetch

# Verify download
ls -lh /var/cache/distfiles/metetch-*
```

### Expected Output
```
-rw-r--r-- 1 root root 125K Dec 23 10:00 /var/cache/distfiles/metetch-0.5.3.tar.gz
```

---

## 4.7 Check Manifest Integrity

Verify Manifest file is valid:

```bash
cd guru/app-misc/metetch

# Regenerate and compare Manifest
ebuild metetch-0.5.3.ebuild manifest

# Git diff to check what changed
git diff Manifest

# Should show checksums match (or be newly created)
```

---

## 4.8 Setup Git Hook for Automatic Checks

(Optional but Recommended)

Automatically run checks before pushing:

```bash
cd guru

# If you installed pkgcruft-git:
ln -s /usr/bin/pkgcruft-git-pre-push .git/hooks/pre-push

# Or create custom hook:
cat > .git/hooks/pre-push << 'EOF'
#!/bin/bash
pkgcheck scan --net . || exit 1
EOF

chmod +x .git/hooks/pre-push
```

---

## 4.9 Common QA Issues & Solutions

### Issue: MissingDependency
```
MissingDependency: DEPEND/RDEPEND: missing ebuild(s)
```
**Solution**: Add the missing dependency to DEPEND/RDEPEND or verify package exists

### Issue: InvalidURI
```
InvalidURI: SRC_URI: failed downloading
```
**Solution**: Verify URL is correct and accessible

### Issue: UnwantedSpaces
```
UnwantedSpaces: found tabs/spaces
```
**Solution**: Replace with proper indentation

### Issue: InvalidLicenseName
```
InvalidLicenseName: LICENSE: unknown license
```
**Solution**: Use standard Gentoo license names (see Step 4.10)

---

## 4.10 List Available Licenses

Find correct license name:

```bash
# List all Gentoo licenses
ls /var/db/repos/gentoo/licenses/ | grep -i "proprietary\|custom"

# For proprietary software in GURU:
# Use "proprietary" (all lowercase)
```

### License Options for Proprietary Software
- `proprietary` - Closed source, proprietary
- `all-rights-reserved` - All rights reserved
- `custom-license` - Custom license (if not standard)

---

## 4.11 Run Final Pre-commit Check

Before committing, run final checks:

```bash
cd guru

# Complete QA scan
pkgcheck scan --verbose --net app-misc/metetch/

# Check for commits
pkgdev check --commits HEAD~1..HEAD 2>/dev/null || echo "No commits yet"

# Verify Git status
git status app-misc/metetch/
```

### Final Checklist Output
All commands should complete with **zero errors**.

---

## 4.12 Document Any QA Overrides

If you have QA issues that are acceptable, document them:

```bash
# Create a file documenting any acceptable warnings
cat > guru-guide/QA_NOTES.txt << 'EOF'
QA Check Results for metetch-0.5.3
===================================

Date: 2025-12-23
Status: PASS

Checks Run:
✓ pkgcheck scan
✓ pkgdev check
✓ pkgcheck scan --net
✓ Dependency resolution
✓ License verification

Known Issues: None
Acceptable Warnings: None

All QA checks passed successfully.
EOF
```

---

## Summary Checklist

Before proceeding to Step 5, verify:

- ✅ pkgcheck scan shows 0 errors
- ✅ pkgdev check shows 0 errors
- ✅ License properly declared as "proprietary"
- ✅ All dependencies can be resolved
- ✅ Source file downloads successfully
- ✅ Manifest integrity verified
- ✅ No trailing whitespace or formatting issues
- ✅ Network checks pass

---

## Next Steps

Once QA checks pass, proceed to:
**[Step 5: Testing Installation](05-testing-installation.md)**

---

**Last Updated**: December 23, 2025
**Status**: Ready
