#!/bin/bash
system="`lsb_release -sd`"
system_release="`lsb_release -sr`"
system_architecture="`uname -m`"
environment="`plasmashell --version`"

echo "INSTALL DESKTOP APPS (PLASMA - UBUNTU)"
echo "Version: 2024.10.17-2310"
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

menuConf() {
  source_file="/usr/share/applications/$2"
  target_file="$1/$2"
  if [ -f "$source_file" ] && [ "$5" != "--no-replace-file" ]
  then
    cp -fv "$source_file" "$target_file"
  fi
  if [ -f "$target_file" ]
  then
    crudini --set "$target_file" "Desktop Entry" "$3" "$4"
  fi
}

home_app_dir="$HOME/Applications"
mkdir -pv "$home_app_dir"

home_menu_dir="$HOME/.local/share/applications"
mkdir -pv "$home_menu_dir"

home_autostart_dir="$HOME/.config/autostart"
mkdir -pv "$home_autostart_dir"

printLine "Update"
sudo apt update

printLine "Crudini"
sudo apt install crudini -y

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
  echo "$conf" > "$file"
  sudo chmod +x "$file"
fi

desk=$'[Desktop Entry]\n'
desk+=$'Exec='$file$'\n'
desk+=$'Icon=dialog-scripts\n'
desk+=$'Name=ssh-askpass.sh\n'
desk+=$'Path=\n'
desk+=$'Type=Application\n'
desk+=$'X-KDE-AutostartScript=true\n'
echo "$desk" > "$home_autostart_dir/ssh-askpass.sh.desktop"

echo "ksshaskpass have been configured"

printLine "AppMenu GTK Modules"
sudo apt install appmenu-gtk2-module appmenu-gtk3-module -y

printLine "Network File Sharing"
sudo apt install kdenetwork-filesharing -y

printLine "Software & Updates"

sudo apt install software-properties-qt -y

home_app_name="software-properties"
home_app_subdir="$home_app_dir/$home_app_name"

file="$home_app_subdir/software-properties.sh"
if [ ! -f "$file" ]
then
  mkdir -pv "$home_app_subdir"

  conf=$'#!/bin/bash\n'
  conf+=$'sudo software-properties-qt --open-tab=4\n'
  echo "$conf" > "$file"
  sudo chmod +x "$file"
fi

menuConf "$home_menu_dir" "software-properties-qt.desktop" "Exec" "$file; echo \"Closing in 5 seconds...\"; sleep 5"
menuConf "$home_menu_dir" "software-properties-qt.desktop" "Terminal" "true" --no-replace-file
menuConf "$home_menu_dir" "software-properties-qt.desktop" "NoDisplay" "false" --no-replace-file
menuConf "$home_menu_dir" "software-properties-qt.desktop" "X-KDE-SubstituteUID" "false" --no-replace-file

echo "software-properties-qt have been configured"

printLine "Kate"
sudo apt install kate -y

printLine "KColorChooser"
sudo apt install kcolorchooser -y

printLine "KDE Connect"
sudo apt install kdeconnect -y

printLine "LibreOffice Plasma"
sudo apt install libreoffice-plasma -y

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

printLine "Anthy Dictionary Editor"
menuConf "$home_menu_dir" "kasumi.desktop" "NoDisplay" "true"
echo "kasumi have been configured"

printLine "Discover"
menuConf "$home_menu_dir" "org.kde.discover.desktop" "Exec" "plasma-discover %F --mode update"
echo "plasma-discover have been configured"

printLine "KRdp"
menuConf "$home_menu_dir" "org.kde.krdp.desktop" "NoDisplay" "true"
echo "krdpserver have been configured"

printLine "UserFeedback Console"
menuConf "$home_menu_dir" "org.kde.kuserfeedback-console.desktop" "NoDisplay" "true"
echo "userfeedbackconsole have been configured"

printLine "Finished"
echo "Please reboot your system."
echo ""