#1/usr/bin/env bash

cd ~

## Clonar repositorio git
git init .
git remote add origin https://github.com/ManuelBlanc/eps-dotfiles.git
git pull --depth=1 origin master
git checkout -f master


## Terminal negra
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/default_size_columns'   	--type int '100'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/default_size_rows'      	--type int '30'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/use_custom_default_size'	--type bool 'true'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/font'                   	--type string 'Monospace 11'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/use_system_font'        	--type bool 'false'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/default_show_menubar'   	--type bool 'false'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/use_theme_colors'       	--type bool 'false'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/palette'                	--type string '#2E2E34343636:#CCCC00000000:#4E4E9A9A0606:#C4C4A0A00000:#34346565A4A4:#757550507B7B:#060698209A9A:#D3D3D7D7CFCF:#555557575353:#EFEF29292929:#8A8AE2E23434:#FCFCE9E94F4F:#72729F9FCFCF:#ADAD7F7FA8A8:#3434E2E2E2E2:#EEEEEEEEECEC'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/alternate_screen_scroll'	--type bool 'true'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/background_color'       	--type string '#000000'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/visible_name'           	--type string 'Predeterminado'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/bold_color'             	--type string '#000000000000'
gconftool-2 --set '/apps/gnome-terminal/profiles/Default/foreground_color'       	--type string '#FFFFFF'

>&2 echo 'Traido ficheros del repositorio y cambiado la configuracion de la terminal' 
>&2 echo 'Es posible que sea necesario abrir una terminal nueva para que los cambios'
>&2 echo 'entren en efecto.' 

