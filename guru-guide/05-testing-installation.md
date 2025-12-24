# Step 5: Testing Installation

Test the actual package installation to ensure the ebuild works correctly.

## 5.1 Prepare Test Environment

Create a clean testing environment:

```bash
# Ensure all dependencies are available
sudo emerge --ask app-misc/metetch

# Or install dependencies first
sudo emerge --ask sys-libs/ncurses net-misc/curl cmake
```

---

## 5.2 Clean Previous Builds

Start fresh:

```bash
cd guru/app-misc/metetch

# Clean the build directory
ebuild metetch-0.5.3.ebuild clean

# Verify clean state
ls -la  # Should only show .ebuild, .xml, and Manifest files
```

---

## 5.3 Run Full Build Test

Test the complete build process:

```bash
cd guru/app-misc/metetch

# Full build test (prepare through install)
sudo ebuild metetch-0.5.3.ebuild clean install

# Watch for successful completion
# Should end with: ">>> install app-misc/metetch-0.5.3"
```

### Build Phases That Run
1. **fetch** - Download source
2. **unpack** - Extract tarball
3. **prepare** - Apply patches
4. **configure** - Run cmake
5. **compile** - Build with make
6. **test** - Run tests (if any)
7. **install** - Install to DESTDIR

---

## 5.4 Check Build Output

Verify build was successful:

```bash
cd guru/app-misc/metetch

# Check for common success indicators
sudo ebuild metetch-0.5.3.ebuild install 2>&1 | tail -20

# Should show:
# - No fatal errors
# - Final message about successful installation
# - Binary located correctly
```

---

## 5.5 Verify Installation Contents

Check what was installed:

```bash
# List installed files
equery files app-misc/metetch 2>/dev/null || \
  find /var/tmp/portage/app-misc/metetch-0.5.3/image -type f

# Should include:
# - /usr/bin/metetch (main binary)
# - /usr/share/doc/metetch-0.5.3/
# - /usr/share/licenses/metetch-0.5.3/
```

### Expected Installation Path
```
/usr/bin/metetch             - Binary executable
/usr/share/doc/metetch-0.5.3/   - Documentation
/usr/share/licenses/metetch-0.5.3/LICENSE.proprietary - License file
```

---

## 5.6 Test Installed Binary

Run the installed metetch:

```bash
# Run metetch
/usr/bin/metetch

# Should display system information similar to:
# ╭─ System ──────────────────────────────
# │ Host  : your-hostname
# │ CPU   : [CPU info]
# │ GPU   : [GPU info]
# │ Memory: [Memory info]
# ...
```

### If Binary Fails to Run
- Check dependencies: `ldd /usr/bin/metetch`
- Check file permissions: `ls -la /usr/bin/metetch`
- See [Troubleshooting](10-troubleshooting.md)

---

## 5.7 Test Configuration Menu

Test the interactive config:

```bash
# Run config menu
metetch --config

# Should display:
# metetch configuration — use Up/Down, Enter to edit, Esc to exit
# Presets: Theme + 3 Presets (Default, Minimal, Full)
```

### Navigation Test
- Press ↑/↓ to navigate
- Press Enter to edit an option
- Press Esc to exit

---

## 5.8 Test Help Output

Verify help text:

```bash
# Show help
metetch --help

# Should display usage information and available options
```

---

## 5.9 Check System Integration

Verify package integrated properly:

```bash
# Check if in Portage database
emerge --search metetch
# Should show: [ Results for search key : metetch ]

# Get package info
emerge --info app-misc/metetch 2>/dev/null || \
  echo "Package info unavailable (normal in test)"

# Check dependencies resolved
emerge --pretend app-misc/metetch --verbose=y 2>/dev/null | head -10
```

---

## 5.10 Verify Documentation Installation

Check documentation was installed:

```bash
# List documentation
ls -la /usr/share/doc/metetch-0.5.3/

# Should contain
# - README
# - LICENSE (or similar docs)
```

---

## 5.11 Test Uninstall

Verify the package can be removed:

```bash
# List what will be removed
sudo emerge --pretend --unmerge app-misc/metetch

# Actually uninstall (optional)
# sudo emerge --ask --unmerge app-misc/metetch

# Verify removal
which metetch
# Should return empty or "metetch not found"
```

---

## 5.12 Run System-wide Tests

(If metetch has test suite)

```bash
cd guru/app-misc/metetch

# Run tests (if included)
sudo ebuild metetch-0.5.3.ebuild test

# Or compile with testing
sudo FEATURES=test ebuild metetch-0.5.3.ebuild install
```

### Test Output
```
Running tests for app-misc/metetch-0.5.3...
[Tests pass/fail info]
```

---

## 5.13 Create Installation Log

Document successful installation:

```bash
# Create test report
cat > guru-guide/INSTALLATION_TEST.log << 'EOF'
Installation Test Report
========================

Date: $(date)
Package: app-misc/metetch-0.5.3
Test Status: PASSED

Build Phases:
✓ Fetch
✓ Unpack
✓ Configure
✓ Compile
✓ Install

Installation Verification:
✓ Binary at /usr/bin/metetch
✓ Help text functional
✓ Config menu functional
✓ System info displays correctly
✓ Documentation installed
✓ License file present

Package Removal Test:
✓ Uninstall successful
✓ No leftover files

Overall Status: READY FOR SUBMISSION
EOF

cat guru-guide/INSTALLATION_TEST.log
```

---

## 5.14 Clean Up After Testing

Remove test installation:

```bash
# Uninstall the package
sudo emerge --ask --unmerge app-misc/metetch

# Clean portage cache
sudo ebuild app-misc/metetch/metetch-0.5.3.ebuild clean
rm -f /var/cache/distfiles/metetch-0.5.3.tar.gz  # Optional
```

---

## Summary Checklist

Before proceeding to Step 6, verify:

- ✅ Build completes without errors
- ✅ Binary installs to `/usr/bin/metetch`
- ✅ Metetch runs successfully
- ✅ Help output works
- ✅ Config menu accessible
- ✅ Documentation installs correctly
- ✅ License file present
- ✅ Package can be uninstalled cleanly
- ✅ Installation test log created

---

## Next Steps

Once installation testing passes, proceed to:
**[Step 6: Committing Changes](06-committing-changes.md)**

---

**Last Updated**: December 23, 2025
**Status**: Ready
