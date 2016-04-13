#!/usr/bin/env bash

{ # Proteccion ejecuccion parcial

# Colorines
C_NORMAL=$(tput sgr0)
C_BOLD=$(tput bold)
C_RED=$(tput setaf 1)
C_GREEN=$(tput setaf 2)
C_YELLOW=$(tput setaf 3)
C_BLUE=$(tput setaf 4)
C_MAGENTA=$(tput setaf 5)
C_CYAN=$(tput setaf 6)
C_WHITE=$(tput setaf 7)

# Utilidades
info()  { echo "$C_GREEN==> $C_NORMAL$@$C_NORMAL";              	}
infoB() { echo "$C_GREEN==> $C_NORMAL$C_BOLDC_$@$NORMAL";       	}
error() { echo "$C_RED==> $C_NORMAL${C_BOLD}error: $C_NORMAL$@";	}
abort() { error "$@"; exit 1;                                   	}
prompt() {
	read -p "${C_YELLOW}$1 ${C_BOLD}[S/n]${C_NORMAL} " # -n 1 -r
	[[ -z $REPLY || $REPLY =~ ^[YySs]$ ]]
	return $?
}

# ----------------------------------------------------------------------------

infoB "======================================================================"
infoB " eps-dotfiles -- instalacion/reconfiguracion"
infoB "======================================================================"

PREFIX="$HOME/UnidadH"
GITREPO="https://github.com/ManuelBlanc/eps-dotfiles.git"
# Preparacion
test -d "$PREFIX" || abort "La ~/UnidadH/ no esta disponible"

infoB "Buscando una instalacion ya existente ..."

if [ -d "$PREFIX/eps-dotfiles" ]; then
	info "Encontrada en $PREFIX/eps-dotfiles, actualizando ..."
	(cd "$PREFIX/eps-dotfiles" && git pull --ff-only -v origin master && git submodule update)
else
	info "No se encontro ninguna instalacion"
	prompt "Desea instalar en $PREFIX/eps-dotfiles ($GITREPO)?" || abort "instalacion abortada"

	infoB "Clonando el repositorio"
	git clone --recursive -v "$GITREPO" "$PREFIX/eps-dotfiles"
	info '!!ATENCION!! Si eres un usuario de git, NO ejecutes "git config user..."'
	info 'En vez de eso, modifica el fichero eps-dotfiles/IDENTIDAD_GIT'

cat > "$PREFIX/eps-dotfiles/IDENTIDAD_GIT" <<EOF
[user]
	name = Nombre
	email = email@example.com
EOF

fi

infoB "Enlazando los ficheros de configuracion"
## Enlazado manual
link_file() { ln -fsT "$PREFIX/eps-dotfiles/$1" "$HOME/$1"; }
# Git
mkdir -p ~/.config/git
link_file .config/git/ignore
link_file .gitconfig
# Bash
link_file .bash_prompt
link_file .bashrc
link_file .inputrc
# Vim
link_file .vimrc

# Cargamos nuestros datos de la configuracion de la terminal
if [ -f "$PREFIX/eps-dotfiles/gnome-terminal.custom.xml" ]; then
	gconftool-2 --load="$PREFIX/eps-dotfiles/gnome-terminal.custom.xml"
else
	gconftool-2 --load="$PREFIX/eps-dotfiles/gnome-terminal.xml"
fi
# En el .bashrc creamos una funcion para guardar la configuracion actual

infoB "Recargando la configuracion"
bind -f ~/.inputrc
source ~/.bashrc

# Comprobamos como se esta ejecutando el script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	error "Debes abrir una terminal nueva para que se apliquen algunos cambios"
fi
}
