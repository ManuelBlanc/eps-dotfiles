
#!/usr/bin/env bash

# Instalador de Sublime Text 3 para los laboratorios de la EPS
# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <manuel.blanc@estudiante.uam.es> escribio este programa. Mientras mantengas
# esta cabezera, puedes hacer lo que quieras con esto. Si un dia nos vemos y
# piensas que esto te ha sido util, puedes invitarme a una birra. mbc 2014
# ----------------------------------------------------------------------------

set -eu # Modo sano

# URL del paquete para que sea facil cambiarlo
DOWNLOAD_URL="http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3059_x32.tar.bz2"

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
infoB " Instalador de Sublime Text 3 portable"
infoB "======================================================================"
info  "Este script descarga y configura la version portable de Sublime Text 3"
infoB "URL del paquete: "
info  "  $DOWNLOAD_URL"
infoB "Directorio destino: "
info  "  $(pwd)/sublime_text_3"
echo

# Comprobar que se puede escribir
[[ -w "$(pwd)" ]] || abort "no hay permiso de escritura"
# Comprobar que no esta instalado
[[ ! -e sublime_text_3 ]] || prompt "Ya existe una carpeta sublime_text_3, sobreescribir?" || abort "ya existe una carpeta sublime_text_3"

# Confirmar instalacion
prompt "Estas seguro de que quieres continuar?" || abort "instalacion abortada"

# Instalacion
echo2; infoB "Descargando el paquete"
curl "$DOWNLOAD_URL" > st3.tar.bz2

echo2; infoB "Extrayendo comprimido"
tar -vxjf st3.tar.bz2
rm st3.tar.bz2

echo2; infoB "Configurando ficheros adicionales"
mkdir -vp sublime_text_3/Data
cat > sublime_text_3/CONFIGURAR.sh <<'EOF'
#!/usr/bin/env bash

# Fichero generado por el instalador en https://gist.github.com/ManuelBlanc
# Para mas informacion y la licencia, ver InstalarSublime.sh

set -eu # Modo sano

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Instalamos un .desktop basado en el que viene por defecto
sed -e "s:/opt/sublime_text/:$DIR/:" -e "s:^Icon=sublime-text$:Icon=$DIR/Icon/256x256/sublime-text.png:" sublime_text.desktop > ~/.local/share/applications/sublime_text.desktop
chmod u+x ~/.local/share/applications/sublime_text.desktop

echo '[Default Applications]' > ~/.local/share/applications/mimeapps.list
grep 'gedit' '/etc/gnome/defaults.list' | sed 's/gedit/sublime_text/g' >> ~/.local/share/applications/mimeapps.list

>&2 echo 'Asociado ST3 con todos los ficheros de texto'

EOF
chmod u+x sublime_text_3/CONFIGURAR.sh

echo2; infoB 'Terminado, instalacion con exito!'

