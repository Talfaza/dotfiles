#!/usr/bin/bash
echo "Syncing files to git repo"
rsync -av --progress ~/.config/i3/ ~/gitthings/dotfiles/i3/
rsync -av --progress  ~/gitthings/dotfiles/walls/ ~/.config/i3/walls
rsync -av --progress ~/.config/picom/ ~/gitthings/dotfiles/config/picom/

if [[ $? -eq 0 ]]; then 
	echo "Files synced ! "
else 
	echo "Error ! "
fi

