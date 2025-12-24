# Step 10: Troubleshooting

Common issues and solutions for GURU submission process.

## SSH Connection Issues

### Problem: SSH Connection Refused

```
ssh: connect to host git.gentoo.org port 22: Connection refused
```

**Solution:**

```bash
# 1. Test basic connectivity
ping git.gentoo.org
# Should get responses

# 2. Check SSH daemon is running
ssh-add -l
# Should list your key

# 3. Test with verbose output
ssh -vvv -i ~/.ssh/gentoo_rsa git@git.gentoo.org
# Shows where connection fails

# 4. Verify key is readable
ls -la ~/.ssh/gentoo_rsa
# Should show -rw------- (600)

# 5. Try port 22 explicitly
ssh -p 22 git@git.gentoo.org
```

---

### Problem: Permission Denied (publickey)

```
git@git.gentoo.org: Permission denied (publickey)
```

**Solution:**

```bash
# 1. Verify public key on git.gentoo.org
# (File access request with correct key)

# 2. Check which key is being used
ssh -i ~/.ssh/gentoo_rsa -v git@git.gentoo.org
# Watch debug output for which key is tried

# 3. Ensure IdentitiesOnly is set correctly
# In ~/.ssh/config:
Host git.gentoo.org
    IdentitiesOnly yes
    IdentityFile ~/.ssh/gentoo_rsa

# 4. Test with explicit key
ssh -i ~/.ssh/gentoo_rsa git@git.gentoo.org

# 5. If still fails, regenerate key and resubmit in access request
ssh-keygen -t ed25519 -f ~/.ssh/gentoo_rsa_new
cat ~/.ssh/gentoo_rsa_new.pub
# (File new access request with new key)
```

---

### Problem: Host Key Verification Failed

```
Host key verification failed
```

**Solution:**

```bash
# 1. Accept host key
ssh git.gentoo.org
# Type: yes

# 2. Or add to known_hosts manually
ssh-keyscan -t ed25519 git.gentoo.org >> ~/.ssh/known_hosts

# 3. Verify known_hosts entry
cat ~/.ssh/known_hosts | grep git.gentoo.org

# 4. Retry SSH connection
ssh git@git.gentoo.org
```

---

## GPG/Signing Issues

### Problem: GPG Key Not Found

```
error: gpg failed to sign the data
fatal: failed to write commit object
```

**Solution:**

```bash
# 1. List available GPG keys
gpg --list-secret-keys

# 2. If no keys, generate new key
gpg --full-generate-key

# 3. Set signing key in Git config
git config --local user.signingkey [KEY-FINGERPRINT]

# 4. Verify key is set
git config --local user.signingkey

# 5. Test signing
echo "test" | gpg --sign
```

---

### Problem: GPG Passphrase Required Every Commit

**Solution:**

```bash
# 1. Use gpg-agent (automatic)
eval $(gpg-agent --daemon)

# 2. Or add to shell config (~/.bashrc or ~/.zshrc)
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# 3. Or cache passphrase
gpg --pinentry-mode loopback -s test
# (not recommended for security)

# 4. Configure gpg-agent timeout
nano ~/.gnupg/gpg-agent.conf
# Add: default-cache-ttl 3600
# Restart: gpg-agent --kill-all; gpg-agent --daemon
```

---

### Problem: GPG Key Expired

```
error: key is already used for signing a different commit
```

**Solution:**

```bash
# 1. Check key expiration
gpg --list-keys

# 2. Extend key expiration
gpg --edit-key [KEY-ID]
# Type: expire
# Follow prompts
# Type: save

# 3. Upload extended key to keyserver (optional)
gpg --keyserver keys.openpgp.org --send-keys [KEY-ID]
```

---

## Git Issues

### Problem: Merge Conflicts When Pulling

```
error: Your local changes to ... would be overwritten by merge
```

**Solution:**

```bash
# 1. Use configured rebase strategy
git pull --rebase

# 2. If conflicts appear
git status
# Shows conflicted files

# 3. Resolve conflicts manually
nano [conflicted-file]
# Fix markers: <<<<<<, ======, >>>>>>

# 4. Mark as resolved
git add [conflicted-file]

# 5. Complete rebase
git rebase --continue

# 6. Or abort if too complex
git rebase --abort
```

---

### Problem: Branch Tracking Incorrect

```
fatal: The current branch dev has no upstream branch
```

**Solution:**

```bash
# 1. Set upstream branch
git branch --set-upstream-to=origin/dev dev

# 2. Or set when pulling
git pull --set-upstream origin dev

# 3. Verify tracking
git branch -vv
# Should show: dev ... origin/dev

# 4. Check remote
git remote -v
# Should show correct URLs
```

---

### Problem: Commit Not Showing in Log

```
# Commit lost after rebase
```

**Solution:**

```bash
# 1. Check reflog
git reflog

# 2. Find lost commit SHA
git show [COMMIT-SHA]

# 3. Recover lost commit
git cherry-pick [COMMIT-SHA]

# 4. Or reset to before lost operation
git reset --hard [REFLOG-ENTRY]
```

---

## Manifest Issues

### Problem: Manifest Generation Fails

```
ebuild ... manifest
# Error during manifest generation
```

**Solution:**

```bash
# 1. Remove old Manifest
cd guru/app-misc/metetch
rm Manifest

# 2. Generate with verbose output
ebuild metetch-0.5.3.ebuild manifest --verbose

# 3. Check source URL is correct
grep "^SRC_URI=" metetch-0.5.3.ebuild

# 4. Test URL manually
wget -O /tmp/test.tar.gz \
  https://github.com/techoraye/metetch/archive/refs/tags/v0.5.3.tar.gz

# 5. If download fails, verify:
# - GitHub URL is correct
# - Release exists
# - Network connectivity OK
```

---

### Problem: Manifest Checksum Mismatch

```
ebuild: checksum failed
```

**Solution:**

```bash
# 1. Remove cached file
rm /var/cache/distfiles/metetch-0.5.3.tar.gz

# 2. Regenerate manifest
ebuild metetch-0.5.3.ebuild manifest

# 3. Verify new checksums
cat Manifest | grep metetch-0.5.3.tar.gz

# 4. Compare with original
# If mismatches, upstream tarball may have changed
```

---

## QA Check Issues

### Problem: pkgcheck Fails with Errors

```
ERROR: app-misc/metetch: ...
```

**Solution:**

```bash
# 1. Show detailed error
pkgcheck scan --verbose app-misc/metetch/

# 2. Fix common issues:

# Missing dependency:
# - Add to DEPEND/RDEPEND in ebuild

# Invalid URI:
# - Check URL format and accessibility

# Invalid license:
# - Use standard Gentoo license name

# Unwanted spaces:
# - Fix indentation/whitespace in ebuild

# 3. Re-run check after fix
pkgcheck scan app-misc/metetch/
```

---

### Problem: pkgcheck Network Checks Timeout

```
pkgcheck: network operation timed out
```

**Solution:**

```bash
# 1. Run without network checks
pkgcheck scan app-misc/metetch/

# 2. Check network connectivity
ping github.com

# 3. Run with longer timeout
pkgcheck scan --timeout 30 app-misc/metetch/

# 4. Check status of GitHub
# Visit: https://www.githubstatus.com/

# 5. Retry later
```

---

## Installation Testing Issues

### Problem: emerge Fails During Build

```
make[1]: *** [CMakeFiles/metetch.dir/...] Error 1
```

**Solution:**

```bash
# 1. Check C++ compiler
g++ --version

# 2. Verify dependencies installed
pkg-config --exists ncurses curl cmake

# 3. Check build logs for details
cat /var/tmp/portage/app-misc/metetch-0.5.3/temp/build.log

# 4. Manually test build
cd /var/tmp/portage/app-misc/metetch-0.5.3/work/metetch-0.5.3
mkdir build && cd build
cmake ..
make

# 5. See detailed error
make VERBOSE=1
```

---

### Problem: Binary Won't Run

```
/usr/bin/metetch: error while loading shared libraries: ...
```

**Solution:**

```bash
# 1. Check dependencies
ldd /usr/bin/metetch

# 2. Install missing library
# Library name from ldd output
emerge --ask [missing-package]

# 3. Verify library path
ldconfig -p | grep [library-name]

# 4. Set library path if needed
export LD_LIBRARY_PATH=/usr/lib:$LD_LIBRARY_PATH
/usr/bin/metetch
```

---

## Access Request Issues

### Problem: Access Request Takes Too Long

```
# More than 3 weeks, no response
```

**Solution:**

```bash
# 1. Add comment to original bug
# Visit: https://bugs.gentoo.org/[BUG-NUMBER]
# Click "Add Comment"
# Politely request status update

# 2. Contact via IRC
# Join #gentoo-dev on irc.libera.chat
# Ask about access request status

# 3. Verify details were correct
# Re-check SSH key is in request
# Verify GPG fingerprint is correct
# Confirm email address is valid
```

---

### Problem: Access Request Denied

```
# Request closed/rejected
```

**Solution:**

```bash
# 1. Read response for reason

# 2. Common reasons and fixes:
# - Incomplete information: File new request with complete info
# - No Gentoo account: Create account on bugs.gentoo.org first
# - Invalid SSH key format: Regenerate with correct algorithm
# - GPG key issues: Verify key exists and is valid
# - Community concerns: Provide more context/experience details

# 3. File follow-up
# Comment on original bug explaining fixes
# Or file new enhanced request
```

---

## Push Issues

### Problem: Push Rejected - Pre-push Hook Failed

```
error: hooks/pre-push exited with error code 1
```

**Solution:**

```bash
# 1. Run pkgcheck manually
pkgcheck scan --net app-misc/metetch/

# 2. Fix QA issues found

# 3. Regenerate Manifest if needed
ebuild metetch-0.5.3.ebuild manifest

# 4. Add fixed files
git add app-misc/metetch/

# 5. Amend commit
git commit --amend -S

# 6. Retry push
git push --signed origin dev
```

---

### Problem: Push Fails - Non-Fast-Forward

```
error: failed to push some refs to ...
```

**Solution:**

```bash
# 1. Someone else pushed changes
git pull --rebase origin dev

# 2. Resolve any conflicts
# (same as merge conflicts above)

# 3. Retry push
git push --signed origin dev
```

---

## General Troubleshooting Steps

### When Something Goes Wrong:

```bash
# 1. Check Git status
cd guru
git status

# 2. Check configuration
git config --local --list

# 3. See recent history
git log --oneline -10

# 4. Check for errors
git log -1 --show-signature

# 5. Verify SSH works
ssh git@git.gentoo.org

# 6. Run full diagnostics
pkgdev check --commits
pkgcheck scan --net app-misc/metetch/

# 7. Check online resources
# - https://wiki.gentoo.org/wiki/Project:GURU
# - https://devmanual.gentoo.org/
# - https://bugs.gentoo.org/ (search issues)
```

---

## Getting Help

### If Troubleshooting Doesn't Work:

```bash
# 1. Check this guide again
# Re-read relevant step

# 2. Search online
# Google: "gentoo [error message]"
# Gentoo Wiki: wiki.gentoo.org
# GitHub Issues: github.com/gentoo/guru/issues

# 3. Ask community
# Gentoo Forums: forums.gentoo.org
# IRC: #gentoo on irc.libera.chat
# Bugzilla: bugs.gentoo.org

# 4. File issue
# Create bug on Bugzilla describing problem
# Include:
# - What command failed
# - Full error message
# - What you've already tried
# - System information (uname -a)
```

---

## Summary

Most common issues and solutions are documented here. When in doubt:
1. **Read error message carefully** - usually tells you what's wrong
2. **Check Git/GPG configuration** - most issues are config-related
3. **Test individually** - SSH, GPG, Git, Portage separately
4. **Search documentation** - Gentoo Wiki has extensive guides
5. **Ask community** - Gentoo developers are helpful

---

**Last Updated**: December 23, 2025
**Status**: Complete Troubleshooting Guide
