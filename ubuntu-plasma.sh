#!/bin/bash
system="`lsb_release -sd`"
system_release="`lsb_release -sr`"
system_architecture="`uname -m`"
environment="`plasmashell --version`"

echo "LINUX DESKTOP SCRIPT (UBUNTU - PLASMA)"
echo "Version: 2022.4.5-1600"
echo "Author: Danilo Ancilotto"
echo "System: $system"
echo "Architecture: $system_architecture"
echo "Environment: $environment"
echo "Home: $HOME"
echo "User: $USER"
sudo echo -n ""

printLine() {
  text="$1"
  if [ ! -z "$text" ]
  then
    text="$text "
  fi
  length=${#text}
  sudo echo ""
  echo -n "$text"
  for i in {1..80}
  do
    if [ $i -gt $length ]
    then
      echo -n "="
    fi
  done
  echo ""
}

default_plasmoid_dir="/usr/share/plasma/plasmoids"
sudo mkdir -pv "$default_plasmoid_dir"

root_app_dir="/root/Applications"
sudo mkdir -pv "$root_app_dir"

home_app_dir="$HOME/Applications"
mkdir -pv "$home_app_dir"

home_autostart_dir="$HOME/.config/autostart"
mkdir -pv "$home_autostart_dir"

home_autostart_scripts_dir="$HOME/.config/autostart-scripts"
mkdir -pv "$home_autostart_scripts_dir"

home_plasmoid_dir="$HOME/.local/share/plasma/plasmoids"
mkdir -pv "$home_plasmoid_dir"

printLine "Update"
sudo apt update

printLine "NVIDIA X Server Settings"

file="$home_autostart_scripts_dir/nvidia-settings.sh"
if [ ! -f "$file" ]
then
  conf=$'#!/bin/bash\n'
  conf+=$'/usr/bin/nvidia-settings -a [gpu:0]/GpuPowerMizerMode=1\n'
  echo "$conf" | sudo tee "$file"
  sudo chmod +x "$file"
fi

echo "nvidia-settings have been configured"

printLine "Wget"
sudo apt install wget -y

printLine "Zip"
sudo apt install zip unzip -y

printLine "Git"
sudo apt install git -y

printLine "Build Essential"
sudo apt install build-essential -y

printLine "CMake"
sudo apt install cmake extra-cmake-modules -y

printLine "Get Text"
sudo apt install gettext -y

printLine "X11 Libraries"
sudo apt install libx11-dev libx11-xcb-dev libxcb-randr0-dev libxcb-shape0-dev libxcb-util-dev libxcb-util0-dev libsm-dev -y

printLine "Qt5 Libraries"
sudo apt install qtbase5-dev qtdeclarative5-dev libqt5x11extras5-dev kirigami2-dev -y

printLine "Plasma Libraries"
sudo apt install plasma-workspace-dev libkdecorations2-dev libkf5plasma-dev libkf5wayland-dev libkf5declarative-dev libkf5xmlgui-dev libkf5configwidgets-dev -y
sudo apt install libkf5windowsystem-dev libkf5iconthemes-dev libkf5archive-dev libkf5activities-dev libkf5notifications-dev libkf5crash-dev libkf5newstuff-dev -y

printLine "Kssh Askpass"

sudo apt install ksshaskpass -y

file="$home_autostart_scripts_dir/ssh-askpass.sh"
if [ ! -f "$file" ]
then
  conf=$'#!/bin/bash\n'
  conf+=$'export SSH_ASKPASS=/usr/bin/ksshaskpass\n'
  conf+=$'/usr/bin/ssh-add </dev/null\n'
  echo "$conf" | sudo tee "$file"
  sudo chmod +x "$file"
fi

echo "ksshaskpass have been configured"

printLine "AppMenu GTK Modules"
sudo apt install appmenu-gtk2-module appmenu-gtk3-module -y

printLine "Network File Sharing"
sudo apt install kdenetwork-filesharing -y

printLine "Software & Updates"
sudo apt install software-properties-qt -y

printLine "Elisa"
sudo apt install elisa -y

printLine "Latte Dock"
sudo apt install latte-dock -y

printLine "LibreOffice KDE"
sudo apt install libreoffice-kde -y

printLine "Partition Manager"
sudo apt install partitionmanager -y

printLine "Seahorse"

sudo apt install seahorse -y

file="$home_autostart_dir/gnome-keyring-pkcs11.desktop"
if [ ! -f "$file" ]
then
  cp "/etc/xdg/autostart/gnome-keyring-pkcs11.desktop" "$home_autostart_dir"
  sed -i '/^OnlyShowIn.*$/d' "$file"
fi
file="$home_autostart_dir/gnome-keyring-secrets.desktop"
if [ ! -f "$file" ]
then
  cp "/etc/xdg/autostart/gnome-keyring-secrets.desktop" "$home_autostart_dir"
  sed -i '/^OnlyShowIn.*$/d' "$file"
fi
file="$home_autostart_dir/gnome-keyring-ssh.desktop"
if [ ! -f "$file" ]
then
  cp "/etc/xdg/autostart/gnome-keyring-ssh.desktop" "$home_autostart_dir"
  sed -i '/^OnlyShowIn.*$/d' "$file"
fi

echo "seahorse have been configured"

printLine "Plasma Widgets"

root_app_name="window-appmenu-applet"
root_app_subdir="$root_app_dir/$root_app_name"
root_app_cversion="`sudo cat "$root_app_subdir/version.txt"`"
root_app_version="a067154"

home_app_name="window-appmenu-applet"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_github_file="a067154b59202018dc461ce326bb880772cfa5c8"

if [ "$root_app_cversion" != "$root_app_version" ]
then
  sudo mv -f "$root_app_subdir" "$home_app_subdir"
  sudo chown $USER:$USER -R "$home_app_subdir"

  current_dir="`pwd`"
  cd "$home_app_subdir"
  sudo chmod +x "$home_app_subdir/uninstall.sh"
  "$home_app_subdir/uninstall.sh"
  cd "$current_dir"

  rm -rf "$home_app_subdir"
fi

if ! sudo test -d "$root_app_subdir"
then
  file="$home_app_dir/$home_app_name.zip"
  wget -O "$file" "https://github.com/psifidotos/applet-window-appmenu/archive/$home_app_github_file.zip"
  unzip -q "$file" -d "$home_app_dir"
  rm -fv "$file"

  mv -fv "$home_app_dir/applet-window-appmenu-$home_app_github_file" "$home_app_subdir"

  current_dir="`pwd`"
  cd "$home_app_subdir"
  sudo chmod +x "$home_app_subdir/install.sh"
  "$home_app_subdir/install.sh"
  cd "$current_dir"

  sudo mv -f "$home_app_subdir" "$root_app_subdir"
  echo "$root_app_version" | sudo tee "$root_app_subdir/version.txt"
else
  echo "$root_app_name is already installed"
fi

root_app_name="window-buttons-applet"
root_app_subdir="$root_app_dir/$root_app_name"
root_app_cversion="`sudo cat "$root_app_subdir/version.txt"`"
root_app_version="90e3750"

home_app_name="window-buttons-applet"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_github_file="90e37501871a7797e2befc4c524e56f320170780"

if [ "$root_app_cversion" != "$root_app_version" ]
then
  sudo mv -f "$root_app_subdir" "$home_app_subdir"
  sudo chown $USER:$USER -R "$home_app_subdir"

  current_dir="`pwd`"
  cd "$home_app_subdir"
  sudo chmod +x "$home_app_subdir/uninstall.sh"
  "$home_app_subdir/uninstall.sh"
  cd "$current_dir"

  rm -rf "$home_app_subdir"
fi

if ! sudo test -d "$root_app_subdir"
then
  file="$home_app_dir/$home_app_name.zip"
  wget -O "$file" "https://github.com/psifidotos/applet-window-buttons/archive/$home_app_github_file.zip"
  unzip -q "$file" -d "$home_app_dir"
  rm -fv "$file"

  mv -fv "$home_app_dir/applet-window-buttons-$home_app_github_file" "$home_app_subdir"

  current_dir="`pwd`"
  cd "$home_app_subdir"
  sudo chmod +x "$home_app_subdir/install.sh"
  "$home_app_subdir/install.sh"
  cd "$current_dir"

  sudo mv -f "$home_app_subdir" "$root_app_subdir"
  echo "$root_app_version" | sudo tee "$root_app_subdir/version.txt"
else
  echo "$root_app_name is already installed"
fi

home_app_name="window-title-applet"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_cversion="`cat "$home_app_subdir/version.txt"`"
home_app_version="45a5d75"
home_app_github_file="45a5d751b214aa19da51ecfe1f30acd2de2fe700"

if [ "$home_app_cversion" != "$home_app_version" ]
then
  plasmapkg2 -r "$home_plasmoid_dir/org.kde.windowtitle"

  rm -rf "$home_app_subdir"
fi

if [ ! -d "$home_app_subdir" ]
then
  file="$home_app_dir/$home_app_name.zip"
  wget -O "$file" "https://github.com/psifidotos/applet-window-title/archive/$home_app_github_file.zip"
  unzip -q "$file" -d "$home_app_dir"
  rm -fv "$file"

  mv -fv "$home_app_dir/applet-window-title-$home_app_github_file" "$home_app_subdir"

  current_dir="`pwd`"
  cd "$home_app_subdir"
  plasmapkg2 -i "$home_app_subdir"
  cd "$current_dir"

  echo "$home_app_version" > "$home_app_subdir/version.txt"
else
  echo "$home_app_name is already installed"
fi

file="$default_plasmoid_dir/org.kde.plasma.trash/contents/ui/main.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/inPanel ? PlasmaCore.Units.iconSizeHints.panel : -1/inPanel ? 16 : -1/g' "$file"
fi

file="$default_plasmoid_dir/org.kde.plasma.colorpicker/contents/ui/main.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/opacity: 0.6/opacity: 0.2/g' "$file"
fi

file="$default_plasmoid_dir/org.kde.plasma.systemmonitor/contents/ui/CompactRepresentation.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/topPadding: 0/topPadding: 1/g' "$file"
  sudo sed -i ':a;N;$!ba;s/bottomPadding: 0/bottomPadding: 2/g' "$file"
fi

file="$default_plasmoid_dir/org.kde.plasma.private.systemtray/contents/ui/main.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/int cellSpacing: PlasmaCore.Units.smallSpacing \* 2/int cellSpacing: 7/g' "$file"
fi

file="$home_plasmoid_dir/menu11/contents/ui/ItemGridDelegate.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/  font.pointSize: 9/\/\/font.pointSize: 9/g' "$file"
fi

file="$home_plasmoid_dir/menu11/translate/build"
if [ -f "$file" ]
then
  file="$home_plasmoid_dir/menu11/translate/translated.txt"
  if [ ! -f "$file" ]
  then
    current_dir="`pwd`"
    cd "$home_plasmoid_dir/menu11/translate"
    sudo sh ./build
    cd "$current_dir"

    touch "$file"
  fi
fi

echo "widgets have been configured"

printLine "Finished"
echo "Please reboot your system."
echo ""