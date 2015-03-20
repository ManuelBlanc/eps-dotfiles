#!/usr/bin/env bash

# Desactivar '!'
set +H

# En ingles
export LANG=en_US.utf8
export LC_ALL=en_US.utf8

# Configuracion miscelanea
export EDITOR=vim
export LESS=-Ri

# Incluye las cosas que esten en la UnidadH/
UnidadH="$HOME/UnidadH"
export PATH="$UnidadH/bin:$UnidadH/eps-dotfiles/bin:$PATH"
export MANPATH="$UnidadH/share/man:$MANPATH"
export LIBRARY_PATH="$UnidadH/lib:$LIBRARY_PATH"
export CPATH="$UnidadH/include:$CPATH"

# Autocompletar global
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi

# Autocompletar en la UnidadH
if [ -f $UnidadH/etc/bash_completion ]; then
    source $UnidadH/etc/bash_completion
fi

# Quitamos la sugerencias de instalacion
unset -f command_not_found_handle

# Listados
export LS_COLORS='*~=37:di=34:fi=0:ln=32:pi=5:so=33:bd=33:cd=33:or=92:mi=92:ex=31'
alias l='ls -Fh --color'
alias ll='l -la'

# Prompt mas interesante
source .bash_prompt

# Navegacion
alias back='cd "$OLDPWD"'
alias ..='cd ..'
alias ...='cd ../..'
cd() {
    if [ -f "$1" ]; then
        command cd $(dirname "$1")
        return $?
    fi
    command cd "$@"
}

# Otros alias y funciones utiles
alias mkdirp='mkdir -p'
alias bc='bc -l'

alias duh='du -h'
alias duhd='du -hd1'

ff() {
    local DIR="$1"
    shift
    find "$DIR" -depth 1 "$@"
}

# Easy extract (no soy el autor, fuente desconocida)
extract () {
    if [ -f $1 ]; then
        case $1 in
                *.tar.bz2)  tar xvjf $1                                 ;;
                *.tar.gz)   tar xvzf $1                                 ;;
                *.bz2)      bunzip2 $1                                  ;;
                *.rar)      rar x $1                                    ;;
                *.gz)       gunzip $1                                   ;;
                *.tar)      tar xvf $1                                  ;;
                *.tbz2)     tar xvjf $1                                 ;;
                *.tgz)      tar xvzf $1                                 ;;
                *.zip)      unzip $1                                    ;;
                *.Z)        uncompress $1                               ;;
                *.7z)       7z x $1                                     ;;
                *)          echo "don't know how to extract '$1'..."    ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

swap() {
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

echo "$(tput setaf 4) ▄▄▄ . ▄▄▄·.▄▄ ·   $(tput setaf 4) ·▄▄▄▄        ▄▄▄▄▄·▄▄▄▪  ▄▄▌  ▄▄▄ ..▄▄ · "
echo "$(tput setaf 4) ▀▄.▀·▐█ ▄█▐█ ▀.   $(tput setaf 4) ██▪ ██ ▪     •██  ▐▄▄·██ ██•  ▀▄.▀·▐█ ▀. "
echo "$(tput setaf 4) ▐▀▀▪▄ ██▀·▄▀▀▀█▄  $(tput setaf 4) ▐█· ▐█▌ ▄█▀▄  ▐█.▪██▪ ▐█·██▪  ▐▀▀▪▄▄▀▀▀█▄"
echo "$(tput setaf 4) ▐█▄▄▌▐█▪·•▐█▄▪▐█  $(tput setaf 4) ██. ██ ▐█▌.▐▌ ▐█▌·██▌.▐█▌▐█▌▐▌▐█▄▄▌▐█▄▪▐█"
echo "$(tput setaf 4)  ▀▀▀ .▀    ▀▀▀▀   $(tput setaf 4) ▀▀▀▀▀•  ▀█▄▀▪ ▀▀▀ ▀▀▀ ▀▀▀.▀▀▀  ▀▀▀  ▀▀▀▀ "
tput sgr0
echo '        ((https://github.com/ManuelBlanc/eps-dotfiles))'
echo ''

