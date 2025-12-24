# Release Guidelines

## Version Numbering

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR**: Incompatible API or feature changes (e.g., 0.1.0 → 1.0.0)
- **MINOR**: Backward-compatible new features (e.g., 0.1.0 → 0.2.0)
- **PATCH**: Backward-compatible bug fixes (e.g., 0.1.0 → 0.1.1)

## Release Steps

1. **Prepare Release Branch**
   ```bash
   git checkout -b release/v0.x.x
   ```

2. **Update Version Numbers**
   - `CMakeLists.txt` - Update PROJECT version
   - `gentoo-update.cpp` - Update `version` variable
   - `CHANGELOG.md` - Add release notes
   - `README.md` - Update if needed

3. **Review Changes**
   - Run `git diff` to review all changes
   - Ensure CHANGELOG.md is accurate
   - Test compilation: `mkdir build && cd build && cmake .. && make`
   - Test commands: `./gentoo-update --help`, `./gentoo-update --version`

4. **Commit and Tag**
   ```bash
   git add -A
   git commit -m "Release v0.x.x"
   git tag -a v0.x.x -m "Release v0.x.x - Description"
   git push origin release/v0.x.x
   git push origin v0.x.x
   ```

5. **Create GitHub Release**
   - Go to GitHub → Releases → Draft new release
   - Select tag `v0.x.x`
   - Add release title and description from CHANGELOG
   - Include installation instructions
   - Mark as pre-release if applicable
   - Publish

6. **Merge Back to Main**
   ```bash
   git checkout main
   git merge release/v0.x.x
   git push origin main
   ```

## Changelog Format

Use [Keep a Changelog](https://keepachangelog.com/) format:

```markdown
## [0.x.x] - YYYY-MM-DD

### Added
- New features

### Changed
- Behavior changes

### Fixed
- Bug fixes

### Removed
- Removed features

### Security
- Security fixes
```

## Pre-Release Checklist

- [ ] All tests pass
- [ ] Code review completed
- [ ] Documentation updated
- [ ] Man pages updated if needed
- [ ] Completions updated if new options added
- [ ] Changelog updated
- [ ] Version numbers updated
- [ ] README examples still valid
- [ ] License headers current

## Post-Release

- Monitor issues for regressions
- Be ready for quick patch releases if needed
- Announce release if appropriate
- Update external references if needed

## Deprecation Policy

Features marked for deprecation:
1. Announced in release notes
2. Supported for at least 2 minor versions
3. Removed in next major version
4. Clear migration path provided

For questions about releases, see [MAINTAINERS.md](MAINTAINERS.md).
