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

urlEncode() {
  local length="${#1}"
  for (( i = 0; i < length; i++ ))
  do
    local c="${1:i:1}"
    case $c in
      [a-zA-Z0-9.~_-]) printf "$c" ;;
      *) printf '%%%02X' "'$c"
    esac
  done
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
dconf write /org/gnome/shell/extensions/unite/show-window-title "'always'"
dconf write /org/gnome/shell/extensions/unite/window-buttons-theme "'yaru'"
dconf write /org/gnome/shell/extensions/clock_override/override-string "'%d/%m/%Y  %H:%M:%S'"
dconf write /org/gnome/shell/extensions/vitals/alphabetize "false"
dconf write /org/gnome/shell/extensions/vitals/position-in-panel "1"
dconf write /org/gnome/shell/extensions/vitals/hot-sensors "[
  '_processor_average_',
  '_memory_usage_',
  '__max_network-download__',
  '__max_network-upload__'
]"
dconf write /org/gnome/shell/extensions/openweather/city "'-21.1328313,-51.1029422>Mirandópolis, BR>-1'"
dconf write /org/gnome/shell/extensions/openweather/days-forecast "10"
dconf write /org/gnome/shell/extensions/openweather/decimal-places "0"
dconf write /org/gnome/shell/extensions/openweather/pressure-unit "'hPa'"
dconf write /org/gnome/shell/extensions/openweather/unit "'celsius'"
dconf write /org/gnome/shell/extensions/openweather/wind-speed-unit "'kph'"
dconf write /org/gnome/shell/extensions/printers/show-icon "'When printers exist'"
dconf write /org/gnome/shell/favorite-apps "[
  'org.gnome.Terminal.desktop',
  'org.gnome.Nautilus.desktop',
  'google-chrome.desktop',
  'spotify_spotify.desktop',
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

printLine "GNOME Themes"

IFS=$'\n'
gnome_bookmarks_ignored=("`xdg-user-dir DESKTOP`" "$HOME/GPUCache" "$HOME/portable" "$HOME/snap")
gnome_bookmarks=(`ls -1 -d $HOME/*/ | sort`)
gnome_bookmarks_list="$HOME/.config/gtk-3.0/bookmarks"
gnome_bookmarks_count=0
cp /dev/null "$gnome_bookmarks_list"
i=0
while [ $i != ${#gnome_bookmarks[@]} ]
do
  gnome_bookmark=${gnome_bookmarks[$i]%/*}

  if ! [[ "${gnome_bookmarks_ignored[@]}" =~ "$gnome_bookmark" ]]
  then
    gnome_bookmark=${gnome_bookmark##*/}
    gnome_bookmark="file://$HOME/`urlEncode "$gnome_bookmark"` $gnome_bookmark"

    echo "$gnome_bookmark" >> "$gnome_bookmarks_list"
    let "gnome_bookmarks_count++"
  fi

  let "i++"
done
unset $IFS

gnome_icon_name="Yaru"
gnome_theme_name="Yaru-dark"
gnome_nautilus_columns="['name', 'size', 'detailed_type', 'group', 'permissions', 'date_modified']"

dconf write /org/gnome/desktop/interface/icon-theme "'$gnome_icon_name'"
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


# cinnamon_cursors_dir="$HOME/.icons"
# cinnamon_cursor_name="Capitaine-Cursors-R3-Light"
# if [ ! -d "$cinnamon_cursors_dir/$cinnamon_cursor_name" ]
# then
#   mkdir -pv "$cinnamon_cursors_dir"
#   file="$cinnamon_cursors_dir/capitaine-cursors-light.tar.xz"
#   wget -O "$file" "https://github.com/keeferrourke/capitaine-cursors/releases/download/r3/capitaine-cursors-light.tar.xz"
#   tar -xf "$file" -C "$cinnamon_cursors_dir"
#   mv -fv "$cinnamon_cursors_dir/dist-white" "$cinnamon_cursors_dir/$cinnamon_cursor_name"
#   rm -fv "$file"
# else
#   echo "$cinnamon_cursor_name is already installed"
# fi
# cinnamon_cursor_name_backup="DMZ-White"
# if [ ! -d "$cinnamon_cursors_dir/$cinnamon_cursor_name" ]
# then
#   cinnamon_cursor_name="$cinnamon_cursor_name_backup"
# fi

# dconf write /org/cinnamon/desktop/interface/cursor-theme "'$cinnamon_cursor_name'"

# cinnamon_backgrounds_dir="$HOME/.cinnamon/backgrounds"
# cinnamon_backgrounds=( \
#   "Light" \
#   "Dark" \
# )
# cinnamon_backgrounds_list="$cinnamon_backgrounds_dir/user-folders.lst"
# mkdir -pv "$cinnamon_backgrounds_dir"
# cp /dev/null "$cinnamon_backgrounds_list"
# i=0
# while [ $i != ${#cinnamon_backgrounds[@]} ]
# do
#   cinnamon_background="${cinnamon_backgrounds[$i]}"

#   cinnamon_background_items_dir="$cinnamon_backgrounds_dir/$cinnamon_background"
#   cinnamon_background_items=()
#   if [ "$cinnamon_background" == "Dark" ]
#   then
#     cinnamon_background_items=( \
#       "https://w.wallhaven.cc/full/ym/wallhaven-ymxx57.jpg" \
#       "https://w.wallhaven.cc/full/4y/wallhaven-4y83px.jpg" \
#     )
#   fi
#   mkdir -pv "$cinnamon_background_items_dir"
#   echo "$cinnamon_background_items_dir" >> "$cinnamon_backgrounds_list"
#   j=0
#   while [ $j != ${#cinnamon_background_items[@]} ]
#   do
#     cinnamon_background_item="${cinnamon_background_items[$j]}"

#     cinnamon_background_item_file="${cinnamon_background_item##*/}"
#     if [ ! -f "$cinnamon_background_items_dir/$cinnamon_background_item_file" ]
#     then
#       wget -O "$cinnamon_background_items_dir/$cinnamon_background_item_file" "$cinnamon_background_item"
#     else
#       echo "$cinnamon_background_item_file is already installed"
#     fi

#     let "j++"
#   done

#   let "i++"
# done

# dconf write /org/cinnamon/desktop/background/picture-uri "'file://$cinnamon_background_items_dir/$cinnamon_background_item_file'"
# dconf write /org/cinnamon/desktop/background/slideshow/image-source "'directory://$cinnamon_background_items_dir'"
# dconf write /org/cinnamon/desktop/background/slideshow/delay "10"
# dconf write /org/cinnamon/desktop/background/slideshow/random-order "true"
# dconf write /org/cinnamon/desktop/background/slideshow/slideshow-enabled "true"

# conf=$'[Greeter]\n'
# conf+=$'show-hostname=true\n'
# conf+=$'draw-grid=false\n'
# conf+=$'theme-name=Mint-Y-Dark-Blue\n'
# conf+=$'icon-theme-name=Mint-Y-Blue\n'
# echo "$conf" | sudo tee "/etc/lightdm/slick-greeter.conf"

# conf=$'[desktop-monitor-0]\n'
# conf+=$'desktop-horizontal=true\n'
# conf+=$'desktop-grid-adjust=107;75;\n'
# echo "$conf" > "$HOME/.config/nemo/desktop-metadata"

# echo "themes have been configured"

# printLine "Cinnamon Actions"

# dconf write /org/cinnamon/alttab-switcher-enforce-primary-monitor "true"
# dconf write /org/cinnamon/alttab-switcher-show-all-workspaces "true"
# dconf write /org/cinnamon/bring-windows-to-current-workspace "true"
# dconf write /org/cinnamon/desktop/wm/preferences/mouse-button-modifier "'<Super>'"
# dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action "'nothing'"
# dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action "'nothing'"
# dconf write /org/gnome/nautilus/compression/default-compression-format "'7z'"
# dconf write /org/gnome/nautilus/preferences/executable-text-activation "'ask'"
# dconf write /org/gnome/terminal/legacy/menu-accelerator-enabled "false"

# echo "actions have been configured"

# printLine "Finished"
# echo "Done, please reboot your system."
# echo ""