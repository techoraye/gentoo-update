# Step 8: Stabilization

Stabilize metetch package for general availability after successful testing period.

## 8.1 Wait for Testing Period

After initial GURU acceptance, allow time for testing:

```
Timeline:
Week 1: Review and merge to master
Week 2-4: Community testing and feedback
Week 5+: Request stabilization (typically 30+ days minimum)
```

### What Happens During Testing
- Package used by GURU users
- Feedback received on functionality
- Bug reports filed and addressed
- Security issues identified
- Compatibility verified across systems

---

## 8.2 Check for Feedback

Monitor for issues during testing period:

```bash
# Watch for notifications
# - GitHub issues on repo
# - Gentoo Bugzilla tickets
# - Email from GURU project
# - Git commits/pull requests

# Check on website:
# https://gitweb.gentoo.org/?p=repo/proj/guru.git
# Look for your package history
```

### Address Any Issues Found
```bash
# If bug reported, fix in new commit
git commit -sS -m "app-misc/metetch: fix [issue description]"
git push --signed origin dev
```

---

## 8.3 Prepare Stabilization Commit

After testing period (30+ days), create stabilization commit:

```bash
cd guru

# Edit the ebuild to change keywords
nano app-misc/metetch/metetch-0.5.3.ebuild
```

### Change Keywords Line

Find this line:
```bash
KEYWORDS="~amd64"
```

Change to:
```bash
KEYWORDS="amd64"
```

(Remove the `~` tilde to mark as stable)

---

## 8.4 Stage Stabilization Changes

Prepare commit:

```bash
cd guru

# Stage the modified file
git add app-misc/metetch/metetch-0.5.3.ebuild

# Verify changes
git diff --cached app-misc/metetch/metetch-0.5.3.ebuild

# Should show keywords changing from ~amd64 to amd64
```

---

## 8.5 Create Stabilization Commit

Commit the stabilization:

```bash
cd guru

# Commit with proper message
pkgdev commit --signoff

# Message should be:
# app-misc/metetch: stabilize 0.5.3 for amd64
# 
# Successfully tested by GURU community for [X days].
# No reported issues or compatibility problems.
```

---

## 8.6 Verify Stabilization Commit

Check the commit:

```bash
cd guru

# Show stabilization commit
git log -1 --show-signature

# Should show:
# app-misc/metetch: stabilize 0.5.3 for amd64
# (message)
# (GPG signature)
```

---

## 8.7 Push Stabilization

Push to GURU:

```bash
cd guru

# Push with pkgdev
pkgdev push -A

# Or manually
git push --signed origin dev
```

---

## 8.8 Verify on Remote

Check stabilization is live:

```bash
# Fetch remote
git fetch origin

# Check remote version
git show origin/dev:app-misc/metetch/metetch-0.5.3.ebuild | grep KEYWORDS

# Should show: KEYWORDS="amd64" (without tilde)
```

---

## 8.9 Create New Version Commit (Optional)

For next development version:

```bash
cd guru

# Create metetch-0.5.4_p1.ebuild (live development version)
cp app-misc/metetch/metetch-0.5.3.ebuild \
   app-misc/metetch/metetch-0.5.4_p1.ebuild

# Edit for live version
nano app-misc/metetch/metetch-0.5.4_p1.ebuild

# Make it fetch from git:
# SRC_URI="https://github.com/techoraye/metetch/archive/refs/heads/dev.tar.gz"
# KEYWORDS="" (empty for development)

git add app-misc/metetch/metetch-0.5.4_p1.ebuild
git commit -sS -m "app-misc/metetch: add live version 0.5.4_p1"
```

---

## 8.10 Monitor After Stabilization

After stabilization is active:

```bash
# Check Portage includes your package
emerge --search metetch

# Should show stable version available:
# app-misc/metetch-0.5.3
# [amd64] (not tilde)

# Test installation
sudo emerge --ask app-misc/metetch

# Should install without ~amd64 keyword
```

---

## 8.11 Announce Stabilization

Optional: Announce the milestone

```bash
# Post to:
# - GitHub releases page
# - GURU project
# - Your personal blog/website

# Mention:
# - Available in GURU
# - Installation: emerge app-misc/metetch
# - GitHub link
```

---

## 8.12 Create Stabilization Documentation

Document the process:

```bash
cat > guru-guide/STABILIZATION_COMPLETE.txt << 'EOF'
Stabilization Complete
======================

Package: app-misc/metetch-0.5.3
Status: STABLE (amd64)
Date: $(date)

Timeline:
- Initial submission: [Date from Step 7]
- Testing period: 30+ days
- Stabilization commit: $(date)

Install Command:
  emerge app-misc/metetch

Previous Status: ~amd64 (testing)
Current Status: amd64 (stable)

Checklist:
✓ Tested by community
✓ No issues reported
✓ Keywords updated
✓ Commit pushed to GURU
✓ Available via Portage

Next Steps:
- Monitor for any reported issues
- Prepare version 0.5.4 when ready
- Consider submitting to official Gentoo repo
EOF
```

---

## 8.13 Consider Gentoo Tree Submission

After proven stability in GURU:

```bash
# Optional: Submit to official Gentoo Portage tree
# Process similar but stricter requirements

# Steps:
# 1. File enhancement request on Bugzilla
# 2. Reference successful GURU history
# 3. Follow official repo submission process
# 4. Will need Bugzilla karma first
```

---

## 8.14 Maintain Package

Keep package updated:

```bash
# For new upstream release:
# 1. Download new version
# 2. Create new ebuild file
# 3. Update Manifest
# 4. Commit and push
# 5. After testing, stabilize

# For bug fixes:
# 1. Apply fix in new commit
# 2. Increment revision if needed
# 3. Update Manifest
# 4. Push and test
# 5. Stabilize after verification
```

---

## Summary Checklist

For stabilization, verify:

- ✅ 30+ days testing completed
- ✅ No critical issues reported
- ✅ Keywords changed from ~amd64 to amd64
- ✅ Stabilization commit created
- ✅ Commit properly GPG signed
- ✅ Changes pushed to GURU
- ✅ Changes visible on remote
- ✅ Package installation works without keywords

---

## Next Steps

After stabilization:
- Continue maintaining the package
- Monitor for issues
- Release new versions as needed
- Consider official Gentoo submission for wide availability

---

**Last Updated**: December 23, 2025
**Status**: Ready
