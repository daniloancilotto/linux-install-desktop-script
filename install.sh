#!/bin/bash
args=("$@")
arch="amd64"
if [ "$(uname -m)" != "x86_64" ]
then
  arch="i386"
fi

echo "DESKTOP ENVIRONMENT SCRIPT"
echo "Arguments: [$args]"
echo "Architecture: $arch"
echo "Interface: $DESKTOP_SESSION"
echo "User: $USER"
echo "Home: $HOME"
echo "Author: Danilo Ancilotto"

# Functions
dpkgInstall() {
  file="$HOME/$1"
  wget -O "$file" "$2"
  sudo dpkg -i "$file"
  rm -fv "$file"
  sudo apt install -fy
}

# Base
sudo apt update
sudo apt install snapd flatpak curl wget git unzip tar neofetch htop -y
sudo systemctl enable --now snapd.socket
sudo flatpak remote-add --if-not-exists flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"

# Angry IP Scanner
if [ ! -f "/usr/bin/ipscan" ]
then
  dpkgInstall "angry-ip-scanner.deb" "https://github.com/angryip/ipscan/releases/download/3.5.5/ipscan_3.5.5_$arch.deb"
fi

# Dconf Editor
sudo apt install dconf-editor -y

# Discord
echo "Installing discord snap..."
sudo snap install discord

# Dropbox
sudo apt install dropbox -y

# Furius ISO Mount
sudo apt install furiusisomount -y

# Google Chrome
if [ -z "$(google-chrome --version)" ]
then
  dpkgInstall "google-chrome.deb" "https://dl.google.com/linux/direct/google-chrome-stable_current_$arch.deb"
fi

# GParted
sudo apt install gparted -y

# OBS Studio
sudo flatpak install flathub com.obsproject.Studio -y

# Oracle VM VirtualBox
virtualbox_installer="https://download.virtualbox.org/virtualbox/6.0.8/virtualbox-6.0_6.0.8-130520~Ubuntu~bionic_$arch.deb"
virtualbox_extension="https://download.virtualbox.org/virtualbox/6.0.8/Oracle_VM_VirtualBox_Extension_Pack-6.0.8.vbox-extpack"
if [ "$arch" == "i386" ]
then
  virtualbox_installer="https://download.virtualbox.org/virtualbox/5.2.30/virtualbox-5.2_5.2.30-130521~Ubuntu~xenial_$arch.deb"
  virtualbox_extension="https://download.virtualbox.org/virtualbox/5.2.30/Oracle_VM_VirtualBox_Extension_Pack-5.2.30.vbox-extpack"
fi
if [ -z "$(vboxmanage --version)" ]
then
  dpkgInstall "oracle-vm-virtualbox.deb" "$virtualbox_installer"
fi
if [ -z "$(vboxmanage list extpacks | grep -i 'version')" ]
then
  file="$HOME/Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack"
  wget -O "$file" "$virtualbox_extension"
  echo y | sudo vboxmanage extpack install "$file"
  rm -fv "$file"
fi
sudo usermod -aG vboxusers $USER

# Remmina
sudo apt install remmina remmina-plugin-rdp remmina-plugin-vnc -y

# Spotify
echo "Installing spotify snap..."
sudo snap install spotify

# Steam
sudo apt install steam -y

# Cinnamon Add-ons
if [ "$DESKTOP_SESSION" == "cinnamon" ] && [[ "${args[@]}" =~ "--with-add-ons" ]]
then
  # Panels
  echo "Adding panels dconf..."
  dconf write /org/cinnamon/desktop/interface/clock-show-date "true"
  dconf write /org/cinnamon/desktop/interface/clock-show-seconds "true"
  dconf write /org/cinnamon/desktop/screensaver/date-format "' %A   %d/%m/%Y'"
  dconf write /org/cinnamon/desktop/screensaver/time-format "'%H:%M:%S'"
  dconf write /org/cinnamon/desktop/screensaver/use-custom-format "true"
  dconf write /org/cinnamon/favorite-apps "[
    'cinnamon-settings.desktop',
    'mintinstall.desktop',
    'cinnamon-settings-info.desktop'
  ]"
  dconf write /org/cinnamon/panels-enabled "[
    '1:0:top',
    '2:0:left'
  ]"
  dconf write /org/cinnamon/panels-height "[
    '1:32',
    '2:52'
  ]"
  dconf write /org/cinnamon/panel-zone-icon-sizes "'"'[{"panelId": 1, "left": 16, "center": 16, "right": 16}, {"panelId": 2, "left": 32, "center": 32, "right": 32}]'"'"
  echo "panels dconf added"

  # Windows
  echo "Adding windows dconf..."
  dconf write /org/cinnamon/alttab-switcher-enforce-primary-monitor "true"
  dconf write /org/cinnamon/alttab-switcher-show-all-workspaces "true"
  dconf write /org/cinnamon/alttab-switcher-style "'timeline'"
  dconf write /org/cinnamon/bring-windows-to-current-workspace "true"
  dconf write /org/cinnamon/desktop/wm/preferences/mouse-button-modifier "'<Super>'"
  dconf write /org/cinnamon/muffin/attach-modal-dialogs "true"
  echo "windows dconf added"

  # Plugins
  echo "Adding plugins dconf..."
  dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action "'nothing'"
  dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action "'nothing'"
  echo "plugins dconf added"

  # Spices
  echo "Adding nexts dconf..."
  dconf write /org/cinnamon/next-applet-id "0"
  dconf write /org/cinnamon/next-desklet-id "0"
  echo "nexts dconf added"

  cinnamon_spices_dir="$HOME/.local/share/cinnamon"
  cinnamon_spices=( \
    "applets" \
    "desklets" \
    "extensions" \
  )
  i=0
  while [ $i != ${#cinnamon_spices[@]} ]
  do
    cinnamon_spice="${cinnamon_spices[$i]}"

    cinnamon_spice_items_dir="$cinnamon_spices_dir/$cinnamon_spice"
    cinnamon_spice_items=()
    if [ "$cinnamon_spice" == "applets" ]
    then
      cinnamon_spice_items=( \
        "https://cinnamon-spices.linuxmint.com/files/applets/betterlock.zip" \
        "https://cinnamon-spices.linuxmint.com/files/applets/cpu-monitor-text@gnemonix.zip" \
        "https://cinnamon-spices.linuxmint.com/files/applets/mem-monitor-text@datanom.net.zip" \
        "https://cinnamon-spices.linuxmint.com/files/applets/weather@mockturtl.zip" \
      )
    elif [ "$cinnamon_spice" == "extensions" ]
    then
      cinnamon_spice_items=( \
        "https://cinnamon-spices.linuxmint.com/files/extensions/transparent-panels@germanfr.zip" \
      )
    fi
    j=0
    while [ $j != ${#cinnamon_spice_items[@]} ]
    do
      cinnamon_spice_item="${cinnamon_spice_items[$j]}"

      cinnamon_spice_item_file="${cinnamon_spice_item##*/}"
      cinnamon_spice_item_name="${cinnamon_spice_item_file%.*}"
      if [ ! -d "$cinnamon_spice_items_dir/$cinnamon_spice_item_name" ]
      then
        mkdir -pv "$cinnamon_spice_items_dir"
        file="$cinnamon_spice_items_dir/$cinnamon_spice_item_file"
        wget -O "$file" "$cinnamon_spice_item"
        unzip "$file" -d "$cinnamon_spice_items_dir"
        rm -fv "$file"
      fi

      let "j++"
    done

    cinnamon_spice_dconf="'[]'"
    if [ "$cinnamon_spice" == "applets" ]
    then
      cinnamon_spice_dconf="[
        'panel1:left:0:menu@cinnamon.org',
        'panel1:center:0:cpu-monitor-text@gnemonix',
        'panel1:center:1:mem-monitor-text@datanom.net',
        'panel1:right:0:notifications@cinnamon.org',
        'panel1:right:1:weather@mockturtl',
        'panel1:right:2:trash@cinnamon.org',
        'panel1:right:3:removable-drives@cinnamon.org',
        'panel1:right:4:systray@cinnamon.org',
        'panel1:right:5:keyboard@cinnamon.org',
        'panel1:right:6:betterlock',
        'panel1:right:7:xrandr@cinnamon.org',
        'panel1:right:8:blueberry@cinnamon.org',
        'panel1:right:9:network@cinnamon.org',
        'panel1:right:10:sound@cinnamon.org',
        'panel1:right:11:power@cinnamon.org',
        'panel1:right:12:calendar@cinnamon.org',
        'panel2:left:0:grouped-window-list@cinnamon.org'
      ]"
    elif [ "$cinnamon_spice" == "extensions" ]
    then
      cinnamon_spice_dconf="[
        'transparent-panels@germanfr'
      ]"
    fi

    echo "Adding $cinnamon_spice dconf..."
    dconf write /org/cinnamon/enabled-$cinnamon_spice "$cinnamon_spice_dconf"
    echo "$cinnamon_spice dconf added"

    let "i++"
  done

  # Skins
  cinnamon_skins_dir="$HOME/.themes"
  cinnamon_skin_name="Mojave-2019-06-23-Dark"
  if [ ! -d "$cinnamon_skins_dir/$cinnamon_skin_name" ]
  then
    mkdir -pv "$cinnamon_skins_dir"
    file="$cinnamon_skins_dir/mojave-dark.tar.xz"
    wget -O "$file" "https://github.com/daniloancilotto/mojave-gtk-theme/releases/download/2019-06-23/Mojave-dark.tar.xz"
    tar -xf "$file" -C "$cinnamon_skins_dir"
    mv -fv "$cinnamon_skins_dir/Mojave-dark" "$cinnamon_skins_dir/$cinnamon_skin_name"
    rm -fv "$file"
  fi

  # Icons
  cinnamon_icons_dir="$HOME/.icons"
  cinnamon_icon_name="Korla-1.1.4-Dark"
  if [ ! -d "$cinnamon_icons_dir/$cinnamon_icon_name" ]
  then
    mkdir -pv "$cinnamon_icons_dir"
    file="$cinnamon_icons_dir/korla-dark.zip"
    wget -O "$file" "https://github.com/bikass/korla/archive/v1.1.4.zip"
    unzip "$file" -d "$cinnamon_icons_dir"
    mv -fv "$cinnamon_icons_dir/korla-1.1.4/korla" "$cinnamon_icons_dir/$cinnamon_icon_name"
    rm -rfv "$cinnamon_icons_dir/korla-1.1.4"
    rm -fv "$file"
  fi

  # Cursors
  cinnamon_cursors_dir="$HOME/.icons"
  cinnamon_cursor_name="Capitaine-Cursors-R3-Light"
  if [ ! -d "$cinnamon_cursors_dir/$cinnamon_cursor_name" ]
  then
    mkdir -pv "$cinnamon_cursors_dir"
    file="$cinnamon_cursors_dir/capitaine-cursors-light.tar.xz"
    wget -O "$file" "https://github.com/keeferrourke/capitaine-cursors/releases/download/r3/capitaine-cursors-light.tar.xz"
    tar -xf "$file" -C "$cinnamon_cursors_dir"
    mv -fv "$cinnamon_cursors_dir/dist-white" "$cinnamon_cursors_dir/$cinnamon_cursor_name"
    rm -fv "$file"
  fi

  # Backgrounds
  cinnamon_backgrounds_dir="$HOME/.cinnamon/backgrounds"
  cinnamon_backgrounds=( \
    "Light" \
    "Dark" \
  )
  cinnamon_backgrounds_userlist="$cinnamon_backgrounds_dir/user-folders.lst"
  mkdir -pv "$cinnamon_backgrounds_dir"
  cp /dev/null "$cinnamon_backgrounds_userlist"
  i=0
  while [ $i != ${#cinnamon_backgrounds[@]} ]
  do
    cinnamon_background="${cinnamon_backgrounds[$i]}"

    cinnamon_background_items_dir="$cinnamon_backgrounds_dir/$cinnamon_background"
    cinnamon_background_items=()
    if [ "$cinnamon_background" == "Dark" ]
    then
      cinnamon_background_items=( \
        "https://w.wallhaven.cc/full/ym/wallhaven-ymxx57.jpg" \
        "https://w.wallhaven.cc/full/nk/wallhaven-nkmjyq.jpg" \
        "https://w.wallhaven.cc/full/0q/wallhaven-0qk8qr.jpg" \
      )
    fi
    mkdir -pv "$cinnamon_background_items_dir"
    echo "$cinnamon_background_items_dir" >> "$cinnamon_backgrounds_userlist"
    j=0
    while [ $j != ${#cinnamon_background_items[@]} ]
    do
      cinnamon_background_item="${cinnamon_background_items[$j]}"

      cinnamon_background_item_file="${cinnamon_background_item##*/}"
      if [ ! -f "$cinnamon_background_items_dir/$cinnamon_background_item_file" ]
      then
        wget -O "$cinnamon_background_items_dir/$cinnamon_background_item_file" "$cinnamon_background_item"
      fi

      let "j++"
    done

    let "i++"
  done

  # Themes
  echo "Adding themes dconf..."
  dconf write /org/cinnamon/desktop/background/picture-uri "'file://$cinnamon_background_items_dir/$cinnamon_background_item_file'"
  dconf write /org/cinnamon/desktop/background/slideshow/delay "5"
  dconf write /org/cinnamon/desktop/background/slideshow/image-source "'directory://$cinnamon_background_items_dir'"
  dconf write /org/cinnamon/desktop/background/slideshow/random-order "true"
  dconf write /org/cinnamon/desktop/background/slideshow/slideshow-enabled "true"
  dconf write /org/cinnamon/desktop/interface/cursor-theme "'$cinnamon_cursor_name'"
  #dconf write /org/cinnamon/desktop/interface/cursor-theme-backup "'DMZ-White'"
  dconf write /org/cinnamon/desktop/interface/gtk-theme "'$cinnamon_skin_name'"
  dconf write /org/cinnamon/desktop/interface/gtk-theme-backup "'Mint-Y-Dark-Blue'"
  dconf write /org/cinnamon/desktop/interface/icon-theme "'$cinnamon_icon_name'"
  dconf write /org/cinnamon/desktop/interface/icon-theme-backup "'Mint-Y-Blue'"
  dconf write /org/cinnamon/desktop/wm/preferences/button-layout "'close,minimize,maximize:'"
  dconf write /org/cinnamon/desktop/wm/preferences/theme "'$cinnamon_skin_name'"
  dconf write /org/cinnamon/desktop/wm/preferences/theme-backup "'Mint-Y-Dark'"
  dconf write /org/cinnamon/desktop/wm/preferences/titlebar-font "'Noto Sans 10'"
  dconf write /org/cinnamon/theme/name "'$cinnamon_skin_name'"
  #dconf write /org/cinnamon/theme/name-backup "'Mint-Y-Dark-Blue'"
  dconf write /org/cinnamon/theme/symbolic-relative-size "1.0"
  dconf write /org/cinnamon/settings-daemon/plugins/xsettings/buttons-have-icons "true"
  echo "themes dconf added"
fi

# Reboot
echo "Done, please reboot your system."
