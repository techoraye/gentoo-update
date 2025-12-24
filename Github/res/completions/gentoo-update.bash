#!/usr/bin/env bash
# Bash completion for gentoo-update
# SPDX-License-Identifier: GPL-3.0-or-later

_gentoo_update_completions() {
	local cur prev opts
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"

	opts="-h --help -V --version -c --check -l --list -n --news -s --services --gen-config --show-config --edit-config --tray"

	case "${prev}" in
		-n|--news)
			COMPREPLY=( $(compgen -W "5 10 15 20 25 30" -- ${cur}) )
			return 0
			;;
		--tray)
			COMPREPLY=( $(compgen -W "--enable --disable" -- ${cur}) )
			return 0
			;;
		*)
			;;
	esac

	COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

complete -F _gentoo_update_completions gentoo-update
