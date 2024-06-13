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


installPackage() {
local package="$1"

rpm -q "$package" 2>installError.log 1>install.log

if [ $? -eq 0 ]; then
  echo -e "[${BGreen}OK${Color_Off}] Package $package already installed"
else
  echo -e "[${BRed}Error${Color_Off}] Package $package not installed"
  sudo dnf install "$package" -y | grep "Estimated download time" | awk '{print $4}' >install.log
  echo -ne "\033[A\033[K"  
  echo -e "[${BGreen}OK${Color_Off}] Package $package installed successfully"
fi
}

packages=("htop" "curl" "wget" "rofi" "i3" "python3" "telnet" "telnet-server" "dbus-devel" "gcc" "git" "libconfig-devel" "libdrm-devel" "libev-devel" "libX11-devel" "libX11-xcb" "neofetch" "gcc" "g++" "libXext-devel" "libxcb-devel" "libGL-devel" "libEGL-devel" "meson" "pcre2-devel" "pixman-devel" "uthash-devel" "xcb-util-image-devel" "xcb-util-renderutil-devel" "xorg-x11-proto-devel" "playerctl" "gnome-system-monitor" "brightnessctl" "light" "xbacklight" "blueman" "zsh" "grep" "sed" "curl" "mpv" "yt-dlp" "ffmpeg" "fzf" "patch" "git" "wget" "vim" "neovim" "gnome-system-monitor"  "pavucontrol" "python3-tkinter" "httpd" "xinput")  
echo -ne "${UWhite}Installing Needed Packages And Dependecies For My Config :${Color_Off} \n \n"
for package in "${packages[@]}"; do
installPackage "$package"
done

#find -iname "*.log" | xargs rm
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

configDir = ("i3" "rofi" "picom" "kitty" "nvim" "yazi")

for directories in "${configDir[@]}";do 

  if ! -d "/home/$USER/.config/$directories" ;then

    echo -e "[${BRed}Error${Color_Off}] Cannot find $directories config file"
    echo -ne "\033[A\033[K"  
    mkdir  "/home/$USER/.config/$directories"
  fi
done
chsh -s $(which zsh) >>install.log 2>>installError.log

echo -e "[${BBlue}Changing Default Shell${Color_Off}]"
if [ $? -eq 0 ];then

echo -ne "\033[A\033[K"  
echo -e "[${BGreen}OK${Color_Off}] Shell Changed Successfully"
else

echo -ne "\033[A\033[K"  
echo -e "[${BRed}Error${Color_Off}] Cannot Change The Shell"
fi

