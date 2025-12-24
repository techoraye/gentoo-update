# Step 7: Pushing to GURU

Submit your committed changes to the GURU repository.

## 7.1 Prepare for Push

Ensure everything is ready:

```bash
cd guru

# Check branch
git branch
# Should show: * dev

# Check commits
git log origin/dev..dev --oneline
# Should show your new commit(s)

# Verify status
git status
# Should show: Your branch is ahead of 'origin/dev' by 1 commit
```

---

## 7.2 Pull Latest Changes

Sync with remote before pushing:

```bash
cd guru

# Pull latest changes from origin with rebase
git pull --rebase

# Expected output:
# From git.gentoo.org:repo/proj/guru
# fast-forward updates (or no updates needed)
```

### If Conflicts Occur
```bash
# See conflicts
git status

# Resolve conflicts in affected files
nano [conflicted-file]

# After resolving:
git add [conflicted-file]
git rebase --continue
```

---

## 7.3 Verify Push Certificate Requirements

Ensure your GPG key is configured:

```bash
cd guru

# Check push.gpgsign setting
git config --local push.gpgsign
# Should output: true

# If not set:
git config --local push.gpgsign 1
```

### Why Push Certificates?
- Authenticates the push operation
- Proves author identity
- Required by GURU for commits
- Different from commit signatures

---

## 7.4 Push Using pkgdev (Recommended)

Automated push with validation:

```bash
cd guru

# Push with pkgdev
pkgdev push -A

# Flags:
# -A = Atomic operation (all or nothing)
# (automatically signs push certificate)
```

### What pkgdev Push Does
- ✓ Validates all commits
- ✓ Signs push certificate with GPG
- ✓ Checks for QA issues
- ✓ Performs atomic push
- ✓ Reports success/failure

---

## 7.5 Manual Push (Alternative)

If pkgdev unavailable:

```bash
cd guru

# Push with signed certificate
git push --signed origin dev

# Or without atomic (not recommended):
git push origin dev

# Flags:
# --signed = Sign the push certificate
# origin = Remote repository
# dev = Branch to push
```

---

## 7.6 Monitor Push Progress

Watch for push completion:

```bash
# After running push command, watch output:
# Enumerating objects: 4, done
# Counting objects: 100% (4/4), done
# Delta compression using up to 8 threads
# Compressing objects: 100% (3/3), done
# Writing objects: 100% (3/3), done
# Total 3 (delta 0), reused 0 (delta 0)
# remote: Resolving deltas: 100% (0/0), done
# To git.gentoo.org:repo/proj/guru.git
#    abc123..def456  dev -> dev
```

---

## 7.7 Verify Push Was Successful

Check that push completed:

```bash
cd guru

# Check local branch status
git status

# Should show:
# On branch dev
# Your branch is up to date with 'origin/dev'.

# List last few commits
git log --oneline -5

# Your commit should appear
```

### Push Verification Checklist
- ✓ No error messages in output
- ✓ Commit hash shows in "To" line
- ✓ No conflicts or rejections
- ✓ Local branch matches origin/dev

---

## 7.8 Verify Remote Changes

Check changes on remote repository:

```bash
# Fetch to update remote tracking
    git fetch origin

# Show commits in remote
git log origin/dev --oneline -3

# Should include your commit

# Or check on web:
# https://gitweb.gentoo.org/?p=repo/proj/guru.git
# (View the dev branch)
```

---

## 7.9 Handle Push Failures

If push fails, troubleshoot:

### Error: Pre-push hook failed
```bash
# Usually means QA check failed
# Run: pkgcheck scan --net app-misc/metetch/
# Fix issues then try push again
```

### Error: Permission denied
```bash
# SSH key issue (see Troubleshooting Step 1)
ssh -T git@git.gentoo.org  # Test SSH
```

### Error: Rejected (non-fast-forward)
```bash
# Pull with rebase first
git pull --rebase origin dev
# Then push again
```

---

## 7.10 Create Push Confirmation

Document successful push:

```bash
# Save push confirmation
cat > guru-guide/PUSH_CONFIRMATION.txt << 'EOF'
Push Confirmation
=================

Date: $(date)
Repository: git.gentoo.org:repo/proj/guru
Branch: dev
Package: app-misc/metetch-0.5.3

Commit Hash: $(git rev-parse HEAD)
Push Status: SUCCESS

Remote Status:
$(git log origin/dev -1 --oneline)

Verification:
✓ Push completed successfully
✓ Commit visible on remote
✓ Branch synchronized with origin

Next Step: File GURU Access Request (if first-time contributor)
EOF

cat guru-guide/PUSH_CONFIRMATION.txt
```

---

## 7.11 Notify GURU Project

If first-time contributor, file access request:

```bash
# Go to Gentoo Bugzilla
# https://bugs.gentoo.org/

# File new bug with:
# - Title: "Request GURU repository access for [Your Name]"
# - Component: GURU
# - Description: Include SSH public key and GPG fingerprint
```

See [Step 9: Access Request](09-access-request.md) for details.

---

## 7.12 Wait for Review

After pushing to dev branch:

```
Timeline:
- Immediately: Your commit on dev branch
- 1-7 days: Trusted contributor reviews
- Upon approval: Merged to master branch
- 30+ days: Testing period before stabilization
```

### You'll receive feedback via:
- GitHub issues
- Gentoo Bugzilla
- Email notifications
- Git commit messages

---

## 7.13 Check GURU CI/CD

Monitor automated checks:

```bash
# Check if your commit triggered CI
# Visit: https://github.com/gentoo/guru
# Navigate to Actions/Checks tab
# Look for your commit

# Or via email
# GURU automated emails should arrive
```

---

## 7.14 Update Local Tracking

Update local branch to match remote:

```bash
cd guru

# Fetch latest from remote
git fetch origin

# Update local tracking
git branch --set-upstream-to=origin/dev dev

# Verify
git status
# Should show: Your branch is up to date with 'origin/dev'
```

---

## Summary Checklist

Before proceeding to next steps, verify:

- ✅ Latest changes pulled with rebase
- ✅ Push completed without errors
- ✅ Commit visible on remote repository
- ✅ Local branch synchronized with origin/dev
- ✅ Push confirmation documented
- ✅ No QA check failures

---

## Next Steps

After successful push:
- **If first-time contributor**: [Step 9: Access Request](09-access-request.md)
- **For additional fixes**: [Step 6: Committing Changes](06-committing-changes.md)
- **For stabilization**: [Step 8: Stabilization](08-stabilization.md) (wait 30+ days first)

---

**Last Updated**: December 23, 2025
**Status**: Ready
