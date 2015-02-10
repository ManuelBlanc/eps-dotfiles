#!/usr/bin/env bash

# En ingles
export LANG=en_US.utf8
export LC_ALL=en_US.utf8

# Incluye las cosas que esten en la UnidadH/
UnidadH="$HOME/UnidadH"
export PATH="$UnidadH/bin:$PATH"
export MANPATH="$UnidadH/share/man:$MANPATH"
export LIBRARY_PATH="$UnidadH/lib:$LIBRARY_PATH"
export CPATH="$UnidadH/include:$CPATH"

# Autocompletar (si esta instalado)
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Quitamos la sugerencia de instalar cosas
unset -f command_not_found_handle

# Listados
export LS_COLORS='*~=37:di=34:fi=0:ln=32:pi=5:so=33:bd=33:cd=33:or=92:mi=92:ex=31'
alias l='ls -Fh --color'
alias ll='l -la'

# Prompt mas interesante
bold='\[\e[1m\]'
rojo='\[\e[31m\]'
verde='\[\e[32m\]'
cyan='\[\e[36m\]'
none='\[\e[0m\]'
PS1="${cyan}\u@\h:\w\$${none} "

# Navegacion
alias ..='cd ..'
cd() {
	if [ -f "$1" ]; then
		command cd $(dirname "$1")
		return $?
	fi
	command cd "$@"
}

# TODO: eps-install
# apt-cache depends gcc
# apt-cache pkgnames
