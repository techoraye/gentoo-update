# Step 9: Access Request

File official access request to contribute to GURU.

## 9.1 Understand Access Requirements

GURU requires proper authorization before contributing:

- Valid SSH key (for git access)
- Valid OpenPGP key (for signed commits)
- Agreement to GURU project regulations
- Valid Gentoo account
- Preferably: Some prior Gentoo knowledge/experience

---

## 9.2 File Bug Report

Submit access request via Gentoo Bugzilla:

```
1. Go to: https://bugs.gentoo.org/enter_bug.cgi
2. Select "Repositories" as product
3. Select "GURU" as component
4. Title: "Request GURU repository access for [Your Name]"
5. Description: (see next section)
```

---

## 9.3 Write Access Request

Compose the request with required information:

```
Title: Request GURU repository access for Techoraye

Description:

I would like to contribute to the Gentoo GURU project.

Personal Information:
- Real Name: Techoraye
- Email: contact.techoraye@gmail.com
- Gentoo Account: [username if exists]
- Developer Background: [brief description]

SSH Public Key:
[Paste contents of ~/.ssh/gentoo_rsa.pub]

OpenPGP Fingerprint:
[Paste your GPG fingerprint from Step 1]
Example: ABCDEF1234567890ABCDEF1234567890ABCDEF12

Agreement:
I have read and agree to the GURU project regulations at:
https://wiki.gentoo.org/wiki/Project:GURU/Information_for_Contributors

I understand that:
- All commits must be properly signed
- Code must follow Gentoo standards (GLEP 66, etc.)
- I am responsible for maintaining packages I submit
- Inactive contributors may have access revoked after 2 years

Package(s) to Submit:
- app-misc/metetch-0.5.3 (already pushed to dev branch)

Additional Information:
[Any other relevant details]
```

---

## 9.4 Include SSH Public Key

Extract and paste your public key:

```bash
# Display SSH public key
cat ~/.ssh/gentoo_rsa.pub

# Copy entire output starting with "ssh-ed25519" or "ssh-rsa"
# Paste into bug report
```

### Example SSH Public Key
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAbc...xyz your.email@example.com
```

---

## 9.5 Include GPG Fingerprint

Get and include your GPG fingerprint:

```bash
# Display GPG fingerprint
gpg --list-secret-keys --keyid-format=long

# Look for the long ID like:
# sec   rsa4096/ABCDEF1234567890 2025-12-23 [SC]
#       ABCDEF1234567890ABCDEF1234567890ABCDEF12

# Copy the full fingerprint (second line)
```

### Example GPG Fingerprint
```
ABCDEF1234567890ABCDEF1234567890ABCDEF12
```

---

## 9.6 Verify Agreement to Regulations

Read GURU regulations:

https://wiki.gentoo.org/wiki/Project:GURU/Information_for_Contributors

Key points:
- ✓ Follow Gentoo development policies
- ✓ Ensure commits don't violate copyright
- ✓ Accept Certificate of Origin for each commit
- ✓ Maintain package standards
- ✓ Respond to review feedback

---

## 9.7 Submit Bug Report

Create the Bugzilla ticket:

```
1. Fill in all required fields
2. Review entire request for accuracy
3. Click "Commit" to submit
4. Note the bug number (e.g., #XXXXXX)
5. Save for reference
```

### After Submission
- You'll receive confirmation email
- GURU project admins will review
- May be contacted for clarification
- Access granted within 1-3 weeks typically

---

## 9.8 Wait for Approval

Timeline for approval:

```
1-3 days:  Initial review by admins
3-7 days:  May request additional info
7-14 days: Final decision
14-21 days: Access enabled if approved
```

### What Might Delay Approval
- Incomplete information
- SSH key format issues
- Gentoo account not verified
- Additional background questions

---

## 9.9 Receive Access Notification

When approved, you'll receive:

```
Email from: Gentoo Infrastructure
Subject: GURU repository access granted
Content: Instructions for next steps
```

### Email Typically Includes
- ✓ Confirmation of access grant
- ✓ Link to GURU wiki
- ✓ Commit guidelines
- ✓ Contact for future questions

---

## 9.10 Verify Access Works

Test your new access:

```bash
# Test SSH connection
ssh -T git@git.gentoo.org

# Expected response:
# Welcome to git.gentoo.org!

# Clone a test repo (if allowed)
git clone -b dev git@git.gentoo.org:repo/proj/guru.git guru-test
cd guru-test
git status
```

---

## 9.11 Update Bugzilla Email Settings

Configure Gentoo Bugzilla for notifications:

```
1. Visit: https://bugs.gentoo.org/userprefs.cgi?tab=email
2. Email Preferences section:
   - ✓ Enable email notifications
   - ✓ Add guru-bugs@gentoo.org to watch list
3. Save changes
```

### Why Subscribe to guru-bugs?
- Notified of all GURU project issues
- Receive feedback on your packages
- Know about security updates needing fixes

---

## 9.12 Join GURU Communication Channels

Connect with the GURU community:

```bash
# Option 1: GitHub Discussions
# https://github.com/gentoo/guru/discussions

# Option 2: Gentoo Forums
# https://forums.gentoo.org/

# Option 3: IRC (if interested)
# Server: irc.libera.chat
# Channel: #gentoo (general)
# Channel: #gentoo-dev (development)
```

---

## 9.13 Review Contributor Guidelines

Familiarize with expectations:

```
GURU Contributor Responsibilities:
- ✓ Maintain packages you submit
- ✓ Respond to QA issues
- ✓ Follow commit message format
- ✓ Sign all commits with GPG
- ✓ Include proper license documentation
- ✓ Keep metadata.xml updated
- ✓ Monitor for security issues
```

---

## 9.14 Create Contributor Profile

Set up for long-term contribution:

```bash
# Create contributor info file
cat > guru-guide/CONTRIBUTOR_PROFILE.txt << 'EOF'
GURU Contributor Profile
========================

Name: Techoraye
Email: contact.techoraye@gmail.com
GitHub: https://github.com/techoraye
GURU Access: [Date Approved]

Packages Maintained:
- app-misc/metetch (0.5.3+)

Communication:
- Email: contact.techoraye@gmail.com
- GitHub: @techoraye
- Bugzilla: [username]

Timezone: [Your Timezone]
Availability: [Your typical availability]

Skills:
- C++ development
- CMake build system
- System utilities
- Terminal/CLI tools

Interests:
- System monitoring
- Terminal applications
- Gentoo packaging
EOF
```

---

## Summary Checklist

Before filing request, verify:

- ✅ SSH key generated and tested
- ✅ GPG key generated and fingerprint noted
- ✅ Gentoo account created
- ✅ GURU regulations read and understood
- ✅ Bug report filled out completely
- ✅ SSH public key included
- ✅ GPG fingerprint included
- ✅ Agreement statement included
- ✅ Ready to submit request

---

## Next Steps

After access is approved:
- Your commit access becomes active
- Continue with normal contribution workflow
- See [Step 6-8](06-committing-changes.md) for ongoing commits
- Maintain high code quality and responsiveness

---

**Last Updated**: December 23, 2025
**Status**: Ready
