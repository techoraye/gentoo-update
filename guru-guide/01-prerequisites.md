# Step 1: Prerequisites Setup

Before you can submit to GURU, you need to set up several prerequisites.

## 1.1 Generate SSH Key

SSH key is needed to access `git@git.gentoo.org`

```bash
# Generate ED25519 key (recommended)
ssh-keygen -t ed25519 -f ~/.ssh/gentoo_rsa -C "your.email@example.com"

# Press Enter twice to accept defaults (no passphrase recommended for automation)
# Output files:
# - ~/.ssh/gentoo_rsa (private key - KEEP SECRET)
# - ~/.ssh/gentoo_rsa.pub (public key - upload to Gentoo)
```

### Verify SSH Key Created
```bash
ls -la ~/.ssh/gentoo_rsa*
# Should show two files with proper permissions (600 for private)
```

### Copy Public Key Content
```bash
cat ~/.ssh/gentoo_rsa.pub
# This will be needed when filing the access request
```

---

## 1.2 Generate OpenPGP Key

OpenPGP key is used to sign commits and push certificates (follows GLEP 63).

### Check if You Have Existing GPG Key
```bash
gpg --list-secret-keys --keyid-format=long
```

If you see output with `sec`, skip to Step 1.3.

### Generate New GPG Key (if needed)
```bash
gpg --full-generate-key
```

Follow the prompts:
1. **Key Type**: Select `(1) RSA and RSA` (or `(4) RSA`for signing/encryption)
2. **Key Size**: Enter `4096` (or `3072` minimum)
3. **Validity**: Enter `0` (no expiration) or `2y` (2 years)
4. **Name**: Enter your full legal name (first and last)
5. **Email**: Enter your email address
6. **Comment**: Leave empty or add descriptive text
7. **Passphrase**: Enter a strong passphrase (you'll type this often!)

Example:
```
pub   rsa4096 2025-12-23 [SC]
      ABCDEF1234567890ABCDEF1234567890ABCDEF12
uid           [ultimate] Your Name <your.email@example.com>
```

---

## 1.3 Find Your GPG Key Fingerprint

You'll need this for Git configuration.

```bash
gpg --list-secret-keys --keyid-format=long
```

Look for the line starting with `sec`. The long string on the second line is your fingerprint.

Example:
```
sec   rsa4096/CEE8A848A290423D 2025-12-24 [SC]
      BBA8B835D4B52D807B14FB0ECEE8A848A290423D
uid                 [ultimate] Mathieu Roberge <contact.techoraye@gmail.com>
```

**Copy the fingerprint**: `BBA8B835D4B52D807B14FB0ECEE8A848A290423D`

---

## 1.4 Test GPG Key

Verify your GPG key works:

```bash
# Create a test file
echo "test" > test.txt

# Sign it with your key (replace with your actual fingerprint)
gpg --sign --armor --local-user BBA8B835D4B52D807B14FB0ECEE8A848A290423D test.txt

# Should output: test.txt.asc (and prompt for passphrase)
ls -la test.txt*

# Verify signature
gpg --verify test.txt.asc

# Should show: Good signature from "Mathieu Roberge <contact.techoraye@gmail.com>"
# (exact name/email will match your key)

# Cleanup
rm test.txt test.txt.asc
```

**Note**: If you get `No pinentry` error:
```bash
# Launch gpg-agent first
eval $(gpg-agent --daemon)

# Then retry the signing command
gpg --sign --armor --local-user BBA8B835D4B52D807B14FB0ECEE8A848A290423D test.txt
```

**Warning about "not a detached signature"**: This is normal. The command creates a combined signature file (content + signature together). For Git commits, this is fine.

---

## 1.4b Change Your GPG Passphrase

If you forgot your passphrase or want to change it:

```bash
# Edit your GPG key
gpg --edit-key BBA8B835D4B52D807B14FB0ECEE8A848A290423D
```

At the `gpg>` prompt, type:
```
passwd
```

Then follow the prompts:
1. Enter your **current passphrase** (if you remember it)
2. Enter your **new passphrase** twice
3. Type `save` to exit

**If you forgot your passphrase:**
```bash
# You'll need to delete and regenerate the key
gpg --delete-secret-key BBA8B835D4B52D807B14FB0ECEE8A848A290423D
gpg --full-generate-key
# (Start over with key generation)
```

---

## 1.4c Useful GPG Commands

### Export Your Public Key
```bash
# Save your public key to share with others
gpg --export --armor BBA8B835D4B52D807B14FB0ECEE8A848A290423D > my-key.asc

# Upload to public keyserver (optional)
gpg --keyserver keys.openpgp.org --send-keys BBA8B835D4B52D807B14FB0ECEE8A848A290423D
```

### View Key Details
```bash
# Show full key information
gpg --list-keys --keyid-format=long BBA8B835D4B52D807B14FB0ECEE8A848A290423D

# Shows:
# - Key type and size
# - Creation date
# - Expiration (if set)
# - Subkeys for encryption
# - User IDs
```

### Check Key Expiration
```bash
# List all keys with expiration info
gpg --list-keys --with-colons

# If your key expires soon, extend it:
gpg --edit-key BBA8B835D4B52D807B14FB0ECEE8A848A290423D
# Then type: expire
# Then enter new expiration (e.g., 5y for 5 years)
# Then type: save
```

### Sign Someone Else's Key (Web of Trust)
```bash
# Verify identity then sign their key
gpg --sign-key [THEIR-KEY-ID]

# This vouches for their identity
# Helps establish trust in the community
```

### Decrypt Messages Signed by Others
```bash
# If you receive a signed message
gpg --verify signed-message.asc

# Or if it's a detached signature
gpg --verify signature.sig original-file.txt
```

### Trust Settings
```bash
# Edit key trust level
gpg --edit-key BBA8B835D4B52D807B14FB0ECEE8A848A290423D
# Type: trust
# Choose: 5 (ultimate trust - for your own key)

# This prevents "unknown trust" warnings
```

### Add Additional User IDs (emails)
```bash
# If you want multiple email addresses on same key
gpg --edit-key BBA8B835D4B52D807B14FB0ECEE8A848A290423D
# Type: adduid
# Follow prompts to add another email
# Type: save
```

---

## 1.4d GPG Best Practices

### Security
- ✅ Use strong passphrase (20+ characters, mix of types)
- ✅ Keep passphrase private (don't write down or commit!)
- ✅ Use gpg-agent to cache passphrase
- ✅ Regularly backup your secret key
- ❌ Don't share your secret key file
- ❌ Don't use same passphrase for multiple accounts

### Backup Your Secret Key
```bash
# Export secret key (keep in VERY secure location)
gpg --export-secret-key --armor BBA8B835D4B52D807B14FB0ECEE8A848A290423D > secret-key-backup.asc

# Store this file:
# - Encrypted (password protect with 7zip/GPG)
# - Offline backup (USB drive, external disk)
# - Multiple secure locations
# - NOT in Git or cloud storage!

# To restore from backup:
gpg --import secret-key-backup.asc
```

### Key Expiration Strategy
```bash
# Expiring keys provides security through rotation
# Common options:
# - 2 years: Good for most users, prevents old key misuse
# - 5 years: Less hassle, still reasonable rotation
# - Never: Higher maintenance, but some prefer it

# When key expires:
# 1. You can still decrypt old messages
# 2. Others can't encrypt to your key anymore
# 3. Extend expiration OR generate new key
# 4. Upload updated key to keyserver
```

---

## 1.5 Install Required Tools

Install necessary Gentoo development tools:

```bash
# Essential tools
sudo emerge --ask dev-util/pkgdev dev-util/pkgcheck

# Optional but recommended (QA checks via git hook)
sudo emerge --ask dev-util/pkgcruft dev-vcs/pkgcruft-git
```

### Verify Installation
```bash
pkgdev --version
pkgcheck --version
```

---

## 1.6 Configure Git Globally (Optional)

If you haven't configured Git globally, do this once:
Mathieu Roberge"
git config --global user.email "contact.techoraye@gmail.com"

# Set GPG signing key globally (use your fingerprint)
git config --global user.signingkey BBA8B835D4B52D807B14FB0ECEE8A848A290423D

# Set GPG signing key globally (optional)
git config --global user.signingkey ABCDEF1234567890ABCDEF1234567890ABCDEF12

# Verify global config
git config --global --list
```

---

## 1.7 Create Gentoo Account (if needed)

If you don't have a Gentoo account yet:

1. Visit: https://bugs.gentoo.org/userprefs.cgi?tab=account
2. Click "Create a new account"
3. Enter your email address
4. Check your email for confirmation link
5. Set your password and preferences

---

## Summary Checklist

Before proceeding to Step 2, verify:

- ✅ SSH key generated (`~/.ssh/gentoo_rsa`)
- ✅ OpenPGP key generated and available
- ✅ GPG fingerprint noted down
- ✅ SSH and GPG key working (tested)
- ✅ pkgdev and pkgcheck installed
- ✅ Git configured with user name and email
- ✅ Gentoo account created (if first time)

---

## Next Steps

Once prerequisites are complete, proceed to:
**[Step 2: Repository Setup](02-repository-setup.md)**

---

**Last Updated**: December 23, 2025
**Status**: Ready
