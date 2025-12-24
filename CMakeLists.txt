cmake_minimum_required(VERSION 3.10)
project(gentoo-update VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Source files
add_executable(gentoo-update gentoo-update.cpp)

# Compiler flags
target_compile_options(gentoo-update PRIVATE
	-Wall
	-Wextra
	-O2
)

# Install targets
install(TARGETS gentoo-update
	DESTINATION bin
)

# Install documentation
install(FILES
	README.md
	README-fr.md
	CHANGELOG.md
	CONTRIBUTING.md
	MAINTAINERS.md
	RELEASE.md
	SECURITY.md
	LICENSE
	DESTINATION share/doc/gentoo-update
)

# Install headers/lib
install(DIRECTORY
	src/lib/
	DESTINATION include/gentoo-update
	FILES_MATCHING PATTERN "*.hpp"
)

# Install man pages
install(FILES
	doc/man/gentoo-update.1
	DESTINATION share/man/man1
)

install(FILES
	doc/man/gentoo-update.conf.5
	DESTINATION share/man/man5
)

# Install shell completions
install(FILES
	res/completions/gentoo-update.bash
	DESTINATION /etc/bash_completion.d/
	RENAME gentoo-update
)

install(FILES
	res/completions/gentoo-update.zsh
	DESTINATION share/zsh/site-functions
	RENAME _gentoo-update
)

install(FILES
	res/completions/gentoo-update.fish
	DESTINATION share/fish/vendor_completions.d/
)

# Install configuration example
install(FILES
	res/config/gentoo-update.conf.example
	DESTINATION share/gentoo-update/config
	RENAME gentoo-update.conf.example
)

# Install desktop files
install(FILES
	res/desktop/gentoo-update.desktop
	res/desktop/gentoo-update-tray.desktop
	DESTINATION share/applications
)

# Install systemd units
install(FILES
	res/systemd/gentoo-update.service
	res/systemd/gentoo-update.timer
	DESTINATION lib/systemd/system
)

install(FILES
	res/systemd/gentoo-update-tray.service
	DESTINATION lib/systemd/system
)

# Install OpenRC service
install(FILES
	res/openrc/gentoo-update
	DESTINATION etc/init.d
	PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE
)

# Install icons
install(DIRECTORY
	res/icons/
	DESTINATION share/icons
)

# Custom targets
add_custom_target(uninstall
	COMMAND xargs rm -vf < install_manifest.txt
)
