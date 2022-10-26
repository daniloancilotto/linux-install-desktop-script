#!/bin/bash
system="`lsb_release -sd`"
system_release="`lsb_release -sr`"
system_architecture="`uname -m`"
environment="`plasmashell --version`"

echo "LINUX DESKTOP SCRIPT (PLASMA - UBUNTU)"
echo "Version: 2022.10.26-1110"
echo "Author: Danilo Ancilotto"
echo "Environment: $environment"
echo "System: $system"
echo "Architecture: $system_architecture"
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

root_app_dir="/root/Applications"
sudo mkdir -pv "$root_app_dir"

root_plasmoid_dir="/usr/share/plasma/plasmoids"
sudo mkdir -pv "$root_plasmoid_dir"

home_app_dir="$HOME/Applications"
mkdir -pv "$home_app_dir"

home_autostart_dir="$HOME/.config/autostart"
mkdir -pv "$home_autostart_dir"

home_plasmoid_dir="$HOME/.local/share/plasma/plasmoids"
mkdir -pv "$home_plasmoid_dir"

printLine "Update"
sudo apt update

printLine "NVIDIA X Server Settings"

home_app_name="nvidia-settings"
home_app_subdir="$home_app_dir/$home_app_name"

file="$home_app_subdir/nvidia-settings.sh"
if [ ! -f "$file" ]
then
  mkdir -pv "$home_app_subdir"

  conf=$'#!/bin/bash\n'
  conf+=$'/usr/bin/nvidia-settings -a [gpu:0]/GpuPowerMizerMode=1\n'
  echo "$conf" | sudo tee "$file"
  sudo chmod +x "$file"

  desk=$'[Desktop Entry]\n'
  desk+=$'Exec='$file$'\n'
  desk+=$'Icon=dialog-scripts\n'
  desk+=$'Name=nvidia-settings.sh\n'
  desk+=$'Path=\n'
  desk+=$'Type=Application\n'
  desk+=$'X-KDE-AutostartScript=true\n'
  echo "$desk" > "$home_autostart_dir/nvidia-settings.sh.desktop"
fi

echo "nvidia-settings have been configured"

printLine "Wget"
sudo apt install wget -y

printLine "Zip"
sudo apt install zip unzip -y

printLine "Build Essential"
sudo apt install build-essential -y

printLine "CMake"
sudo apt install cmake extra-cmake-modules -y

printLine "Kssh Askpass"

sudo apt install ksshaskpass -y

home_app_name="ssh-askpass"
home_app_subdir="$home_app_dir/$home_app_name"

file="$home_app_subdir/ssh-askpass.sh"
if [ ! -f "$file" ]
then
  mkdir -pv "$home_app_subdir"

  conf=$'#!/bin/bash\n'
  conf+=$'export SSH_ASKPASS=/usr/bin/ksshaskpass\n'
  conf+=$'/usr/bin/ssh-add </dev/null\n'
  echo "$conf" | sudo tee "$file"
  sudo chmod +x "$file"

  desk=$'[Desktop Entry]\n'
  desk+=$'Exec='$file$'\n'
  desk+=$'Icon=dialog-scripts\n'
  desk+=$'Name=ssh-askpass.sh\n'
  desk+=$'Path=\n'
  desk+=$'Type=Application\n'
  desk+=$'X-KDE-AutostartScript=true\n'
  echo "$desk" > "$home_autostart_dir/ssh-askpass.sh.desktop"
fi

echo "ksshaskpass have been configured"

printLine "AppMenu GTK Modules"
sudo apt install appmenu-gtk2-module appmenu-gtk3-module -y

printLine "Network File Sharing"
sudo apt install kdenetwork-filesharing -y

printLine "Software & Updates"
sudo apt install software-properties-qt -y

printLine "Kate"
sudo apt install kate -y

printLine "KColorChooser"
sudo apt install kcolorchooser -y

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
root_app_version="1de99c9"

home_app_name="window-appmenu-applet"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_github_file="1de99c93b0004b80898081a1acfd1e0be807326a"

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
  sudo apt install qtdeclarative5-dev libkf5plasma-dev libqt5x11extras5-dev libsm-dev libkf5configwidgets-dev libkdecorations2-dev libxcb-randr0-dev libkf5wayland-dev plasma-workspace-dev -y

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
  sudo chown root:root -R "$root_app_subdir"

  if [ -f "$root_plasmoid_dir/org.kde.windowappmenu/metadata.desktop" ]
  then
    echo "$root_app_version" | sudo tee "$root_app_subdir/version.txt"
  fi
else
  echo "$root_app_name is already installed"
fi

home_app_name="window-title-applet"
home_app_subdir="$home_app_dir/$home_app_name"
home_app_cversion="`cat "$home_app_subdir/version.txt"`"
home_app_version="efa9e78"
home_app_github_file="efa9e7860cd59e469b461e94a440d4e0a3f6aeb8"

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

  if [ -f "$home_plasmoid_dir/org.kde.windowtitle/metadata.desktop" ]
  then
    echo "$home_app_version" > "$home_app_subdir/version.txt"
  fi
else
  echo "$home_app_name is already installed"
fi

file="$root_plasmoid_dir/org.kde.plasma.systemmonitor/contents/ui/CompactRepresentation.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/topPadding: 0/topPadding: 1/g' "$file"
  sudo sed -i ':a;N;$!ba;s/bottomPadding: 0/bottomPadding: 2/g' "$file"
fi

file="$root_plasmoid_dir/org.kde.plasma.trash/contents/ui/main.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/maximumWidth: inPanel ? PlasmaCore.Units.iconSizeHints.panel : -1/maximumWidth: inPanel ? 14 : -1/g' "$file"
fi

file="$home_plasmoid_dir/org.kde.windowtitle/contents/ui/main.qml"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/active: text !== ""/active: false/g' "$file"
fi

echo "widgets have been configured"

printLine "Finished"
echo "Please reboot your system."
echo ""