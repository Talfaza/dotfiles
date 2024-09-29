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

packages=("i3" "git" "curl" "wget" "feh" "blueman" "kitty")
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

rm -rf install.log installError.log

