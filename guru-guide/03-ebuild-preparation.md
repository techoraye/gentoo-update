# Step 3: Ebuild Preparation

Prepare and validate the metetch ebuild files.

## 3.1 Verify Ebuild Files

Check that all necessary files are in place:

```bash
cd guru/app-misc/metetch

# List files
ls -la

# Should show:
# - metetch-0.5.3.ebuild (main ebuild file)
# - metadata.xml (package metadata)
```

### File Contents Check

**Check metetch-0.5.3.ebuild exists:**
```bash
head -5 metetch-0.5.3.ebuild
# Should show: # Copyright 1999-2025 Gentoo Authors
```

**Check metadata.xml exists:**
```bash
head -5 metadata.xml
# Should show: <?xml version="1.0" encoding="UTF-8"?>
```

---

## 3.2 Create Manifest File

Generate cryptographic checksums for source files:

```bash
cd guru/app-misc/metetch

# Generate Manifest file
ebuild metetch-0.5.3.ebuild manifest

# Verify Manifest was created
ls -la Manifest
# Should show a new Manifest file with checksums
```

### What the Manifest Does
- Downloads source tarball from GitHub
- Calculates SHA256 and other hashes
- Stores in Manifest file for integrity verification
- Required for all GURU packages

### Troubleshooting Manifest Generation
If it fails, see [Troubleshooting Step 2](10-troubleshooting.md#manifest-generation-fails)

---

## 3.3 Validate Ebuild Syntax

Check for syntax errors:

```bash
cd guru/app-misc/metetch

# Check ebuild syntax
ebuild metetch-0.5.3.ebuild clean

# Should complete without errors
# Output: [ebuild clean]
```

---

## 3.4 Verify Directory Structure

Check GURU repository structure is correct:

```bash
cd guru

# Show directory tree (install tree if not available: emerge --ask app-misc/tree)
tree -L 3 app-misc/metetch/

# Or use ls
find app-misc/metetch/ -type f
```

### Expected Output
```
app-misc/metetch/
├── metetch-0.5.3.ebuild
├── metadata.xml
└── Manifest
```

---

## 3.5 Check for Common Ebuild Mistakes

Review the ebuild file:

```bash
cd guru 

# View the ebuild
cat metetch-0.5.3.ebuild
```

### Key Points to Verify

✅ **EAPI**: Should be `EAPI=8` (modern standard)
```bash
grep "^EAPI=" metetch-0.5.3.ebuild
```

✅ **License**: Should be defined
```bash
grep "^LICENSE=" metetch-0.5.3.ebuild
```

✅ **Homepage**: Should be https://github.com/techoraye/metetch
```bash
grep "^HOMEPAGE=" metetch-0.5.3.ebuild
```

✅ **Description**: Should be descriptive (< 80 chars)
```bash
grep "^DESCRIPTION=" metetch-0.5.3.ebuild
```

✅ **Keywords**: Should be testing (`~amd64`)
```bash
grep "^KEYWORDS=" metetch-0.5.3.ebuild
```

---

## 3.6 Review metadata.xml

Check package metadata:

```bash
cd guru/app-misc/metetch

# View metadata
cat metadata.xml
```

### Key Points to Verify

✅ **Maintainer**: Includes your name and email
```bash
grep -A2 "type=\"person\"" metadata.xml
```

✅ **Proxy Maintainer**: Should reference proxy-maint@gentoo.org
```bash
grep "proxy-maint" metadata.xml
```

✅ **Upstream**: Should link to GitHub
```bash
grep "upstream" metadata.xml
```

✅ **Description**: Clear package description included

---

## 3.7 Version Format Check

Verify version naming is correct:

```bash
cd guru/app-misc/metetch

# Version should match: metetch-0.5.3.ebuild
ls metetch-*.ebuild

# Extract version from filename
grep "PV=" metetch-0.5.3.ebuild
# Should auto-detect from filename as 0.5.3
```

### Version Patterns
- Stable versions: `1.0`, `0.5.3` (numbers only)
- Alpha: `1.0_alpha1`
- Beta: `1.0_beta2`
- Release Candidate: `1.0_rc1`
- Live (git): Usually avoid for initial submission

---

## 3.8 Run Basic Linting

Check for common issues:

```bash
cd guru/app-misc/metetch

# Check line endings (should be Unix, not Windows)
file metetch-0.5.3.ebuild metadata.xml Manifest

# Should all show: ASCII text (or similar)
# NOT: CRLF (Windows)

# Check for trailing whitespace
grep -n " $" metetch-0.5.3.ebuild
# Should return nothing
```

---

## 3.9 Test Download Source

Verify source can be fetched:

```bash
cd guru/app-misc/metetch

# Fetch the source (may take a moment)
ebuild metetch-0.5.3.ebuild fetch

# Check if source was downloaded
ls -la /var/cache/distfiles/metetch-0.5.3.tar.gz
# Should exist with reasonable size (> 100KB)
```

### Source Verification
```bash
# Compare checksums
sha256sum /var/cache/distfiles/metetch-0.5.3.tar.gz
# Should match the hash in Manifest file
```

---

## 3.10 Verify Dependency Categories

Check that dependencies use correct categories:

```bash
cd guru/app-misc/metetch

# View dependencies
grep -E "DEPEND|RDEPEND|BDEPEND" metetch-0.5.3.ebuild
```

### Correct Dependency Categories
- `sys-libs/ncurses` - correct (ncurses is in sys-libs)
- `net-misc/curl` - correct (curl is in net-misc)
- `virtual/pkgconfig` - correct (pkgconfig is virtual)

---

## Summary Checklist

Before proceeding to Step 4, verify:

- ✅ All ebuild files present
- ✅ Manifest generated successfully
- ✅ Ebuild syntax validated
- ✅ Directory structure correct
- ✅ EAPI, License, Homepage set properly
- ✅ Keywords are `~amd64` (testing)
- ✅ Metadata includes maintainer and upstream info
- ✅ Source file downloads correctly
- ✅ Dependencies use correct categories
- ✅ No trailing whitespace or Windows line endings

---

## Next Steps

Once ebuild is prepared, proceed to:
**[Step 4: QA Checks](04-qa-checks.md)**

---

**Last Updated**: December 23, 2025
**Status**: Ready
