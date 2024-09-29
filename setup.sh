#!/bin/bash

echo "
██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗      █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     ███████║   ██║   ██║██║   ██║██╔██╗ ██║
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
"

# Reset
Color_Off='\033[0m'
WHO="talfaza"
# Bold
BRed='\033[1;31m'
BGreen='\033[1;32m'
BBlue='\033[1;34m'
BWhite='\033[1;37m'

UWhite='\033[4;37m'

# Function to install a package
installPackage() {
  local package="$1"

  # Check if package is installed using dnf
  sudo dnf list installed "$package" &>/dev/null

  if [ $? -eq 0 ]; then
    echo -e "[${BGreen}OK${Color_Off}] Package $package is already installed"
  else
    echo -e "[${BRed}Installing${Color_Off}] Package $package not installed"
    sudo dnf install "$package" -y | grep "Installed" | awk '{print $2}' >>install.log 2>>installError.log
    
    if [ $? -eq 0 ]; then
      echo -e "[${BGreen}OK${Color_Off}] Package $package installed successfully"
    else
      echo -e "[${BRed}Error${Color_Off}] Failed to install $package"
    fi
  fi
}

packages=(
  "git"
  "curl"
  "wget"
  "feh"
  "blueman"
  "kitty"
  "dbus-devel"
  "gcc"
  "libconfig-devel"
  "libdrm-devel"
  "libev-devel"
  "libX11-devel"
  "libX11-xcb"
  "libXext-devel"
  "libxcb-devel"
  "libGL-devel"
  "libEGL-devel"
  "meson"
  "pcre2-devel"
  "pixman-devel"
  "uthash-devel"
  "xcb-util-image-devel"
  "xcb-util-renderutil-devel"
  "xorg-x11-proto-devel"
)
echo -ne "${UWhite}Installing the neccesary packages and setuping the config :${Color_Off} \n\n"
for package in "${packages[@]}"; do
  installPackage "$package"
done

echo -e "[${BBlue}Changing Default Shell to ZSH${Color_Off}]"
chsh -s $(which zsh) >>install.log 2>>installError.log
if [ $? -eq 0 ]; then
  echo -e "[${BGreen}OK${Color_Off}] Shell changed to ZSH successfully"
else
  echo -e "[${BRed}Error${Color_Off}] Could not change the shell"
fi


echo -e "[${BBlue}Setting up wallpaper${Color_Off}]"

feh --bg-scale /home/$WHO/.config/i3/walls/wall.png 2>>installError.log
if [ $? -eq 0 ]; then
  echo -e "[${BGreen}OK${Color_Off}] Wallpaper changed successfully"
else
  echo -e "[${BRed}Error${Color_Off}] Could not change the wallpaper"
fi

echo -e "[${BBlue}Building Picom${Color_Off}]"
git clone https://github.com/fdev31/picom.git 2>>installError.log >>install.log;cd picom;git submodule update --init --recursive;meson setup --buildtype=release . build;ninja -C build;ninja -C build install >>install.log
if [ $? -eq 0 ]; then
  echo -e "[${BGreen}OK${Color_Off}] Picom built successfully"
else
  echo -e "[${BRed}Error${Color_Off}] Could build picom"
fi
cd ..;rm -rf picom

mkdir -p /home/$WHO/.config/picom
mkdir -p /home/$WHO/picom  
mv config/picom/picom.conf /home/$WHO/picom/picom.conf 
if [ $? -eq 0 ]; then
  echo -e "[${BGreen}OK${Color_Off}] Picom setup successfully"
else
  echo -e "[${BRed}Error${Color_Off}] Could not setup picom"
fi

echo -e "[${BRed}Installing${Color_Off}]Package bumblebee-status not installed " 
pip install --user bumblebee-status 2>>installError.log >> install.log
if [ $? -eq 0 ]; then
  echo -e "[${BGreen}OK${Color_Off}] Package bumblebee-status installed successfully"
else
  echo -e "[${BRed}Error${Color_Off}] Failed to install bumblebee-status"
fi
rm -rf install.log installError.log
