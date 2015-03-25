#!/usr/bin/env bash

{ # Proteccion ejecuccion parcial

# Colorines
NORMAL=$(tput sgr0)
BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)

# Utilidades
echo2() { >&2 echo "$@";                                            	}
info()  { echo2 "$GREEN==> $NORMAL$@$NORMAL";                       	}
infoB() { echo2 "$GREEN==> $NORMAL$BOLD$@$NORMAL";                  	}
error() { echo2 "$MAGENTA==> $NORMAL${BOLD}error: $NORMAL$@$NORMAL";	}
abort() { error "$@"; exit 1;                                       	}
prompt() {
	read -p "${YELLOW}$1 ${BOLD}[S/n]${NORMAL} " # -n 1 -r
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
cd "$PREFIX"

infoB "Buscando una instalacion ya existente ..."

if [ -d "$PREFIX/eps-dotfiles" ]; then
	info "Encontrada en $PREFIX/eps-dotfiles"
else
	info "No se encontro ninguna instalacion"
	prompt "Desea instalar en $PREFIX/eps-dotfiles ($GITREPO)?" || abort "instalacion abortada"

	infoB "Clonando el repositorio"
	git clone -v "$GITREPO" "$PREFIX/eps-dotfiles"
fi

infoB "Enlazando los ficheros de configuracion"
## Enlazado manual
link_file() { ln -fs "$PREFIX/eps-dotfiles/$1" "$HOME/$1"; }
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

## TODO: Vale la pena automatizar esto?

# for f in $(find "$EPSPREFIX" -type f ! -name README.md ! -path './.git/?*'); do
#	mkdir -p $(dirname "$f")
#	ln -s "$EPSPREFIX$(basename "$f")" $(dirname "$f")
# done


## Terminal negra
infoB "Cambiando el perfil de la terminal"
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/default_size_columns'   	--type int '100'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/default_size_rows'      	--type int '30'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/use_custom_default_size'	--type bool 'true'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/font'                   	--type string 'DejaVu Sans Mono 14'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/use_system_font'        	--type bool 'false'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/default_show_menubar'   	--type bool 'false'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/use_theme_colors'       	--type bool 'false'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/palette'                	--type string '#000000000000:#EFEF29292929:#8A89E2E13433:#FCFCE9E84F4F:#FCFCAFAF3E3D:#ADAD7F7FA8A7:#72729F9FCFCF:#D3D3D7D7CFCF:#555557575353:#A4A400000000:#4E4E9A990605:#C4C4A09F0000:#CECE5C5B0000:#5C5B35356666:#201F4A4A8787:#EEEEEEEEECEC'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/alternate_screen_scroll'	--type bool 'true'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/background_color'       	--type string '#000000000000'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/visible_name'           	--type string 'Predeterminado'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/bold_color'             	--type string '#000000000000'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/foreground_color'       	--type string '#F3F2F3F2F3F2'

## Recargamos la configuracion
infoB "Recargando la configuracion"
set +eu
cd ~
bind -f ~/.inputrc
. ~/.bashrc

}
