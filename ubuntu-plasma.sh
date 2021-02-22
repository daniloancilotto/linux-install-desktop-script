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

printLine "Update"
sudo apt update

printLine "Elisa"
sudo apt install elisa -y

printLine "Kate"
sudo apt install kate -y
sudo apt purge kwrite -y

printLine "Kvantum Manager"
sudo apt install qt5-style-kvantum -y

printLine "Latte"
sudo apt install latte-dock -y

printLine "Finished"
echo "Please reboot your system."
echo ""