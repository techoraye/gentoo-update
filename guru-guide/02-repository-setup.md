# Step 2: Repository Setup

Set up your local GURU repository with proper Git configuration.

## 2.1 Clone GURU Repository

Clone the GURU repository (dev branch is where you commit):

```bash
# Clone GURU dev branch
git clone -b dev git@git.gentoo.org:repo/proj/guru.git

# Navigate to repository
cd guru

# Verify you're on dev branch
git branch
# Output should show: * dev
```

### Expected Output
```
Cloning into 'guru'...
remote: Counting objects: ...
Resolving deltas: 100% ...

On branch dev
Your branch is up to date with 'origin/dev'.
```

---

## 2.2 Configure Local Git Settings

These settings apply only to the GURU repository:

```bash
cd guru  # Make sure you're in the GURU repo directory

# Configure fast-forward only pulls (prevents merge commits)
git config --local pull.ff only

# Configure automatic rebase on pull
git config --local pull.rebase merges

# Enable GPG signing for commits
git config --local commit.gpgsign 1

# Enable GPG signing for push certificates
git config --local push.gpgsign 1

# Set your name (local override)
git config --local user.name "Mathieu Roberge"

# Set your email (local override)
git config --local user.email "robergem2008@gmail.com"

# Set GPG signing key (use your fingerprint from Step 1)
git config --local user.signingkey ABCDEF1234567890ABCDEF1234567890ABCDEF12
```

### Verify Local Configuration
```bash
git config --local --list

# Should show something like:
# pull.ff=only
# pull.rebase=merges
# commit.gpgsign=true
# push.gpgsign=true
# user.name=Your Full Name
# user.email=your.email@example.com
# user.signingkey=ABCDEF1234567890ABCDEF1234567890ABCDEF12
```

---

## 2.3 Test SSH Connection

Verify SSH key works with git.gentoo.org:

```bash
ssh -i ~/.ssh/gentoo_rsa -T git@git.gentoo.org
```

### Expected Output
```
Welcome to git.gentoo.org!
```

**If you get a Permission Denied error**: This is expected until your access is approved by Gentoo. Skip ahead to **Section 2.4** to set up SSH config, then file your access request in [Step 9](09-access-request.md).

---

## 2.4 Configure SSH Config (RECOMMENDED - Needed for git.gentoo.org)

Create `~/.ssh/config` to tell SSH to use your gentoo_rsa key for git.gentoo.org:

```bash
# Open or create SSH config
nano ~/.ssh/config

# Add this content:
Host git.gentoo.org
    HostName git.gentoo.org
    User git
    IdentityFile ~/.ssh/gentoo_rsa
    IdentitiesOnly yes
```

Save and close (Ctrl+O, Enter, Ctrl+X).

### What This Does
- **IdentityFile**: Tells SSH to use your gentoo_rsa key specifically for git.gentoo.org
- **IdentitiesOnly yes**: Prevents SSH from trying other keys first (avoids permission denied errors)
- This ensures Git uses the correct key without having to specify `-i ~/.ssh/gentoo_rsa` each time

### Set Correct Permissions
```bash
chmod 600 ~/.ssh/config
```

### Test SSH Connection Again
```bash
ssh git.gentoo.org
# Should connect without specifying identity file
```

---

## 2.5 Create Local Working Directory

Create a workspace for your package:

```bash
cd guru

# Create app-misc directory (category for system utilities)
mkdir -p app-misc/metetch

# List to verify
ls -la app-misc/
```

---

## 2.6 Copy Metetch Ebuild Files

Copy the prepared ebuild files:

```bash
# From your metetch project directory
cp /path/to/metetch/ebuild/app-misc/metetch/* guru/app-misc/metetch/

# Verify files
ls -la guru/app-misc/metetch/
# Should show:
# - metetch-0.5.3.ebuild
# - metadata.xml
```

---

## 2.7 Check Repository Status

Verify everything is set up:

```bash
cd guru

# Check current branch
git branch
# Output: * dev

# Check remote
git remote -v
# Output should show origin pointing to git.gentoo.org

# Check status
git status
# Output: On branch dev, Your branch is up to date with 'origin/dev'

# List categories
ls -d app-*/
# Should include app-misc
```

---

## 2.8 Verify Git Configuration

Double-check all settings:

```bash
cd guru

# Show local config
echo "=== Local Configuration ==="
git config --local --list

# Show global config
echo "=== Global Configuration ==="
git config --global --list

# Show system config
echo "=== System Configuration ==="
git config --system --list
```

---

## Summary Checklist

Before proceeding to Step 3, verify:

- ✅ GURU repository cloned in dev branch
- ✅ Local Git configuration applied
- ✅ SSH key working with git.gentoo.org
- ✅ SSH config created (optional)
- ✅ Working directory created (app-misc/metetch)
- ✅ Ebuild files copied
- ✅ Git configuration verified

---

## Next Steps

Once repository is set up, proceed to:
**[Step 3: Ebuild Preparation](03-ebuild-preparation.md)**

---

**Last Updated**: December 23, 2025
**Status**: Ready
