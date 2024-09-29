#!/usr/bin/bash
echo "Syncing files to git repo"
rsync -av --progress ~/.config/i3/ ~/gitthings/dotfiles/i3/

if [[ $0 ]]; then 
	echo "Files synced ! "
else 
	echo "Error ! "
fi

