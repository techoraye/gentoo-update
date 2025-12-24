#!/usr/bin/env fish
# Fish completion for gentoo-update
# SPDX-License-Identifier: GPL-3.0-or-later

complete -c gentoo-update -n "__fish_use_subcommand_from_list" -s h -l help -d "Display help message"
complete -c gentoo-update -n "__fish_use_subcommand_from_list" -s V -l version -d "Display version information"
complete -c gentoo-update -n "__fish_use_subcommand_from_list" -s c -l check -d "Check for available updates"
complete -c gentoo-update -n "__fish_use_subcommand_from_list" -s l -l list -d "List pending updates"
complete -c gentoo-update -n "__fish_use_subcommand_from_list" -s n -l news -d "Display Gentoo news" -x
complete -c gentoo-update -n "__fish_use_subcommand_from_list" -s s -l services -d "Check services requiring restart"
complete -c gentoo-update -n "__fish_use_subcommand_from_list" -l gen-config -d "Generate configuration file"
complete -c gentoo-update -n "__fish_use_subcommand_from_list" -l show-config -d "Show current configuration"
complete -c gentoo-update -n "__fish_use_subcommand_from_list" -l edit-config -d "Edit configuration file"
complete -c gentoo-update -n "__fish_use_subcommand_from_list" -l tray -d "Start systray applet"
