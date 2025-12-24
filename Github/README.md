# Gentoo-Update

> An update notifier & applier for Gentoo Linux that assists you with important pre/post update tasks

[![GitHub Release](https://img.shields.io/github/release/Techoraye/gentoo-update.svg)](https://github.com/Techoraye/gentoo-update/releases)
[![GitHub License](https://img.shields.io/github/license/Techoraye/gentoo-update.svg)](https://github.com/Techoraye/gentoo-update/blob/master/LICENSE)

## Features

- 🚀 **Fast and Efficient**: Written in C++ for optimal performance
- 🔄 **Automatic Sync**: Optional automatic repository synchronization
- 📰 **News Display**: View Gentoo news items directly
- 🔧 **Service Management**: Check for services requiring restart
- ⚙️ **Highly Configurable**: Customize behavior via configuration file
- 🎨 **Color Support**: Beautiful colored output with optional disable
- 🔔 **Desktop Notifications**: Get notified of available updates
- 📦 **Preserved Rebuild Detection**: Alert on packages needing rebuild
- 💾 **Package Preservation**: Configure old package retention
- 🖥️ **Multiple Init Systems**: Support for systemd and OpenRC

## Installation

### From Source

```bash
git clone https://github.com/Techoraye/gentoo-update.git
cd gentoo-update
mkdir build && cd build
cmake ..
make
sudo make install
```

### Prerequisites

- C++17 compatible compiler (GCC 7+ or Clang 5+)
- CMake 3.10 or later
- Standard C++ library with filesystem support
- Portage tools (emaint, emerge)

## Usage

> **Note:** If gentoo-update is not installed system-wide, set the environment variable before running:
> ```bash
> export GENTOO_UPDATE_LIBDIR="./src/lib"
> ./gentoo-update [OPTIONS]
> ```

### Interactive Update

```bash
gentoo-update
```

Runs the full interactive update workflow with all checks.

### Check Only

```bash
gentoo-update -c
gentoo-update --check
```

Check for updates without applying them.

### List Updates

```bash
gentoo-update -l
gentoo-update --list
```

Display all pending package updates.

### View News

```bash
gentoo-update -n
gentoo-update -n 10
gentoo-update --news [NUM]
```

Show Gentoo news items. Defaults to 5 items, specify number for more/less.

### Check Services

```bash
gentoo-update -s
gentoo-update --services
```

Check for services requiring restart or systemd unit failures.

### Configuration Management

```bash
gentoo-update --gen-config      # Generate default configuration
gentoo-update --show-config     # Display current configuration
gentoo-update --edit-config     # Edit configuration in $EDITOR
```

### System Tray

```bash
gentoo-update --tray                # Run in tray mode
gentoo-update --tray --enable       # Enable autostart
gentoo-update --tray --disable      # Disable autostart
```

## Configuration

Configuration file location: `~/.config/gentoo-update/gentoo-update.conf`

Generate a default configuration with:
```bash
gentoo-update --gen-config
```

### Available Settings

| Setting | Type | Default | Description |
|---------|------|---------|-------------|
| `NoColor` | bool | false | Disable colored output |
| `AlwaysShow` | bool | false | Always show full output |
| `NewsNum` | int | 5 | Number of news items to display |
| `KeepOldPackages` | int | 3 | Number of old package versions to keep |
| `KeepInstalledPackages` | int | 0 | Keep installed package binaries |
| `DiffProg` | string | vimdiff | Program to use for config diffs |
| `CheckInterval` | int | 3600 | Seconds between tray checks |
| `AutoSync` | bool | true | Automatically sync repositories |
| `CheckPreservedRebuild` | bool | true | Check for preserved rebuilds |
| `CheckKernelUpdates` | bool | true | Check for kernel updates |
| `CheckConfigFiles` | bool | true | Check for config file changes |
| `CheckDistfiles` | bool | true | Check distfiles cleanliness |

## Examples

```bash
# Check for updates
$ gentoo-update -c

# List all available updates
$ gentoo-update -l

# View last 15 news items
$ gentoo-update -n 15

# Check which services need restart
$ gentoo-update -s

# Edit configuration
$ gentoo-update --edit-config

# Run in background with tray icon
$ gentoo-update --tray &
```

## Man Pages

Complete documentation is available via man pages:

```bash
man gentoo-update           # Main program documentation
man gentoo-update.conf      # Configuration file format
```

## Supported Init Systems

- **systemd** (modern systems)
- **OpenRC** (traditional systems)

The appropriate init system is automatically detected.

## Requirements

- Portage/Gentoo Linux installation
- `emaint` command (part of gentoolkit)
- `emerge` command
- Optional: `doas` or `sudo` for privilege escalation
- Optional: `systemctl` or `rc-service` depending on init system
- Optional: Python 3 + PyQt6 for full systray support

## Troubleshooting

### Libraries directory not found

If you see "ERROR: Libraries directory not found", set the environment variable:
```bash
export GENTOO_UPDATE_LIBDIR="./src/lib"
gentoo-update --help
```

Or for system-wide installations:
```bash
export GENTOO_UPDATE_LIBDIR=/usr/lib/gentoo-update
gentoo-update --help
```

You can permanently add this to your shell configuration:
```bash
echo 'export GENTOO_UPDATE_LIBDIR=/usr/lib/gentoo-update' >> ~/.bashrc
```

### Permission denied on updates

Ensure you have proper sudo privileges or run with appropriate escalation:
```bash
sudo gentoo-update
```

### Color output issues

Disable colors in configuration:
```bash
gentoo-update --edit-config
# Set: NoColor=true
```

## Development

### Building with Make

```bash
make
make test
sudo make install
```

Or with CMake:

```bash
mkdir build
cd build
cmake ..
make
```

### Building with CMake

```bash
mkdir build
cd build
cmake ..
make
make test  # if tests exist
```

### Compilation flags

The project uses:
- `-Wall -Wextra` for strict warnings
- `-O2` for optimization
- `-std=c++17` for modern C++ features

### Running Tests

Before installation, run the test suite:
```bash
make test
```

Or manually:
```bash
export GENTOO_UPDATE_LIBDIR="./src/lib"
./gentoo-update --help
./gentoo-update --version
./gentoo-update --show-config
```

### Development Environment

To compile from source:
```bash
g++ -std=c++17 -Wall -Wextra -O2 gentoo-update.cpp -o gentoo-update
```

Then test with:
```bash
GENTOO_UPDATE_LIBDIR="./src/lib" ./gentoo-update --version
```

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

Gentoo-Update is licensed under the GNU General Public License v3.0 or later.
See [LICENSE](LICENSE) file for details.

## Author

**Mathieu Roberge (Techoraye)**
- Email: robergem2008@gmail.com
- GitHub: [@Techoraye](https://github.com/Techoraye)

## Support

- 📝 [Issue Tracker](https://github.com/Techoraye/gentoo-update/issues)
- 💬 [Discussions](https://github.com/Techoraye/gentoo-update/discussions)
- 📚 [Documentation](https://github.com/Techoraye/gentoo-update/wiki)

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and updates.

## Related Projects

- [arch-update](https://github.com/Antiz96/arch-update) - Original inspiration (Arch Linux version)
- [Portage](https://wiki.gentoo.org/wiki/Portage) - Gentoo's package manager
- [Gentoolkit](https://wiki.gentoo.org/wiki/Gentoolkit) - Gentoo utilities
