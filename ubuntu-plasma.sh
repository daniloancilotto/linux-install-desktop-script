#!/bin/bash
system="`lsb_release -sd`"
architecture="`uname -m`"
environment="`plasmashell --version`"

echo "LINUX DESKTOP SCRIPT (UBUNTU - PLASMA)"
echo "Author: Danilo Ancilotto"
echo "System: $system"
echo "Architecture: $architecture"
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
  lenght=${#text}
  sudo echo ""
  echo -n "$text"
  for i in {1..80}
  do
    if [ $i -gt $lenght ]
    then
      echo -n "="
    fi
  done
  echo ""
}

home_app_dir="$HOME/Applications"
mkdir -pv "$home_app_dir"

home_plasmoid_dir="$HOME/.local/share/plasma/plasmoids"
mkdir -pv "$home_plasmoid_dir"

printLine "Update"
sudo apt update

printLine "Wget"
sudo apt install wget -y

printLine "Zip"
sudo apt install zip unzip -y

printLine "G++"
sudo apt install g++ -y

printLine "Make"
sudo apt install make cmake extra-cmake-modules -y

printLine "Get Text"
sudo apt install gettext -y

printLine "X11 Libraries"
sudo apt install libsm-dev libxcb-randr0-dev -y

printLine "Qt5 Libraries"
sudo apt install qtbase5-dev qtdeclarative5-dev libqt5x11extras5-dev -y

printLine "Plasma Libraries"
sudo apt install plasma-workspace-dev libkf5plasma-dev libkf5wayland-dev libkf5declarative-dev libkf5configwidgets-dev libkdecorations2-dev -y

printLine "AppMenu GTK Modules"
sudo apt install appmenu-gtk2-module appmenu-gtk3-module -y

printLine "Elisa"
sudo apt install elisa -y

printLine "Kate"
sudo apt install kate -y

printLine "LibreOffice KDE"
sudo apt install libreoffice-kde -y

printLine "Kvantum Manager"
sudo apt install qt5-style-kvantum -y

printLine "Latte"
sudo apt install latte-dock -y

printLine "Plasma Widgets"

home_app_name="window-appmenu-applet"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_cversion="`cat "$home_app_subdir/version.txt"`"
home_app_fversion="879a6dc042f0b012f91b912a3bcc95dd9317e790"
home_app_version="879a6dc"

if [ "$home_app_cversion" != "$home_app_version" ]
then
  current_dir="`pwd`"
  cd "$home_app_subdir"
  sudo chmod +x "$home_app_subdir/uninstall.sh"
  "$home_app_subdir/uninstall.sh"
  cd "$current_dir"

  rm -rf "$home_app_subdir"
fi

if [ ! -d "$home_app_subdir" ]
then
  file="$home_app_dir/$home_app_name.zip"
  wget -O "$file" "https://github.com/psifidotos/applet-window-appmenu/archive/$home_app_fversion.zip"
  unzip -q "$file" -d "$home_app_dir"
  rm -fv "$file"

  mv -fv "$home_app_dir/applet-window-appmenu-$home_app_fversion" "$home_app_subdir"

  current_dir="`pwd`"
  cd "$home_app_subdir"
  sudo chmod +x "$home_app_subdir/install.sh"
  "$home_app_subdir/install.sh"
  cd "$current_dir"

  echo "$home_app_version" > "$home_app_subdir/version.txt"
else
  echo "$home_app_name is already installed"
fi

home_app_name="window-buttons-applet"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_cversion="`cat "$home_app_subdir/version.txt"`"
home_app_fversion="16c66e9b70ad3fd19dede1dd73d1b9ad1c28183b"
home_app_version="16c66e9"

if [ "$home_app_cversion" != "$home_app_version" ]
then
  current_dir="`pwd`"
  cd "$home_app_subdir"
  sudo chmod +x "$home_app_subdir/uninstall.sh"
  "$home_app_subdir/uninstall.sh"
  cd "$current_dir"

  rm -rf "$home_app_subdir"
fi

if [ ! -d "$home_app_subdir" ]
then
  file="$home_app_dir/$home_app_name.zip"
  wget -O "$file" "https://github.com/psifidotos/applet-window-buttons/archive/$home_app_fversion.zip"
  unzip -q "$file" -d "$home_app_dir"
  rm -fv "$file"

  mv -fv "$home_app_dir/applet-window-buttons-$home_app_fversion" "$home_app_subdir"

  current_dir="`pwd`"
  cd "$portable_subdir"
  sudo chmod +x "$portable_subdir/install.sh"
  "$portable_subdir/install.sh"
  cd "$current_dir"

  echo "$portable_version" > "$portable_subdir/version.txt"
else
  echo "$portable_name is already installed"
fi

portable_name="window-title-applet"
portable_subdir="$portable_dir/$portable_name"
portable_cversion="`cat "$portable_subdir/version.txt"`"
portable_fversion="c33da193b3e13c6c01fab79b467d24b021a556fd"
portable_version="c33da19"

if [ "$portable_cversion" != "$portable_version" ]
then
  plasmapkg2 -r "$home_plasmoid_dir/org.kde.windowtitle"

  rm -rf "$portable_subdir"
fi

if [ ! -d "$portable_subdir" ]
then
  file="$portable_dir/$portable_name.zip"
  wget -O "$file" "https://github.com/psifidotos/applet-window-title/archive/$portable_fversion.zip"
  unzip -q "$file" -d "$portable_dir"
  rm -fv "$file"

  mv -fv "$portable_dir/applet-window-title-$portable_fversion" "$portable_subdir"

  current_dir="`pwd`"
  cd "$portable_subdir"
  plasmapkg2 -i "$portable_subdir"
  cd "$current_dir"

  echo "$portable_version" > "$portable_subdir/version.txt"
else
  echo "$portable_name is already installed"
fi

file="/usr/share/plasma/plasmoids/org.kde.plasma.digitalclock/contents/ui/DigitalClock.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/                width: 1/                width: 0/g' "$file"
fi

echo "widgets have been configured"

printLine "Finished"
echo "Please reboot your system."
echo ""