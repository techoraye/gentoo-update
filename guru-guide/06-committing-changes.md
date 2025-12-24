# Step 6: Committing Changes

Create proper Git commits with signed signatures for submission.

## 6.1 Check Git Status

See what files need to be committed:

```bash
cd guru

# Show changes
git status

# Expected output:
# Untracked files:
#   app-misc/metetch/
```

---

## 6.2 Stage Files

Add the new package to Git:

```bash
cd guru

# Stage the entire metetch package
git add app-misc/metetch/

# Verify staging
git status

# Expected output:
# Changes to be committed:
#   new file:   app-misc/metetch/metetch-0.5.3.ebuild
#   new file:   app-misc/metetch/metadata.xml
#   new file:   app-misc/metetch/Manifest
```

---

## 6.3 Verify Staged Files

Review what will be committed:

```bash
cd guru

# Show diff of staged changes
git diff --cached

# Or show file list
git diff --cached --name-only

# Expected:
# app-misc/metetch/metetch-0.5.3.ebuild
# app-misc/metetch/metadata.xml
# app-misc/metetch/Manifest
```

---

## 6.4 Write Commit Message

Prepare a proper Gentoo-style commit message:

### Format
```
category/package: brief description

Longer explanation of what was changed and why.
Can span multiple lines.

Signed-off-by: Your Name <your.email@example.com>
```

### Example for Metetch
```
app-misc/metetch: add metetch-0.5.3 from guru

Metetch is a fast, minimal system information display utility written in C++.
It provides customizable feature presets (Default, Minimal, Full) for
displaying system information including CPU, GPU, memory, disk, network,
battery status, and more.

Features:
- Interactive configuration menu with preset editors
- KDE Plasma 6 inspired color palette
- Modular architecture with ~13 customizable features
- Supports three presets: Default (full), Minimal (compact), Full (everything)
- Fast rendering with proper terminal handling

Signed-off-by: Your Name <your.email@example.com>
```

---

## 6.5 Commit Using pkgdev (Recommended)

Use pkgdev for automatic commit generation:

```bash
cd guru

# Generate commit with automatic signoff
pkgdev commit --signoff

# This will:
# 1. Open editor for commit message
# 2. Auto-add Signed-off-by line
# 3. Sign commit with GPG key
# 4. Complete the commit
```

### What pkgdev Commit Does
- ✓ Auto-formats commit message
- ✓ Adds Signed-off-by line
- ✓ Signs with GPG key
- ✓ Validates ebuild syntax
- ✓ Runs quick QA checks

---

## 6.6 Manual Commit (Alternative)

If pkgdev is unavailable:

```bash
cd guru

# Create commit with manual message
git commit -sS -m "app-misc/metetch: add metetch-0.5.3 from guru

Fast system information display utility with customizable feature presets.
Includes Default, Minimal, and Full preset configurations.

Signed-off-by: Your Name <your.email@example.com>"

# Flags explained:
# -s = Add Signed-off-by line
# -S = Sign commit with GPG key (requires git.commit.gpgsign=true)
```

---

## 6.7 Verify Commit

Check the commit was created properly:

```bash
cd guru

# Show latest commit
git log -1 --format=fuller

# Expected output:
# commit abc123def456... (HEAD -> dev)
# Author:     Your Name <your.email@example.com>
# AuthorDate: Thu Dec 23 10:00:00 2025 +0000
# Commit:     Your Name <your.email@example.com>
# CommitDate: Thu Dec 23 10:00:00 2025 +0000
# 
#     app-misc/metetch: add metetch-0.5.3 from guru
#     ...
```

---

## 6.8 Verify GPG Signature

Check that commit is properly signed:

```bash
cd guru

# Show commit with signature status
git log -1 --show-signature

# Expected output:
# gpg: Good signature from "Your Name <your.email@example.com>"
# gpg: Signature made Thu Dec 23 10:00:00 2025 +0000
```

### If Signature Failed
```bash
# Check if GPG key is accessible
gpg --list-secret-keys

# Re-sign the commit (if needed)
git commit --amend -S

# Or configure GPG key
git config --local user.signingkey YOUR-FINGERPRINT
```

---

## 6.9 Show Commit Diff

Review full changes in the commit:

```bash
cd guru

# Show commit details
git show HEAD

# Or with statistics
git show --stat HEAD

# Expected output:
# +++ app-misc/metetch/metetch-0.5.3.ebuild
# +++ app-misc/metetch/metadata.xml
# +++ app-misc/metetch/Manifest
# (and the full diff)
```

---

## 6.10 Check Commit Message Format

Verify commit message follows Gentoo standards:

```bash
cd guru

# Show just the commit message
git log -1 --format="%B"

# Checklist:
# ✓ Starts with category/package: description
# ✓ Blank line after first line
# ✓ Longer explanation included
# ✓ Signed-off-by line present
# ✓ GPG signed
```

---

## 6.11 Correct Commit If Needed

If you need to fix the commit:

```bash
cd guru

# Amend the last commit (only if not pushed yet)
git commit --amend -S

# This opens your editor to change message
# Save with Ctrl+O, Enter, Ctrl+X (nano)
# Or :wq (vim)
```

---

## 6.12 Create Multiple Commits (Optional)

If updating multiple packages, create separate commits:

```bash
cd guru

# For each package
git add app-misc/new-package1/
git commit -sS -m "app-misc/new-package1: add version X.Y.Z"

git add app-misc/new-package2/
git commit -sS -m "app-misc/new-package2: add version A.B.C"

# Check all commits
git log --oneline -3
```

---

## 6.13 Verify Against Origin

Ensure local commit is ahead of remote:

```bash
cd guru

# Check branch status
git status

# Expected output:
# On branch dev
# Your branch is ahead of 'origin/dev' by 1 commit.

# Show commits ahead
git log origin/dev..dev --oneline

# Should show your new commit(s)
```

---

## 6.14 Document Commit Information

Save commit details:

```bash
# Save commit info
cat > guru-guide/COMMIT_INFO.txt << 'EOF'
Commit Information
==================

Branch: dev
Commit Hash: $(git log -1 --format=%H)
Commit Date: $(git log -1 --format=%aI)
Author: $(git log -1 --format=%an)

Message:
$(git log -1 --format=%B)

Files Changed:
$(git show --name-only --oneline)

Status: Ready for Push
EOF

cat guru-guide/COMMIT_INFO.txt
```

---

## Summary Checklist

Before proceeding to Step 7, verify:

- ✅ All package files staged
- ✅ Commit message follows Gentoo format
- ✅ Commit message includes description
- ✅ Signed-off-by line present
- ✅ Commit is GPG signed
- ✅ Signature verifies correctly
- ✅ Commit visible in git log
- ✅ Local branch ahead of origin/dev

---

## Next Steps

Once commit is created, proceed to:
**[Step 7: Pushing to GURU](07-pushing-to-guru.md)**

---

**Last Updated**: December 23, 2025
**Status**: Ready
