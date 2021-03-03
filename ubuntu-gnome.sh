#!/bin/bash
system="`lsb_release -sd`"
architecture="`uname -m`"
environment="`gnome-shell --version`"

echo "LINUX DESKTOP SCRIPT (UBUNTU - GNOME)"
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

background_dir="/usr/share/backgrounds"
sudo mkdir -pv "$background_dir"

autostart_dir="$HOME/.config/autostart"
mkdir -pv "$autostart_dir"

qt5ct_dir="$HOME/.config/qt5ct"
mkdir -pv "$qt5ct_dir"

printLine "Update"
sudo apt update

printLine "Wget"
sudo apt install wget -y

printLine "Zip"
sudo apt install zip unzip -y

printLine "Crudini"
sudo apt install crudini -y

printLine "Gtop"
sudo apt install gir1.2-gtop-2.0 -y

printLine "LM Sensors"
sudo apt install lm-sensors -y

printLine "X11 Utils"
sudo apt install x11-utils -y

printLine "Qt5 Settings"

sudo apt install qt5ct -y

file="$qt5ct_dir/qt5ct.conf"
crudini --set "$file" "Appearance" "color_scheme_path" "/usr/share/qt5ct/colors/darker.conf"
crudini --set "$file" "Appearance" "custom_palette" "true"
# crudini --set "$file" "Appearance" "icon_theme" "Yaru"
crudini --set "$file" "Appearance" "style" "Fusion"
crudini --set "$file" "Fonts" "fixed" "@Variant(\0\0\0@\0\0\0\x16\0U\0\x62\0u\0n\0t\0u\0 \0M\0o\0n\0o@*\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)"
crudini --set "$file" "Fonts" "general" "@Variant(\0\0\0@\0\0\0\f\0U\0\x62\0u\0n\0t\0u@&\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)"
crudini --set "$file" "Interface" "buttonbox_layout" "3"
crudini --set "$file" "Interface" "stylesheets" "/usr/share/qt5ct/qss/fusion-fixes.qss, /usr/share/qt5ct/qss/tooltip-simple.qss"

file="/etc/profile.d/qpa-platformtheme-qt5ct.sh"
if [ ! -f "$file" ]
then
  conf=$'#!/bin/bash\n'
  conf+=$'export QT_QPA_PLATFORMTHEME=qt5ct\n'
  echo "$conf" | sudo tee "$file"
  sudo chmod +x "$file"
fi

echo "qt5ct have been configured"

printLine "Dconf Editor"
sudo apt install dconf-editor dconf-cli -y

printLine "GNOME Tweaks"
sudo apt install gnome-tweaks -y

printLine "GNOME Extensions"
sudo apt install gnome-shell-extension-prefs -y

printLine "GNOME Browser Integration"
sudo apt install chrome-gnome-shell -y

printLine "GNOME AppGrid"

dconf write /org/gnome/desktop/privacy/remember-app-usage "false"
dconf write /org/gnome/desktop/privacy/remember-recent-files "false"
dconf write /org/gnome/desktop/search-providers/disable-external "true"
dconf write /org/gnome/desktop/wm/preferences/num-workspaces "1"
dconf write /org/gnome/mutter/dynamic-workspaces "false"
dconf write /org/gnome/desktop/app-folders/folder-children "'[]'"

echo "appgrid have been configured"

printLine "GNOME Widgets"

spices_dir="$HOME/.local/share/gnome-shell"
spices=( \
  "extensions" \
)
i=0
while [ $i != ${#spices[@]} ]
do
  spice="${spices[$i]}"

  spice_items_dir="$spices_dir/$spice"
  spice_items=()
  spice_items_names=()
  if [ "$spice" == "extensions" ]
  then
    spice_items=( \
      "https://extensions.gnome.org/extension-data/unitehardpixel.eu.v45.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/clock-overridegnomeshell.kryogenix.org.v12.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/openweather-extensionjenslody.de.v105.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/VitalsCoreCoding.com.v39.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/clipboard-indicatortudmotu.com.v34.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/sound-output-device-chooserkgshank.net.v34.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/bluetooth-quick-connectbjarosze.gmail.com.v13.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/applications-overview-tooltipRaphaelRochet.v9.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v40.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/dash-to-dockmicxgx.gmail.com.v69.shell-extension.zip" \
    )
    spice_items_names=( \
      "unite@hardpixel.eu" \
      "clock-override@gnomeshell.kryogenix.org" \
      "openweather-extension@jenslody.de" \
      "Vitals@CoreCoding.com" \
      "clipboard-indicator@tudmotu.com" \
      "sound-output-device-chooser@kgshank.net" \
      "bluetooth-quick-connect@bjarosze.gmail.com" \
      "applications-overview-tooltip@RaphaelRochet" \
      "user-theme@gnome-shell-extensions.gcampax.github.com" \
      "dash-to-dock@micxgx.gmail.com" \
    )
  fi

  j=0
  while [ $j != ${#spice_items[@]} ]
  do
    spice_item="${spice_items[$j]}"

    spice_item_file="${spice_item##*/}"
    spice_item_name="${spice_items_names[$j]}"
    if [ ! -d "$spice_items_dir/$spice_item_name" ]
    then
      mkdir -pv "$spice_items_dir"
      file="$spice_items_dir/$spice_item_file"
      wget -O "$file" "${spice_item}"
      unzip -q "$file" -d "$spice_items_dir/$spice_item_name"
      rm -fv "$file"
    else
      echo "$spice_item_name is already installed"
    fi

    let "j++"
  done

  let "i++"
done

dconf write /org/gnome/shell/extensions/dash-to-dock/show-apps-at-top "true"
dconf write /org/gnome/shell/extensions/dash-to-dock/animate-show-apps "false"

file="$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/stylesheet.css"
if [ -f "$file" ]
then
  sed -i ':a;N;$!ba;s/border:1px;/border:0px;/g' "$file"
fi

echo "widgets have been configured"

printLine "GNOME Appearances"

background_subdir="$background_dir/mojave_dynamic"
background_dropbox_path="pvul84imc65272e"

if [ ! -d "$background_subdir" ]
then
  file="$background_subdir.zip"
  sudo wget -O "$file" "https://www.dropbox.com/s/$background_dropbox_path/mojave_dynamic.zip"
  sudo unzip -q "$file" -d "$background_dir"
  sudo rm -fv "$file"
else
  echo "mojave_dynamic is already installed"
fi

printLine "Finished"
echo "Please reboot your system."
echo ""