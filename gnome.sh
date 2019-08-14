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
      'tweaks-system-menu@extensions.gnome-shell.fifi.org'
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
  'org.gnome.Calculator.desktop',
  'slack.desktop',
  'code_code.desktop',
  'postman_postman.desktop',
  'mysql-workbench.desktop'
]"
# dconf write /org/cinnamon/panels-enabled "[
#   '1:0:top',
#   '2:0:left'
# ]"
# dconf write /org/cinnamon/panels-height "[
#   '1:32',
#   '2:52'
# ]"
# dconf write /org/cinnamon/panel-zone-icon-sizes "'"'[{"panelId": 1, "left": 20, "center": 20, "right": 20}, {"panelId": 2, "left": 32, "center": 32, "right": 32}]'"'"
# dconf write /org/cinnamon/no-adjacent-panel-barriers "true"
# dconf write /org/cinnamon/theme/symbolic-relative-size "1.0"
# dconf write /org/cinnamon/desktop/interface/clock-show-date "true"
# dconf write /org/cinnamon/desktop/interface/clock-show-seconds "true"
# dconf write /org/cinnamon/desktop/screensaver/date-format "' %A   %d/%m/%Y'"
# dconf write /org/cinnamon/desktop/screensaver/time-format "'%H:%M:%S'"
# dconf write /org/cinnamon/desktop/screensaver/use-custom-format "true"
# dconf write /org/cinnamon/desktop/privacy/remember-recent-files "false"
# dconf write /org/gnome/desktop/privacy/remember-recent-files "false"

# for i in {1..10}
# do
#   file="`ls -1 $HOME/.cinnamon/configs/menu@cinnamon.org/*.json 2> /dev/null | tail -n1`"
#   if [ -f "$file" ]
#   then
#     json="`cat "$file"`"
#     json="`echo "$json" | jq '."menu-custom"."value"=true'`"
#     json="`echo "$json" | jq '."menu-icon"."value"="cinnamon-symbolic"'`"
#     json="`echo "$json" | jq '."menu-label"."value"=" Cinnamon Desktop"'`"
#     echo "$json" > "$file"
#     break
#   else
#     if [ $i == 1 ]
#     then
#       echo -n "Waiting for menu@cinnamon.org..."
#     else
#       echo -n "."
#     fi
#     sleep 1
#   fi
# done
# if [ $i != 1 ]
# then
#   echo ""
# fi

# for i in {1..10}
# do
#   file="`ls -1 $HOME/.cinnamon/configs/notifications@cinnamon.org/*.json 2> /dev/null | tail -n1`"
#   if [ -f "$file" ]
#   then
#     json="`cat "$file"`"
#     json="`echo "$json" | jq '."showEmptyTray"."value"=true'`"
#     echo "$json" > "$file"
#     break
#   else
#     if [ $i == 1 ]
#     then
#       echo -n "Waiting for notifications@cinnamon.org..."
#     else
#       echo -n "."
#     fi
#     sleep 1
#   fi
# done
# if [ $i != 1 ]
# then
#   echo ""
# fi

# for i in {1..10}
# do
#   file="`ls -1 $HOME/.cinnamon/configs/weather@mockturtl/*.json 2> /dev/null | tail -n1`"
#   if [ -f "$file" ]
#   then
#     json="`cat "$file"`"
#     json="`echo "$json" | jq '."manualLocation"."value"=true'`"
#     json="`echo "$json" | jq '."location"."value"="Mirandópolis,BR"'`"
#     json="`echo "$json" | jq '."show24Hours"."value"=true'`"
#     json="`echo "$json" | jq '."forecastDays"."value"=5'`"
#     json="`echo "$json" | jq '."useSymbolicIcons"."value"=true'`"
#     json="`echo "$json" | jq '."showCommentInPanel"."value"=false'`"
#     echo "$json" > "$file"
#     break
#   else
#     if [ $i == 1 ]
#     then
#       echo -n "Waiting for weather@mockturtl..."
#     else
#       echo -n "."
#     fi
#     sleep 1
#   fi
# done
# if [ $i != 1 ]
# then
#   echo ""
# fi

# for i in {1..10}
# do
#   file="`ls -1 $HOME/.cinnamon/configs/sound@cinnamon.org/*.json 2> /dev/null | tail -n1`"
#   if [ -f "$file" ]
#   then
#     json="`cat "$file"`"
#     json="`echo "$json" | jq '."extendedPlayerControl"."value"=true'`"
#     echo "$json" > "$file"
#     break
#   else
#     if [ $i == 1 ]
#     then
#       echo -n "Waiting for sound@cinnamon.org..."
#     else
#       echo -n "."
#     fi
#     sleep 1
#   fi
# done
# if [ $i != 1 ]
# then
#   echo ""
# fi

# for i in {1..10}
# do
#   file="`ls -1 $HOME/.cinnamon/configs/power@cinnamon.org/*.json 2> /dev/null | tail -n1`"
#   if [ -f "$file" ]
#   then
#     json="`cat "$file"`"
#     json="`echo "$json" | jq '."labelinfo"."value"="percentage"'`"
#     echo "$json" > "$file"
#     break
#   else
#     if [ $i == 1 ]
#     then
#       echo -n "Waiting for power@cinnamon.org..."
#     else
#       echo -n "."
#     fi
#     sleep 1
#   fi
# done
# if [ $i != 1 ]
# then
#   echo ""
# fi

# for i in {1..10}
# do
#   file="`ls -1 $HOME/.cinnamon/configs/calendar@cinnamon.org/*.json 2> /dev/null | tail -n1`"
#   if [ -f "$file" ]
#   then
#     json="`cat "$file"`"
#     json="`echo "$json" | jq '."use-custom-format"."value"=true'`"
#     json="`echo "$json" | jq '."custom-format"."value"="%d/%m/%Y %H:%M:%S"'`"
#     echo "$json" > "$file"
#     break
#   else
#     if [ $i == 1 ]
#     then
#       echo -n "Waiting for calendar@cinnamon.org..."
#     else
#       echo -n "."
#     fi
#     sleep 1
#   fi
# done
# if [ $i != 1 ]
# then
#   echo ""
# fi

# for i in {1..10}
# do
#   file="`ls -1 $HOME/.cinnamon/configs/show-desktop@cinnamon.org/*.json 2> /dev/null | tail -n1`"
#   if [ -f "$file" ]
#   then
#     json="`cat "$file"`"
#     json="`echo "$json" | jq '."peek-at-desktop"."value"=true'`"
#     echo "$json" > "$file"
#     break
#   else
#     if [ $i == 1 ]
#     then
#       echo -n "Waiting for show-desktop@cinnamon.org..."
#     else
#       echo -n "."
#     fi
#     sleep 1
#   fi
# done
# if [ $i != 1 ]
# then
#   echo ""
# fi

# for i in {1..10}
# do
#   file="`ls -1 $HOME/.cinnamon/configs/grouped-window-list@cinnamon.org/*.json 2> /dev/null | tail -n1`"
#   if [ -f "$file" ]
#   then
#     json="`cat "$file"`"
#     json="`echo "$json" | jq '."left-click-action"."value"=3'`"
#     json="`echo "$json" | jq '."middle-click-action"."value"=2'`"
#     json="`echo "$json" | jq '."pinned-apps"."value"=[
#       "org.gnome.Terminal.desktop",
#       "nemo.desktop",
#       "google-chrome.desktop",
#       "spotify_spotify.desktop",
#       "discord_discord.desktop",
#       "steam.desktop",
#       "virtualbox.desktop",
#       "org.remmina.Remmina.desktop",
#       "org.gnome.Screenshot.desktop",
#       "org.gnome.Calculator.desktop",
#       "slack.desktop",
#       "code_code.desktop",
#       "postman_postman.desktop",
#       "mysql-workbench.desktop"
#     ]'`"
#     json="`echo "$json" | jq '."show-all-workspaces"."value"=true'`"
#     json="`echo "$json" | jq '."enable-app-button-dragging"."value"=false'`"
#     json="`echo "$json" | jq '."launcher-animation-effect"."value"=3'`"
#     json="`echo "$json" | jq '."list-monitor-windows"."value"=false'`"
#     json="`echo "$json" | jq '."thumbnail-size"."value"=12'`"
#     json="`echo "$json" | jq '."animate-thumbnails"."value"=true'`"
#     json="`echo "$json" | jq '."vertical-thumbnails"."value"=true'`"
#     echo "$json" > "$file"
#     break
#   else
#     if [ $i == 1 ]
#     then
#       echo -n "Waiting for grouped-window-list@cinnamon.org..."
#     else
#       echo -n "."
#     fi
#     sleep 1
#   fi
# done
# if [ $i != 1 ]
# then
#   echo ""
# fi

# for i in {1..10}
# do
#   file="`ls -1 $HOME/.cinnamon/configs/transparent-panels@germanfr/*.json 2> /dev/null | tail -n1`"
#   if [ -f "$file" ]
#   then
#     json="`cat "$file"`"
#     json="`echo "$json" | jq '."transparency-type"."value"="panel-transparent"'`"
#     echo "$json" > "$file"
#     break
#   else
#     if [ $i == 1 ]
#     then
#       echo -n "Waiting for transparent-panels@germanfr..."
#     else
#       echo -n "."
#     fi
#     sleep 1
#   fi
# done
# if [ $i != 1 ]
# then
#   echo ""
# fi

# echo "spices have been configured"

# printLine "Cinnamon Themes"

# cinnamon_themes_dir="$HOME/.themes"
# cinnamon_theme_name="Mojave-2019-06-23-Dark"
# if [ ! -d "$cinnamon_themes_dir/$cinnamon_theme_name" ]
# then
#   mkdir -pv "$cinnamon_themes_dir"
#   file="$cinnamon_themes_dir/mojave-dark.tar.xz"
#   wget -O "$file" "https://github.com/daniloancilotto/mojave-gtk-theme/releases/download/2019-06-23/Mojave-dark.tar.xz"
#   tar -xf "$file" -C "$cinnamon_themes_dir"
#   mv -fv "$cinnamon_themes_dir/Mojave-dark" "$cinnamon_themes_dir/$cinnamon_theme_name"
#   rm -fv "$file"
# else
#   echo "$cinnamon_theme_name is already installed"
# fi
# cinnamon_theme_name_backup="Mint-Y-Dark"
# if [ ! -d "$cinnamon_themes_dir/$cinnamon_theme_name" ]
# then
#   cinnamon_theme_name="$cinnamon_theme_name_backup"
# fi

# IFS=$'\n'
# cinnamon_bookmarks_ignored=("`xdg-user-dir DESKTOP`" "$HOME/GPUCache" "$HOME/portable" "$HOME/snap")
# cinnamon_bookmarks=(`ls -1 -d $HOME/*/ | sort`)
# cinnamon_bookmarks_list="$HOME/.config/gtk-3.0/bookmarks"
# cinnamon_bookmarks_count=0
# cp /dev/null "$cinnamon_bookmarks_list"
# i=0
# while [ $i != ${#cinnamon_bookmarks[@]} ]
# do
#   cinnamon_bookmark=${cinnamon_bookmarks[$i]%/*}

#   if ! [[ "${cinnamon_bookmarks_ignored[@]}" =~ "$cinnamon_bookmark" ]]
#   then
#     cinnamon_bookmark=${cinnamon_bookmark##*/}
#     cinnamon_bookmark="file://$HOME/`urlEncode "$cinnamon_bookmark"` $cinnamon_bookmark"

#     echo "$cinnamon_bookmark" >> "$cinnamon_bookmarks_list"
#     let "cinnamon_bookmarks_count++"
#   fi

#   let "i++"
# done
# unset $IFS

# cinnamon_nemo_columns="['name', 'size', 'detailed_type', 'group', 'permissions', 'date_modified']"
# cinnamon_nemo_search_columns="['name', 'size', 'detailed_type', 'where']"
# cinnamon_nautilus_columns="['name', 'size', 'type', 'group', 'permissions', 'date_modified']"

# dconf write /org/cinnamon/theme/name "'$cinnamon_theme_name'"
# dconf write /org/cinnamon/desktop/interface/gtk-theme "'$cinnamon_theme_name'"
# dconf write /org/cinnamon/desktop/interface/gtk-theme-backup "'$cinnamon_theme_name_backup'"
# dconf write /org/cinnamon/desktop/wm/preferences/theme "'$cinnamon_theme_name'"
# dconf write /org/cinnamon/desktop/wm/preferences/theme-backup "'$cinnamon_theme_name_backup'"
# dconf write /org/cinnamon/desktop/wm/preferences/button-layout "'close,minimize,maximize:'"
# dconf write /org/nemo/window-state/sidebar-bookmark-breakpoint "$cinnamon_bookmarks_count"
# dconf write /org/nemo/window-state/sidebar-width "210"
# dconf write /org/nemo/icon-view/default-zoom-level "'small'"
# dconf write /org/nemo/list-view/default-zoom-level "'small'"
# dconf write /org/nemo/list-view/default-column-order "$cinnamon_nemo_columns"
# dconf write /org/nemo/list-view/default-visible-columns "$cinnamon_nemo_columns"
# dconf write /org/nemo/list-view/search-visible-columns "$cinnamon_nemo_search_columns"
# dconf write /org/nemo/preferences/date-format "'iso'"
# dconf write /org/nemo/preferences/default-folder-viewer "'list-view'"
# dconf write /org/nemo/preferences/show-advanced-permissions "true"
# dconf write /org/nemo/preferences/ignore-view-metadata "true"
# dconf write /org/gnome/nautilus/window-state/sidebar-width "210"
# dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
# dconf write /org/gnome/nautilus/list-view/default-zoom-level "'small'"
# dconf write /org/gnome/nautilus/list-view/default-column-order "$cinnamon_nautilus_columns"
# dconf write /org/gnome/nautilus/list-view/default-visible-columns "$cinnamon_nautilus_columns"
# dconf write /org/gnome/nautilus/list-view/use-tree-view "true"
# dconf write /org/gnome/nautilus/preferences/default-folder-viewer "'list-view'"

# cinnamon_icons_dir="$HOME/.icons"
# cinnamon_icon_name="Korla-1.1.6-Dark"
# if [ ! -d "$cinnamon_icons_dir/$cinnamon_icon_name" ]
# then
#   mkdir -pv "$cinnamon_icons_dir"
#   file="$cinnamon_icons_dir/korla-dark.zip"
#   wget -O "$file" "https://github.com/bikass/korla/archive/v1.1.6.zip"
#   unzip -q "$file" -d "$cinnamon_icons_dir"
#   mv -fv "$cinnamon_icons_dir/korla-1.1.6/korla" "$cinnamon_icons_dir/$cinnamon_icon_name"
#   rm -rf "$cinnamon_icons_dir/korla-1.1.6"
#   rm -fv "$file"
# else
#   echo "$cinnamon_icon_name is already installed"
# fi
# cinnamon_icon_name_backup="Mint-Y"
# if [ ! -d "$cinnamon_icons_dir/$cinnamon_icon_name" ]
# then
#   cinnamon_icon_name="$cinnamon_icon_name_backup"
# fi

# dconf write /org/cinnamon/desktop/interface/icon-theme "'$cinnamon_icon_name'"
# dconf write /org/cinnamon/desktop/interface/icon-theme-backup "'$cinnamon_icon_name_backup'"
# dconf write /org/cinnamon/settings-daemon/plugins/xsettings/buttons-have-icons "true"
# dconf write /org/nemo/desktop/computer-icon-visible "false"
# dconf write /org/nemo/desktop/network-icon-visible "true"
# dconf write /org/nemo/desktop/trash-icon-visible "true"
# dconf write /org/nemo/preferences/show-home-icon-toolbar "true"
# dconf write /org/nemo/preferences/show-reload-icon-toolbar "true"
# dconf write /org/nemo/preferences/show-open-in-terminal-toolbar "true"

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