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
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White


installPackage() {
  local package="$1"
  
  rpm -q "$package" 2>installError.log 1>install.log
  
  if [ $? -eq 0 ]; then
    echo -e "[${BGreen}OK${Color_Off}] Package $package already installed"
  else
    echo -e "[${BRed}Error${Color_Off}] Package $package not installed"
    sudo dnf install "$package" -y >install.log
    echo -ne "\033[A\033[K"  
    echo -e "[${BGreen}OK${Color_Off}] Package $package installed successfully"
  fi
}

packages=("htop" "curl" "wget" "rofi" "i3" "python3" "dbus-devel" "gcc" "git" "libconfig-devel" "libdrm-devel" "libev-devel" "libX11-devel" "libX11-xcb" "neofetch" "gcc" "g++" "libXext-devel" "libxcb-devel" "libGL-devel" "libEGL-devel" "meson" "pcre2-devel" "pixman-devel" "uthash-devel" "xcb-util-image-devel" "xcb-util-renderutil-devel" "xorg-x11-proto-devel" "playerctl" "gnome-system-monitor" "brightnessctl" "light" "xbacklight" "blueman" "zsh" "grep" "sed" "curl" "mpv" "yt-dlp" "ffmpeg" "fzf" "patch" "git" "wget" "vim" "neovim" "gnome-system-monitor"  "pavucontrol" "python3-tkinter" "httpd")  
echo -ne "Installing Needed Packages And Dependecies For My Config : \n \n"
for package in "${packages[@]}"; do
  installPackage "$package"
done

find -iname "*.log" | xargs rm
#
#echo -e "[${BPurple}Downloading Wallpaper${Color_Off}]"
#wall=$(curl -s https://raw.githubusercontent.com/Talfaza/dotfiles/main/i3/wallhaven-856dlk.png > wallhaven-856dlk.png)
#
#if [ $? -eq 0 ];then 
#    echo -e "[${BGreen}Wallapaper Downloaded Successfully${Color_Off}]"
#  else  
#    echo -e "[${BRed}Error While Downloading The Wallpaper${Color_Off}]"
#    exit 1
#fi


echo -e "[${BBlue}Cloning Ohmyzsh ${Color_Off}]"


yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >>install.log
if [ $? -eq 0 ];then

  echo -e "[${BGreen}Ohmyzsh Downloaded Successfully${Color_Off}]"
fi

chsh -s $(which zsh) >>install.log 2>>installError.log

echo -e "[${BBlue}Changing Default Shell${Color_Off}]"
if [ $? -eq 0 ];then

  echo -ne "\033[A\033[K"  
  echo -e "[${BGreen}OK${Color_Off}] Shell Changed Successfully"
else
  
  echo -ne "\033[A\033[K"  
  echo -e "[${BRed}Error${Color_Off}] Cannot Change The Shell"
fi

zsh >>install.log

