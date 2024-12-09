#!/usr/bin/env bash
echo "Syncing files to git repo"
rsync -av --progress ~/.config/i3/ ~/gitthings/dotfiles/i3/
if [[ $? -eq 0 ]]; then 
	echo "Files synced ! "
else 
	echo "Error ! "
fi

rsync -av --progress ~/.config/i3/walls/ ~/gitthings/dotfiles/i3/walls 

if [[ $? -eq 0 ]]; then 
	echo "Files synced ! "
else 
	echo "Error ! "
fi


rsync -av --progress ~/.config/picom/ ~/gitthings/dotfiles/picom/

if [[ $? -eq 0 ]]; then 
	echo "Files synced ! "
else 
	echo "Error ! "
fi
rsync -av --progress ~/.config/kitty/ ~/gitthings/dotfiles/kitty

if [[ $? -eq 0 ]]; then 
	echo "Files synced ! "
else 
	echo "Error ! "
fi
rsync -av --progress ~/.config/rofi/ ~/gitthings/dotfiles/rofi/

if [[ $? -eq 0 ]]; then 
	echo "Files synced ! "
else 
	echo "Error ! "
fi
rsync -av --progress ~/.config/nvim/ ~/gitthings/dotfiles/nvim/

if [[ $? -eq 0 ]]; then 
	echo "Files synced ! "
else 
	echo "Error ! "
fi

