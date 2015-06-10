
    ▄▄▄ . ▄▄▄·.▄▄ ·    ·▄▄▄▄        ▄▄▄▄▄·▄▄▄▪  ▄▄▌  ▄▄▄ ..▄▄ · 
    ▀▄.▀·▐█ ▄█▐█ ▀.    ██▪ ██ ▪     •██  ▐▄▄·██ ██•  ▀▄.▀·▐█ ▀. 
    ▐▀▀▪▄ ██▀·▄▀▀▀█▄   ▐█· ▐█▌ ▄█▀▄  ▐█.▪██▪ ▐█·██▪  ▐▀▀▪▄▄▀▀▀█▄
    ▐█▄▄▌▐█▪·•▐█▄▪▐█   ██. ██ ▐█▌.▐▌ ▐█▌·██▌.▐█▌▐█▌▐▌▐█▄▄▌▐█▄▪▐█
     ▀▀▀ .▀    ▀▀▀▀    ▀▀▀▀▀•  ▀█▄▀▪ ▀▀▀ ▀▀▀ ▀▀▀.▀▀▀  ▀▀▀  ▀▀▀▀ 
            ((https://github.com/ManuelBlanc/eps-dotfiles))

     
## Como instalar?
### Metodo 1
Ejecuta el fichero [setup.sh](./setup.sh), eg.

    source <(curl -fsSL https://raw.githubusercontent.com/ManuelBlanc/eps-dotfiles/master/setup.sh)
    
### Metodo 2
Si no te gusta pipear `curl` a `bash`, clona el repositorio y ejecuta el fichero:

    git clone https://github.com/ManuelBlanc/eps-dotfiles.git
    cd eps-dotfiles/
    source setup.sh
    
### Reconfiguracion
Si ya lo tienes instalado, para cargar la configuracion en un ordenador nuevo solo tienes que ejecutar `setup.sh` haciendo doble click o con el comando:

    source ~/UnidadH/eps-dotfiles/setup.sh

## Caracteristicas
* Tres pequeñas utilidades:
  * [copydoc](./bin/copydoc) sirve para copiar cabeceras de Doxygen de un .h a un .c
  * [dupes](./bin/dupes) detecta copias en conflicto de Dropbox
  * [subl](./bin/subl) arranca ST3 de la UnidadH, o lo instala si no esta en ese lugar.
* Prompt mas corto e informativo. Muestra la rama de git actual. ([.bash_prompt](./.bash_prompt))
* [.bashrc](./.bashrc) define unos cuantos aliases y variables de configuracion.
* [.gitconfig](./.gitconfig) añade aliases de git, colorizacion y valores por defecto "mas sensatos".
* [.inputrc](./.inputrc) hace `set completion-ignore-case on`. 'Nuff said.
* [.vimrc](./.vimrc) contiene una configuracion basica de vim con colores y numeros de linea.

## Licencia ##
GPLv3 (vease el fichero [LICENSE](./LICENSE))

