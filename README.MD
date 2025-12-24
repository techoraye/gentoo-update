# gentoo-update

A comprehensive system update manager for Gentoo Linux with intelligent package management, service monitoring, and system maintenance capabilities.

## Overview

`gentoo-update` is a professional-grade update notifier and system maintenance tool designed specifically for Gentoo Linux. It streamlines the update process by intelligently checking multiple system components, providing clear feedback, and offering both interactive and automated workflows.

## Features

### Core Functionality

- **Portage Integration**: Seamlessly syncs and checks for package updates in @world
- **News Monitoring**: Automatically detects and prompts for unread Gentoo news items
- **Orphan Package Detection**: Identifies packages no longer in the repository (requires `eix`)
- **Preserved Rebuild Management**: Tracks packages requiring rebuild due to library changes
- **Configuration File Handling**: Detects pending config file updates via `etc-update`
- **Kernel Update Detection**: Compares running kernel against installed versions
- **Service Status Monitoring**: Checks for failed services (systemd/OpenRC aware)
- **Distfiles Cache Management**: Identifies old cached source files for cleanup

### System Integration

- **Multi-Init Support**: Works with both systemd and OpenRC
- **Flexible Privilege Escalation**: Supports `run0`, `sudo-rs`, `doas`, and `sudo`
- **Systray Applet**: Background monitoring with desktop notifications (requires PyQt6/Qt6)
- **XDG Compliance**: Respects XDG Base Directory specifications

## Installation

### Prerequisites

```bash
# Core requirements (already on most Gentoo systems)
emerge --ask sys-apps/portage app-portage/gentoolkit

# Optional but recommended
emerge --ask app-portage/eix app-portage/portage-utils

# For systray functionality
emerge --ask dev-python/PyQt6
```

### Install Script

```bash
# Copy to system
sudo cp gentoo-update /usr/local/bin/
sudo chmod +x /usr/local/bin/gentoo-update
```

## Usage

### Interactive Mode (Default)

```bash
gentoo-update
```

Runs a comprehensive system check and prompts for updates interactively. This mode:
- Checks all system components
- Displays available updates with clear categorization
- Prompts before applying changes
- Handles config file updates
- Offers reboot if kernel was updated

### Check Mode

```bash
gentoo-update --check
```

Performs all checks without applying updates. Useful for:
- Cron jobs
- Pre-maintenance assessment
- Integration with monitoring systems

### Service Monitoring

```bash
gentoo-update --services
```

Specifically checks for services requiring restart after updates.

### Systray Applet

```bash
# Start systray applet
gentoo-update --tray

# Enable autostart on login
gentoo-update --tray --enable

# Disable autostart
gentoo-update --tray --disable
```

## Configuration

Configuration file location: `~/.config/gentoo-update/gentoo-update.conf`

The script automatically creates cache directories at:
- `~/.cache/gentoo-update/last-check`
- `~/.cache/gentoo-update/next-check`

## Architecture

### Privilege Escalation Detection

The script intelligently detects available privilege escalation methods in this order:
1. `run0` (systemd)
2. `sudo-rs` (Rust sudo alternative)
3. `doas` (OpenBSD-style)
4. `sudo` (traditional)

### Init System Detection

Automatically detects and adapts to:
- **systemd**: Full service status integration
- **OpenRC**: Graceful handling with manual restart guidance

### Update Workflow

1. **News Check**: Prompts for unread Gentoo news
2. **Package Analysis**: Syncs portage and analyzes @world
3. **System Health**: Checks orphans, preserved-rebuild, configs
4. **Kernel Status**: Compares running vs. installed kernels
5. **Service Status**: Identifies failed/stale services
6. **Interactive Prompt**: User confirmation before proceeding
7. **Update Application**: Runs emerge with optimal flags
8. **Post-Update**: Handles config files, depclean, reboot prompt

## Design Principles

- **Zero Dependencies Beyond Base System**: Works with standard Gentoo tools
- **Graceful Degradation**: Optional tools enhance functionality but aren't required
- **Clear User Feedback**: Color-coded output with status indicators
- **Safe Defaults**: Always prompts before destructive operations
- **Non-Interactive Ready**: Suitable for automation and scripting

## Color Coding

- 🔵 **Blue**: Informational messages and checks in progress
- 🟢 **Green**: Success messages and up-to-date confirmations
- 🟡 **Yellow**: Warnings and available updates
- 🔴 **Red**: Errors and critical issues

## Exit Codes

- `0`: Success
- `1`: Privilege escalation method not found or other error

## Compatibility

- **Gentoo Linux**: Primary target (all profiles)
- **Init Systems**: systemd, OpenRC
- **Architectures**: Architecture-agnostic shell script

## Acknowledgments

Based on [arch-update](https://github.com/Antiz96/arch-update) by Antiz96, adapted for Gentoo Linux with portage-specific functionality and Gentoo ecosystem integration.

## License

Follows the same license as the original arch-update project.

## Contributing

This tool is designed to integrate seamlessly into Gentoo workflows. Contributions welcome for:
- Additional package manager integration
- Enhanced systray functionality
- Profile-specific optimizations
- Overlay management features

---

**Note**: While the systray functionality is outlined in the codebase, full implementation requires PyQt6/Qt6 dependencies and graphical environment setup. The core update functionality works independently of the GUI components.
