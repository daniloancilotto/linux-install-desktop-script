#!/bin/bash
environment="`gnome-shell --version`"
system="`lsb_release -sd`"
architecture="`uname -m`"

echo "LINUX DESKTOP SCRIPT (UBUNTU)"
echo "Author: Danilo Ancilotto"
echo "Environment: $environment"
echo "System: $system"
echo "Architecture: $architecture"
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

desktopConf() {
  source_file="/usr/share/applications/$2"
  target_file="$1/$2"
  if [ -f "$source_file" ] && [ ! -f "$target_file" ]
  then
    cp "$source_file" "$target_file"
  fi
  if [ -f "$target_file" ]
  then
    crudini --set "$target_file" "Desktop Entry" "$3" "$4"
  fi
}

printLine "Update"
sudo apt update

desktop_dir="$HOME/.local/share/applications"
mkdir -pv "$desktop_dir"

wallpaper_dir="$HOME/.local/share/backgrounds"
mkdir -pv "$wallpaper_dir"

script_dir="$HOME/.local/share/nautilus/scripts"
mkdir -pv "$script_dir"

autostart_dir="$HOME/.config/autostart"
mkdir -pv "$autostart_dir"

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

qt5ct_dir="$HOME/.config/qt5ct"
mkdir -pv "$qt5ct_dir"

printLine "Dconf Editor"
sudo apt install dconf-editor dconf-cli -y

printLine "GNOME Tweaks"
sudo apt install gnome-tweaks -y

printLine "GNOME Extensions"
sudo apt install gnome-shell-extension-prefs -y
sudo apt install chrome-gnome-shell -y

printLine "GNOME Spices"

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
      "https://extensions.gnome.org/extension-data/unitehardpixel.eu.v41.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/clock-overridegnomeshell.kryogenix.org.v12.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/openweather-extensionjenslody.de.v102.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/VitalsCoreCoding.com.v33.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/caffeinepatapon.info.v35.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/clipboard-indicatortudmotu.com.v34.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/sound-output-device-chooserkgshank.net.v31.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/applications-overview-tooltipRaphaelRochet.v8.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v40.shell-extension.zip" \
    )
    spice_items_names=( \
      "unite@hardpixel.eu" \
      "clock-override@gnomeshell.kryogenix.org" \
      "openweather-extension@jenslody.de" \
      "Vitals@CoreCoding.com" \
      "caffeine@patapon.info" \
      "clipboard-indicator@tudmotu.com" \
      "sound-output-device-chooser@kgshank.net" \
      "applications-overview-tooltip@RaphaelRochet" \
      "user-theme@gnome-shell-extensions.gcampax.github.com" \
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

  spice_dconf="'[]'"
  if [ "$spice" == "extensions" ]
  then
    spice_dconf="[
      'unite@hardpixel.eu',
      'clock-override@gnomeshell.kryogenix.org',
      'openweather-extension@jenslody.de',
      'Vitals@CoreCoding.com',
      'caffeine@patapon.info',
      'clipboard-indicator@tudmotu.com',
      'sound-output-device-chooser@kgshank.net',
      'applications-overview-tooltip@RaphaelRochet',                                                               
      'user-theme@gnome-shell-extensions.gcampax.github.com',
      'ubuntu-appindicators@ubuntu.com',
      'ubuntu-dock@ubuntu.com',
      'desktop-icons@csoriano'
    ]"
  fi

  dconf write /org/gnome/shell/enabled-$spice "$spice_dconf"

  let "i++"
done

dconf write /org/gnome/shell/extensions/unite/desktop-name-text "'$system'"
dconf write /org/gnome/shell/extensions/unite/hide-app-menu-icon "false"
dconf write /org/gnome/shell/extensions/unite/show-window-title "'always'"
dconf write /org/gnome/shell/extensions/unite/notifications-position "'center'"
dconf write /org/gnome/shell/extensions/unite/hide-aggregate-menu-arrow "true"
dconf write /org/gnome/shell/extensions/unite/window-buttons-placement "'last'"
dconf write /org/gnome/shell/extensions/unite/window-buttons-theme "'yaru'"
dconf write /org/gnome/shell/extensions/unite/extend-left-box "false"
dconf write /org/gnome/shell/extensions/unite/use-system-fonts "false"
dconf write /org/gnome/shell/extensions/clock_override/override-string "'%d/%m/%Y  %H:%M:%S'"
dconf write /org/gnome/shell/extensions/openweather/city "'-21.1328313,-51.1029422>Mirandópolis, BR>-1'"
dconf write /org/gnome/shell/extensions/openweather/days-forecast "10"
dconf write /org/gnome/shell/extensions/openweather/decimal-places "0"
dconf write /org/gnome/shell/extensions/openweather/pressure-unit "'hPa'"
dconf write /org/gnome/shell/extensions/openweather/unit "'celsius'"
dconf write /org/gnome/shell/extensions/openweather/wind-speed-unit "'kph'"
dconf write /org/gnome/shell/extensions/vitals/alphabetize "false"
dconf write /org/gnome/shell/extensions/vitals/position-in-panel "1"
dconf write /org/gnome/shell/extensions/vitals/hot-sensors "[
  '_processor_average_',
  '__temperature_avg__',
  '_memory_usage_',
  '_storage_free_'
]"
dconf write /org/gnome/shell/extensions/vitals/storage-path "'$HOME'"
dconf write /org/gnome/shell/extensions/caffeine/enable-fullscreen "false"
dconf write /org/gnome/shell/extensions/caffeine/show-notifications "false"
dconf write /org/gnome/shell/extensions/caffeine/restore-state "true"
dconf write /org/gnome/shell/extensions/clipboard-indicator/enable-keybindings "false"
dconf write /org/gnome/shell/extensions/clipboard-indicator/cache-only-favorites "true"
dconf write /org/gnome/shell/extensions/applications-overview-tooltip/borders "false"
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed "true"
dconf write /org/gnome/shell/extensions/dash-to-dock/extend-height "true"
dconf write /org/gnome/shell/extensions/dash-to-dock/show-apps-at-top "true"
dconf write /org/gnome/shell/extensions/dash-to-dock/animate-show-apps "false"
dconf write /org/gnome/shell/extensions/dash-to-dock/apply-custom-theme "true"
dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size "32"
dconf write /org/gnome/shell/extensions/dash-to-dock/click-action "'minimize-or-previews'"
dconf write /org/gnome/shell/extensions/dash-to-dock/show-delay "0.0"
dconf write /org/gnome/shell/extensions/dash-to-dock/hide-delay "0.0"
dconf write /org/gnome/shell/extensions/dash-to-dock/show-trash "true"
dconf write /org/gnome/shell/extensions/desktop-icons/icon-size "'small'"
dconf write /org/gnome/shell/extensions/desktop-icons/show-home "false"
dconf write /org/gnome/shell/extensions/desktop-icons/show-trash "false"
dconf write /org/gnome/shell/favorite-apps "[
  'update-manager.desktop',
  'org.gnome.Terminal.desktop',
  'org.gnome.Nautilus.desktop',
  'google-chrome.desktop',
  'virtualbox.desktop',
  'org.remmina.Remmina.desktop',
  'org.gnome.Screenshot.desktop',
  'gnome-calculator.desktop',
  'org.gnome.gedit.desktop',
  'code_code.desktop',
  'mysql-workbench.desktop',
  'postman_postman.desktop'
]"
dconf write /org/gnome/desktop/interface/clock-show-date "true"
dconf write /org/gnome/desktop/interface/clock-show-seconds "true"
dconf write /org/gnome/desktop/interface/show-battery-percentage "true"
dconf write /org/gnome/desktop/privacy/remember-app-usage "false"
dconf write /org/gnome/desktop/privacy/remember-recent-files "false"
dconf write /org/gnome/desktop/search-providers/disable-external "true"
dconf write /org/gnome/desktop/wm/preferences/num-workspaces "1"
dconf write /org/gnome/mutter/dynamic-workspaces "false"

gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Development/ name "Desenvolvimento"
dconf write /org/gnome/desktop/app-folders/folders/Development/apps "[
  'arduino-arduinoide.desktop',
  'code_code.desktop',
  'mysql-workbench.desktop',
  'postman_postman.desktop'
]"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Internet/ name "Internet"
dconf write /org/gnome/desktop/app-folders/folders/Internet/apps "[
  '4kvideodownloader.desktop',
  'dropbox.desktop',
  'firefox.desktop',
  'freerapiddownloader.desktop',
  'google-chrome.desktop',
  'slack_slack.desktop',
  'spotify_spotify.desktop',
  'transmission-gtk.desktop'
]"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/LibreOffice/ name "LibreOffice"
dconf write /org/gnome/desktop/app-folders/folders/LibreOffice/apps "[
  'libreoffice_base.desktop',
  'libreoffice_calc.desktop',
  'libreoffice_draw.desktop',
  'libreoffice_impress.desktop',
  'libreoffice_libreoffice.desktop',
  'libreoffice_math.desktop',
  'libreoffice_writer.desktop'
]"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Settings/ name "Configurações"
dconf write /org/gnome/desktop/app-folders/folders/Settings/apps "[
  'ca.desrt.dconf-editor.desktop',
  'gnome-control-center.desktop',
  'gnome-language-selector.desktop',
  'gnome-session-properties.desktop',
  'im-config.desktop',
  'nvidia-settings.desktop',
  'org.gnome.Extensions.desktop',
  'org.gnome.seahorse.Application.desktop',
  'org.gnome.tweaks.desktop',
  'qt5ct.desktop',
  'software-properties-gtk.desktop'
]"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ name "Utilitários"
dconf write /org/gnome/desktop/app-folders/folders/Utilities/apps "[
  'appimagekit-balena-etcher-electron.desktop',
  'cpu-x-root.desktop',
  'eog.desktop',
  'gnome-system-log.desktop',
  'gnome-system-monitor.desktop',
  'gparted.desktop',
  'ipscan.desktop',
  'org.gnome.Characters.desktop',
  'org.gnome.DiskUtility.desktop',
  'org.gnome.eog.desktop',
  'org.gnome.Evince.desktop',
  'org.gnome.FileRoller.desktop',
  'org.gnome.font-viewer.desktop',
  'org.gnome.Logs.desktop',
  'org.gnome.PowerStats.desktop',
  'scrcpy.desktop'
]"
dconf write /org/gnome/desktop/app-folders/folders/Utilities/translate "false"
dconf reset /org/gnome/desktop/app-folders/folders/Utilities/categories

dconf write /org/gnome/desktop/app-folders/folder-children "[
  'Development',
  'Internet',
  'LibreOffice',
  'Settings',
  'Utilities'
]"

desktopConf "$desktop_dir" "info.desktop" "NoDisplay" "true"
desktopConf "$desktop_dir" "software-properties-drivers.desktop" "NoDisplay" "true"
desktopConf "$desktop_dir" "software-properties-livepatch.desktop" "NoDisplay" "true"
desktopConf "$desktop_dir" "yelp.desktop" "NoDisplay" "true"

echo "spices have been configured"

printLine "GNOME Appearances"

icon_theme="Yaru"
cursor_theme="Yaru"
gtk_theme="Yaru-dark"
wallpaper_file="$wallpaper_dir/ubuntu-80s-glitch.jpg"
nautilus_columns="['name', 'size', 'detailed_type', 'group', 'permissions', 'date_modified']"

dconf write /org/gnome/shell/extensions/user-theme/name "'$gtk_theme'"
dconf write /org/gnome/desktop/interface/icon-theme "'$icon_theme'"
dconf write /org/gnome/desktop/interface/cursor-theme "'$cursor_theme'"
dconf write /org/gnome/desktop/interface/gtk-theme "'$gtk_theme'"
dconf write /org/gnome/desktop/wm/preferences/theme "'$gtk_theme'"
dconf write /org/gnome/desktop/wm/preferences/button-layout "':minimize,maximize,close'"
dconf write /org/gnome/desktop/background/picture-uri "'file://$wallpaper_file'"
dconf write /org/gnome/desktop/screensaver/picture-uri "'file://$wallpaper_file'"
dconf write /org/gnome/nautilus/window-state/sidebar-width "210"
dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
dconf write /org/gnome/nautilus/list-view/default-zoom-level "'standard'"
dconf write /org/gnome/nautilus/list-view/default-column-order "$nautilus_columns"
dconf write /org/gnome/nautilus/list-view/default-visible-columns "$nautilus_columns"
dconf write /org/gnome/nautilus/list-view/use-tree-view "true"
dconf write /org/gnome/nautilus/preferences/default-folder-viewer "'list-view'"
dconf write /org/gnome/gedit/preferences/editor/bracket-matching "false"
dconf write /org/gnome/gedit/preferences/editor/highlight-current-line "false"
dconf write /org/gnome/gedit/preferences/editor/search-highlighting "false"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/visible-name "'$USER'"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-theme-colors "false"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-theme-transparency "false"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/bold-is-bright "true"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/background-color "'#343434'"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/foreground-color "'#D3D7CF'"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/palette "[
  '#000000',
  '#CD0000',
  '#00CD00',
  '#CDCD00',
  '#0000EE',
  '#CD00CD',
  '#00CDCD',
  '#E5E5E5',
  '#7F7F7F',
  '#FF0000',
  '#00FF00',
  '#FFFF00',
  '#5C5CFF',
  '#FF00FF',
  '#00FFFF',
  '#FFFFFF'
]"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/highlight-colors-set "true"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/highlight-background-color "'#CE4819'"
dconf write /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/highlight-foreground-color "'#D3D7CF'"

desktopConf "$desktop_dir" "org.gnome.Nautilus.desktop" "Icon" "folder"

if [ ! -f "$wallpaper_file" ]
then
  wget -O "$wallpaper_file" "https://www.dropbox.com/s/xh6yruntbsml5mz/ubuntu-80s-glitch.jpg"
fi

IFS=$'\n'
hidden_bookmarks=("`xdg-user-dir DESKTOP`" "$HOME/GPUCache" "$HOME/portable" "$HOME/snap")
bookmarks_file="$HOME/.hidden"
cp /dev/null "$bookmarks_file"
i=1
while [ $i != ${#hidden_bookmarks[@]} ]
do
  bookmark=${hidden_bookmarks[$i]##*/}

  echo "$bookmark" >> "$bookmarks_file"

  let "i++"
done

bookmarks=(`ls -1 -d $HOME/*/ | sort`)
bookmarks_file="$HOME/.config/gtk-3.0/bookmarks"
cp /dev/null "$bookmarks_file"
i=0
while [ $i != ${#bookmarks[@]} ]
do
  bookmark=${bookmarks[$i]%/*}

  if ! [[ "${hidden_bookmarks[@]}" =~ "$bookmark" ]]
  then
    bookmark=${bookmark##*/}
    bookmark="file://$HOME/${bookmark// /%20} $bookmark"

    echo "$bookmark" >> "$bookmarks_file"
  fi

  let "i++"
done
unset $IFS

file="$qt5ct_dir/qt5ct.conf"
crudini --set "$file" "Appearance" "color_scheme_path" "/usr/share/qt5ct/colors/darker.conf"
crudini --set "$file" "Appearance" "custom_palette" "true"
crudini --set "$file" "Appearance" "icon_theme" "$icon_theme"
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

echo "appearances have been configured"

printLine "GNOME Actions"

dconf write /org/gnome/mutter/attach-modal-dialogs "false"
dconf write /org/gnome/settings-daemon/plugins/power/lid-close-battery-action "'nothing'"
dconf write /org/gnome/settings-daemon/plugins/power/lid-close-ac-action "'nothing'"
dconf write /org/gnome/nautilus/preferences/executable-text-activation "'ask'"
dconf write /org/gnome/terminal/legacy/menu-accelerator-enabled "false"

file="$autostart_dir/ignore-lid-switch-tweak.desktop"
if [ ! -f "$file" ]
then
  desk=$'[Desktop Entry]\n'
  desk+=$'Name=ignore-lid-switch-tweak\n'
  desk+=$'Exec=/usr/lib/gnome-tweak-tool/gnome-tweak-tool-lid-inhibitor\n'
  desk+=$'Type=Application\n'
  echo "$desk" > "$file"
fi

file="$script_dir/Comprimir"
if [ ! -f "$file" ]
then
  desk=$'#!/bin/bash\n'
  desk+=$'file-roller -d "$@"\n'
  echo "$desk" > "$file"
  chmod +x "$file"
fi
file="$script_dir/Extrair aqui"
if [ ! -f "$file" ]
then
  desk=$'#!/bin/bash\n'
  desk+=$'file-roller -h "$@"\n'
  echo "$desk" > "$file"
  chmod +x "$file"
fi

file="/usr/share/X11/xkb/symbols/br"
if [ -f "$file" ]
then
  sudo sed -i ':a;N;$!ba;s/ modifier_map Mod3   { Scroll_Lock };/ \/\/modifier_map Mod3   { Scroll_Lock };/g' "$file"
fi

file="/etc/profile.d/im-module-cedilla.sh"
if [ ! -f "$file" ]
then
  conf=$'#!/bin/bash\n'
  conf+=$'export GTK_IM_MODULE=cedilla\n'
  conf+=$'export QT_IM_MODULE=cedilla\n'
  echo "$conf" | sudo tee "$file"
  sudo chmod +x "$file"
fi

echo "actions have been configured"

printLine "Finished"
echo "Please reboot your system."
echo ""

if [ ! -z "`notify-send --version`" ]
then
  notify-send "LINUX DESKTOP SCRIPT (UBUNTU)" "Please reboot your system."
fi