#compdef gentoo-update
# Zsh completion for gentoo-update
# SPDX-License-Identifier: GPL-3.0-or-later

_gentoo_update() {
	local -a commands=(
		{-h,--help}'[Display help message]'
		{-V,--version}'[Display version information]'
		{-c,--check}'[Check for available updates]'
		{-l,--list}'[List pending updates]'
		{-n,--news}'[Display Gentoo news]:number:(5 10 15 20 25 30)'
		{-s,--services}'[Check for services requiring restart]'
		'--gen-config[Generate configuration file]'
		'--show-config[Show current configuration]'
		'--edit-config[Edit configuration file]'
		'--tray[Start systray applet]:action:(--enable --disable)'
	)

	_describe 'gentoo-update' commands
}

_gentoo_update "$@"
