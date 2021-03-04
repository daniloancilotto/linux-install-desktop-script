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

plasmoid_dir="$HOME/.local/share/plasma/plasmoids"
mkdir -pv "$plasmoid_dir"

portable_dir="$HOME/Applications"
mkdir -pv "$portable_dir"

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

portable_name="window-appmenu-applet"
portable_subdir="$portable_dir/$portable_name"
portable_cversion="`cat "$portable_subdir/version.txt"`"
portable_fversion="d77d03879fc032066ec00d30878742cc7aa83767"
portable_version="d77d038"

if [ "$portable_cversion" != "$portable_version" ]
then
  current_dir="`pwd`"
  cd "$portable_subdir"
  sudo chmod +x "$portable_subdir/uninstall.sh"
  "$portable_subdir/uninstall.sh"
  cd "$current_dir"

  rm -rf "$portable_subdir"
fi

if [ ! -d "$portable_subdir" ]
then
  file="$portable_dir/$portable_name.zip"
  wget -O "$file" "https://github.com/psifidotos/applet-window-appmenu/archive/$portable_fversion.zip"
  unzip -q "$file" -d "$portable_dir"
  rm -fv "$file"

  mv -fv "$portable_dir/applet-window-appmenu-$portable_fversion" "$portable_subdir"

  current_dir="`pwd`"
  cd "$portable_subdir"
  sudo chmod +x "$portable_subdir/install.sh"
  "$portable_subdir/install.sh"
  cd "$current_dir"

  echo "$portable_version" > "$portable_subdir/version.txt"
else
  echo "$portable_name is already installed"
fi

portable_name="window-buttons-applet"
portable_subdir="$portable_dir/$portable_name"
portable_cversion="`cat "$portable_subdir/version.txt"`"
portable_fversion="16c66e9b70ad3fd19dede1dd73d1b9ad1c28183b"
portable_version="16c66e9"

if [ "$portable_cversion" != "$portable_version" ]
then
  current_dir="`pwd`"
  cd "$portable_subdir"
  sudo chmod +x "$portable_subdir/uninstall.sh"
  "$portable_subdir/uninstall.sh"
  cd "$current_dir"

  rm -rf "$portable_subdir"
fi

if [ ! -d "$portable_subdir" ]
then
  file="$portable_dir/$portable_name.zip"
  wget -O "$file" "https://github.com/psifidotos/applet-window-buttons/archive/$portable_fversion.zip"
  unzip -q "$file" -d "$portable_dir"
  rm -fv "$file"

  mv -fv "$portable_dir/applet-window-buttons-$portable_fversion" "$portable_subdir"

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
  plasmapkg2 -r "$plasmoid_dir/org.kde.windowtitle"

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