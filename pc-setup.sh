#!/bin/bash

sdksDirectory="$HOME/SDKs"
downloadsDirectory= "$HOME/Downloads"

print_in_purple(){
    local LIGHT_PURPLE='\033[1;35m'
    local NO_COLOR='\033[0m'
    printf "$LIGHT_PURPLE $1 \n"
    printf "$NO_COLOR"
}

install_essentials(){
    sudo apt-get -y -qq install build-essential
    sudo apt-get -y -qq install git
    sudo apt-get -y -qq install wget
}

install_dev_deps(){
    print_in_purple "Installing Development Dependencies"

    mkdir -p $sdksDirectory

    #Install flutter
    print_in_purple "Intalling flutter"
    git clone https://github.com/flutter/flutter.git $sdksDirectory/flutter
    printf "export PATH=\"\$PATH:$sdksDirectory/flutter/bin\" \n" >> ~/.bashrc  

    # Donet core 3.1
    print_in_purple "Installing dotnet core 3.1"
    wget -p $sdksDirectory https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    sudo dpkg -i packages-microsoft-prod.deb
    sudo apt-get update
    sudo apt-get install -y -qq apt-transport-https
    sudo apt-get update
    sudo apt-get install -y -qq dotnet-sdk-3.1
    rm packages-microsoft-prod.deb
    
    # Rust toolchain and add to bash
    print_in_purple "Intalling Rust toolchain"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    printf "export PATH=$HOME/.cargo/bin:\$PATH\n" >> ~/.bashrc

    source ~/.bashrc
}

#TODO Change to a suitable directory for build
install_terminal(){

    #Install alacritty
    print_in_purple "Installing Alacritty"    
    sudo apt-get -y -qq install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 libegl1-mesa-dev
    sudo git clone https://github.com/alacritty/alacritty.git
    rustup override set stable
    rustup update stable
    sudo chown -R $USER:$USER alacritty
    cd alacritty
    cargo build --release
    sudo cp target/release/alacritty /usr/local/bin
    sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
    sudo desktop-file-install extra/linux/Alacritty.desktop
    sudo update-desktop-database
    cd ../

    mkdir -p $HOME/.config/alacritty

    #Remove gnome-terminal
    #sudo apt remove --purge gnome-terminal
}

install_programs(){
    #Screenshot
    sudo apt-get -y -qq install flameshot

    #Brave Browser
    sudo apt install apt-transport-https curl
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser

    #Steam
    print_in_purple "Installing steam"
    sudo apt-get -y -qq install steam

    #Discord
    print_in_purple "Installing discord"
    sudo apt-get -y -qq install libgconf-2-4 libappindicator1
    cd $downloadsDirectory
    wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
    sudo dpkg -i discord.deb

    #VSCode
    print_in_purple "Installing VS-Code"
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get -y -qq install apt-transport-https
    sudo apt-get -qq update
    sudo apt-get -y -qq install code # or code-insiders

    #Lutris
    print_in_purple "Installing Lutris"
    sudo add-apt-repository ppa:lutris-team/lutris
    sudo apt update
    sudo apt-get install lutris -y -qq

    #Android Studio
    print_in_purple "Installing AndoidStudio"
    sudo apt-get -y -qq install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386
    cd $downloadsDirectory
    wget -O android-studio-download.tar.gz https://r3---sn-cu-c9il.gvt1.com/edgedl/android/studio/ide-zips/4.0.1.0/android-studio-ide-193.6626763-linux.tar.gz

    tar xvzf android-studio-download.tar.gz -C $sdksDirectory

    cd $sdksDirectory
    print_in_purple "REMEMBER TO LAUCH ANDROID STUDIO AT $sdksDirectory/android-studio/bin/studio.sh"
    sudo ./android-studio/bin/studio.sh
}

install_wm_deps(){
    sudo add-apt-repository ppa:regolith-linux/unstable -y
    sudo apt  -y -qq install awesome fonts-roboto rofi picom i3lock xclip qt5-style-plugins materia-gtk-theme lxappearance xbacklight kde-spectacle nautilus xfce4-power-manager pnmixer -y
    wget -qO- https://git.io/papirus-icon-theme-install | sh
    sudo apt  -y -qq install awesome nitrogen
}

setup_fun_stuff(){
    sudo apt-get install neofetch cmatrix -y -qq
    printf "neofetch\n" >> ~/.bashrc
}

install_fonts(){
    cd $downloadsDirectory
    wget https://github.com/i-tu/Hasklig/releases/download/1.1/Hasklig-1.1.zip
    unzip "*.zip" "*.ttf" "*.otf" -d ${HOME}/.fonts
    sudo fc-cache -f -v
}

remove_programs(){
    sudo apt remove --purge gnome-terminal
    sudo apt remove --purge gnome-screenshot #Unable to get comamnd line flags to work for shortcut and CTT already figured out for flameshot
}

install_essentials
install_dev_deps
install_terminal
install_wm_deps
setup_fun_stuff

install_programs

#remove_programs
