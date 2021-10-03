#!/bin/bash
system="`lsb_release -sd`"
system_release="`lsb_release -sr`"
system_architecture="`uname -m`"
environment="`plasmashell --version`"

echo "LINUX DESKTOP SCRIPT (UBUNTU - PLASMA)"
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

printLine "Kvantum Manager"
sudo apt install qt5-style-kvantum -y

printLine "Latte Dock"

root_app_name="latte-dock"
root_app_subdir="$root_app_dir/$root_app_name"
root_app_cversion="`sudo cat "$root_app_subdir/version.txt"`"
root_app_version="c86878f"

home_app_name="latte-dock"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_github_file="c86878f6c73a3c40ec877fe0c3663279623b39b9"

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
  wget -O "$file" "https://github.com/KDE/latte-dock/archive/$home_app_github_file.zip"
  unzip -q "$file" -d "$home_app_dir"
  rm -fv "$file"

  mv -fv "$home_app_dir/latte-dock-$home_app_github_file" "$home_app_subdir"

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
root_app_version="d440d24"

home_app_name="window-appmenu-applet"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_github_file="d440d2474b0dd05211ad50aaf1cfdc9109cb9f9e"

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
root_app_version="9910320"

home_app_name="window-buttons-applet"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_github_file="9910320f3e91fc9c3dba6ecf3c173bf5f94d4a86"

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
home_app_version="a6197ee"
home_app_github_file="a6197ee02fe5c5a9287d7679b85e77f06a7ba81e"

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

file="$default_plasmoid_dir/org.kde.plasma.digitalclock/contents/ui/DigitalClock.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/                width: 1/                width: 0/g' "$file"
fi

echo "widgets have been configured"

printLine "Finished"
echo "Please reboot your system."
echo ""