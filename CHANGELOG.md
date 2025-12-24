# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2] - 2025-12-24

### Fixed
- Notification tray now sends notifications on every update check
- Notifications now display when repository sync completes successfully
- Added notification on make install completion
- Improved tray monitoring feedback with interval display

## [0.1] - 2024-01-XX

### Added
- Initial release
- Full C++ implementation for Gentoo Linux package management
- Interactive update workflow
- Check-only mode with `--check` flag
- List pending updates with `--list`
- Display Gentoo news with `--news`
- Service status checking with `--services`
- Configuration management (`--gen-config`, `--show-config`, `--edit-config`)
- System tray support with `--tray`
- Color-coded output with disableable color support
- Configuration file support at `~/.config/gentoo-update/gentoo-update.conf`
- Automatic repository synchronization option
- Support for both systemd and OpenRC init systems
- Preserved rebuild detection
- Kernel update checking
- Configuration file change detection
- Package version retention settings
- Man page documentation
- Shell completions (bash, zsh, fish)
- Desktop entry files
- Systemd timer and service units
- OpenRC service file
- CMake build system
- Multiple privilege escalation methods (sudo, doas, sudo-rs, run0)

### Features
- Fast and efficient C++ implementation
- Modular architecture
- Comprehensive help and documentation
- Desktop notifications support
- Configurable behavior
- Multi-language support framework

### Planned
- Full systray GUI with PyQt6
- Performance metrics
- Automatic update scheduling
- Advanced filtering options
- Repository management UI
- More detailed update information

## Future Versions

### [0.2] - Planned
- PyQt6-based systray GUI
- Improved performance metrics
- Extended logging capabilities
- Configuration validation
- Package filtering improvements

### [0.3] - Planned
- Web-based dashboard
- Remote monitoring capabilities
- Integration with notification systems
- Plugin architecture

---

For detailed version history, see GitHub [releases](https://github.com/Techoraye/gentoo-update/releases).
