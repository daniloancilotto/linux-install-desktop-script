#!/bin/bash
system="`lsb_release -sd`"

echo "DESKTOP ENVIRONMENT SCRIPT - GNOME"
echo "Author: Danilo Ancilotto"
echo "System: $system"
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

printLine "GNOME Spices"

gnome_spices_dir="$HOME/.local/share/gnome-shell"
gnome_spices=( \
  "extensions" \
)
i=0
while [ $i != ${#gnome_spices[@]} ]
do
  gnome_spice="${gnome_spices[$i]}"

  gnome_spice_items_dir="$gnome_spices_dir/$gnome_spice"
  gnome_spice_items=()
  gnome_spice_items_names=()
  if [ "$gnome_spice" == "extensions" ]
  then
    gnome_spice_items=( \
      "https://extensions.gnome.org/extension-data/unitehardpixel.eu.v31.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/clock-overridegnomeshell.kryogenix.org.v12.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/openweather-extension%40jenslody.de.v97.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/VitalsCoreCoding.com.v20.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/gnome-shell-trash-extension.v16.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/drive-menugnome-shell-extensions.gcampax.github.com.v40.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/printerslinux-man.org.v9.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/lockkeysvaina.lt.v28.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/ds4battery%40slie.ru.v4.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/sound-output-device-chooserkgshank.net.v22.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/tweaks-system-menuextensions.gnome-shell.fifi.org.v3.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/desktop-iconscsoriano.v14.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/user-themegnome-shell-extensions.gcampax.github.com.v37.shell-extension.zip" \
    )
    gnome_spice_items_names=( \
      "unite@hardpixel.eu" \
      "clock-override@gnomeshell.kryogenix.org" \
      "openweather-extension@jenslody.de" \
      "Vitals@CoreCoding.com" \
      "gnome-shell-trash-extension" \
      "drive-menu@gnome-shell-extensions.gcampax.github.com" \
      "printers@linux-man.org" \
      "lockkeys@vaina.lt" \
      "ds4battery@slie.ru" \
      "sound-output-device-chooser@kgshank.net" \
      "tweaks-system-menu@extensions.gnome-shell.fifi.org" \
      "desktop-icons@csoriano" \
      "user-theme@gnome-shell-extensions.gcampax.github.com" \
    )
  fi
  j=0
  while [ $j != ${#gnome_spice_items[@]} ]
  do
    gnome_spice_item="${gnome_spice_items[$j]}"

    gnome_spice_item_file="${gnome_spice_item##*/}"
    gnome_spice_item_name="${gnome_spice_items_names[$j]}"
    if [ ! -d "$gnome_spice_items_dir/$gnome_spice_item_name" ]
    then
      mkdir -pv "$gnome_spice_items_dir"
      file="$gnome_spice_items_dir/$gnome_spice_item_file"
      wget -O "$file" "${gnome_spice_item}"
      unzip -q "$file" -d "$gnome_spice_items_dir/$gnome_spice_item_name"
      rm -fv "$file"
    else
      echo "$gnome_spice_item_name is already installed"
    fi

    let "j++"
  done

  gnome_spice_dconf="'[]'"
  if [ "$gnome_spice" == "extensions" ]
  then
    gnome_spice_dconf="[
      'unite@hardpixel.eu',
      'clock-override@gnomeshell.kryogenix.org',
      'openweather-extension@jenslody.de',
      'Vitals@CoreCoding.com',
      'gnome-shell-trash-extension',
      'drive-menu@gnome-shell-extensions.gcampax.github.com',
      'printers@linux-man.org',
      'lockkeys@vaina.lt',
      'ds4battery@slie.ru',
      'sound-output-device-chooser@kgshank.net',
      'tweaks-system-menu@extensions.gnome-shell.fifi.org',
      'desktop-icons@csoriano',
      'user-theme@gnome-shell-extensions.gcampax.github.com'
    ]"
  fi
  dconf write /org/gnome/shell/enabled-$gnome_spice "$gnome_spice_dconf"

  let "i++"
done

dconf write /org/gnome/shell/extensions/unite/extend-left-box "false"
dconf write /org/gnome/shell/extensions/unite/use-system-fonts "false"
dconf write /org/gnome/shell/extensions/unite/notifications-position "'center'"
dconf write /org/gnome/shell/extensions/unite/show-window-buttons "'always'"
dconf write /org/gnome/shell/extensions/unite/show-window-title "'always'"
dconf write /org/gnome/shell/extensions/unite/window-buttons-theme "'yaru'"
dconf write /org/gnome/shell/extensions/clock_override/override-string "'%d/%m/%Y  %H:%M:%S'"
dconf write /org/gnome/shell/extensions/vitals/alphabetize "false"
dconf write /org/gnome/shell/extensions/vitals/position-in-panel "1"
dconf write /org/gnome/shell/extensions/vitals/hot-sensors "[
  '_processor_average_',
  '__temperature_avg__',
  '_memory_usage_',
  '__max_network-download__',
  '__max_network-upload__',
  '_battery_rate_'
]"
dconf write /org/gnome/shell/extensions/openweather/city "'-21.1328313,-51.1029422>Mirandópolis, BR>-1'"
dconf write /org/gnome/shell/extensions/openweather/days-forecast "10"
dconf write /org/gnome/shell/extensions/openweather/decimal-places "0"
dconf write /org/gnome/shell/extensions/openweather/pressure-unit "'hPa'"
dconf write /org/gnome/shell/extensions/openweather/unit "'celsius'"
dconf write /org/gnome/shell/extensions/openweather/wind-speed-unit "'kph'"
dconf write /org/gnome/shell/extensions/printers/show-icon "'When printers exist'"
dconf write /org/gnome/shell/extensions/dash-to-dock/show-apps-at-top "true"
dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size "32"
dconf write /org/gnome/shell/extensions/dash-to-dock/animate-show-apps "false"
dconf write /org/gnome/shell/extensions/dash-to-dock/show-delay "0.0"
dconf write /org/gnome/shell/extensions/dash-to-dock/hide-delay "0.0"
dconf write /org/gnome/shell/extensions/desktop-icons/icon-size "'small'"
dconf write /org/gnome/shell/extensions/desktop-icons/show-home "false"
dconf write /org/gnome/shell/extensions/desktop-icons/show-trash "false"
dconf write /org/gnome/shell/favorite-apps "[
  'update-manager.desktop',
  'org.gnome.Terminal.desktop',
  'org.gnome.Nautilus.desktop',
  'google-chrome.desktop',
  'spotify_spotify.desktop',
  'steam.desktop',
  'virtualbox.desktop',
  'org.remmina.Remmina.desktop',
  'org.gnome.Screenshot.desktop',
  'gnome-calculator_gnome-calculator.desktop',
  'slack.desktop',
  'code_code.desktop',
  'postman_postman.desktop',
  'mysql-workbench.desktop'
]"
dconf write /org/gnome/desktop/interface/clock-show-date "true"
dconf write /org/gnome/desktop/interface/clock-show-seconds "true"
dconf write /org/gnome/desktop/interface/show-battery-percentage "true"
dconf write /org/gnome/desktop/privacy/remember-app-usage "false"
dconf write /org/gnome/desktop/privacy/remember-recent-files "false"

echo "spices have been configured"

printLine "GNOME Appearances"

IFS=$'\n'
gnome_bookmarks_ignored=("`xdg-user-dir DESKTOP`" "$HOME/GPUCache" "$HOME/portable" "$HOME/snap")
gnome_bookmarks=(`ls -1 -d $HOME/*/ | sort`)
gnome_bookmarks_list="$HOME/.config/gtk-3.0/bookmarks"
cp /dev/null "$gnome_bookmarks_list"
i=0
while [ $i != ${#gnome_bookmarks[@]} ]
do
  gnome_bookmark=${gnome_bookmarks[$i]%/*}

  if ! [[ "${gnome_bookmarks_ignored[@]}" =~ "$gnome_bookmark" ]]
  then
    gnome_bookmark=${gnome_bookmark##*/}
    gnome_bookmark="file://$HOME/$gnome_bookmark $gnome_bookmark"

    echo "$gnome_bookmark" >> "$gnome_bookmarks_list"
  fi

  let "i++"
done
unset $IFS

gnome_icon_name="Yaru"
gnome_cursor_name="Yaru"
gnome_theme_name="Yaru-dark"
gnome_nautilus_columns="['name', 'size', 'detailed_type', 'group', 'permissions', 'date_modified']"

dconf write /org/gnome/desktop/interface/icon-theme "'$gnome_icon_name'"
dconf write /org/gnome/desktop/interface/cursor-theme "'$gnome_cursor_name'"
dconf write /org/gnome/desktop/interface/gtk-theme "'$gnome_theme_name'"
dconf write /org/gnome/desktop/wm/preferences/theme "'$gnome_theme_name'"
dconf write /org/gnome/desktop/wm/preferences/button-layout "'close,minimize,maximize:'"
dconf write /org/gnome/nautilus/window-state/sidebar-width "210"
dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
dconf write /org/gnome/nautilus/list-view/default-zoom-level "'standard'"
dconf write /org/gnome/nautilus/list-view/default-column-order "$gnome_nautilus_columns"
dconf write /org/gnome/nautilus/list-view/default-visible-columns "$gnome_nautilus_columns"
dconf write /org/gnome/nautilus/list-view/use-tree-view "true"
dconf write /org/gnome/nautilus/preferences/default-folder-viewer "'list-view'"

echo "appearances have been configured"

printLine "GNOME Actions"

dconf write /org/gnome/mutter/attach-modal-dialogs "false"
dconf write /org/gnome/settings-daemon/plugins/power/lid-close-battery-action "'nothing'"
dconf write /org/gnome/settings-daemon/plugins/power/lid-close-ac-action "'nothing'"
dconf write /org/gnome/nautilus/compression/default-compression-format "'7z'"
dconf write /org/gnome/nautilus/preferences/executable-text-activation "'ask'"
dconf write /org/gnome/terminal/legacy/menu-accelerator-enabled "false"

echo "actions have been configured"

printLine "Finished"
echo "Done, please reboot your system."
echo ""