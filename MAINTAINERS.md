# Maintainers

## Project Lead

**Mathieu Roberge (Techoraye)**
- Email: robergem2008@gmail.com
- GitHub: [@Techoraye](https://github.com/Techoraye)
- Role: Creator and primary maintainer

## Contributing Maintainers

Currently seeking additional maintainers to help with:
- Code review and testing
- Documentation improvements
- Feature development
- Community support

If you're interested in becoming a maintainer, please open an issue or contact the project lead.

## Release Process

### Version Numbering

This project follows [Semantic Versioning](https://semver.org/):
- MAJOR version for incompatible API changes
- MINOR version for new functionality in a backwards compatible manner
- PATCH version for backwards compatible bug fixes

### Release Checklist

1. Update version number in:
   - `CMakeLists.txt`
   - `gentoo-update.cpp` (version variable)
   - `CHANGELOG.md`

2. Create release branch: `git checkout -b release/v0.x.x`

3. Make version updates and tag: `git tag -a v0.x.x -m "Release v0.x.x"`

4. Create GitHub release with changelog

5. Merge back to main

## Support

For questions or issues, please use:
- GitHub Issues: [Report a bug](https://github.com/Techoraye/gentoo-update/issues)
- Discussions: [Ask a question](https://github.com/Techoraye/gentoo-update/discussions)

## Code of Conduct

All contributors must follow our Code of Conduct. Violations can be reported to the project maintainers.
