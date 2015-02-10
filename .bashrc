#!/usr/bin/env bash

# Listados
export LS_COLORS='*~=4:di=134:fi=0:ln=32:pi=5:so=33:bd=33:cd=33:or=92:mi=92:ex=31'
alias l='ls --color'
alias ll='l -la'

# Navegacion
alias ..='cd ..'
cd() {
	if [ -f "$1" ]; then
		command cd $(dirname "$1")
		return $?
	fi
	command cd "$@"
}
