#!/bin/bash
system="`lsb_release -sd`"

echo "DESKTOP ENVIRONMENT SCRIPT - CINNAMON"
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
      *) printf '%%%02X' "'$c" ;;
    esac
  done
}

printLine "Cinnamon Spices"

dconf write /org/cinnamon/next-applet-id "0"
dconf write /org/cinnamon/next-desklet-id "0"

cinnamon_spices_dir="$HOME/.local/share/cinnamon"
cinnamon_spices=( \
  "applets" \
  "desklets" \
  "extensions" \
)
i=0
while [ $i != ${#cinnamon_spices[@]} ]
do
  cinnamon_spice="${cinnamon_spices[$i]}"

  cinnamon_spice_items_dir="$cinnamon_spices_dir/$cinnamon_spice"
  cinnamon_spice_items=()
  if [ "$cinnamon_spice" == "applets" ]
  then
    cinnamon_spice_items=( \
      "https://cinnamon-spices.linuxmint.com/files/applets/betterlock.zip" \
      "https://cinnamon-spices.linuxmint.com/files/applets/cpu-monitor-text@gnemonix.zip" \
      "https://cinnamon-spices.linuxmint.com/files/applets/mem-monitor-text@datanom.net.zip" \
      "https://cinnamon-spices.linuxmint.com/files/applets/weather@mockturtl.zip" \
    )
  elif [ "$cinnamon_spice" == "extensions" ]
  then
    cinnamon_spice_items=( \
      "https://cinnamon-spices.linuxmint.com/files/extensions/transparent-panels@germanfr.zip" \
    )
  fi
  j=0
  while [ $j != ${#cinnamon_spice_items[@]} ]
  do
    cinnamon_spice_item="${cinnamon_spice_items[$j]}"

    cinnamon_spice_item_file="${cinnamon_spice_item##*/}"
    cinnamon_spice_item_name="${cinnamon_spice_item_file%.*}"
    if [ ! -d "$cinnamon_spice_items_dir/$cinnamon_spice_item_name" ]
    then
      mkdir -pv "$cinnamon_spice_items_dir"
      file="$cinnamon_spice_items_dir/$cinnamon_spice_item_file"
      wget -O "$file" "$cinnamon_spice_item"
      unzip -q "$file" -d "$cinnamon_spice_items_dir"
      rm -fv "$file"
    else
      echo "$cinnamon_spice_item_name is already installed"
    fi

    let "j++"
  done

  cinnamon_spice_dconf="'[]'"
  if [ "$cinnamon_spice" == "applets" ]
  then
    cinnamon_spice_dconf="[
      'panel1:left:0:menu@cinnamon.org',
      'panel1:center:0:calendar@cinnamon.org',
      'panel1:center:1:spacer@cinnamon.org',
      'panel1:center:2:weather@mockturtl',
      'panel1:center:3:spacer@cinnamon.org',
      'panel1:center:4:cpu-monitor-text@gnemonix',
      'panel1:center:5:mem-monitor-text@datanom.net',
      'panel1:right:0:notifications@cinnamon.org',
      'panel1:right:1:printers@cinnamon.org',
      'panel1:right:2:systray@cinnamon.org',
      'panel1:right:3:keyboard@cinnamon.org',
      'panel1:right:4:betterlock',
      'panel1:right:5:xrandr@cinnamon.org',
      'panel1:right:6:blueberry@cinnamon.org',
      'panel1:right:7:network@cinnamon.org',
      'panel1:right:8:sound@cinnamon.org',
      'panel1:right:9:power@cinnamon.org',
      'panel1:right:10:user@cinnamon.org',
      'panel2:left:0:grouped-window-list@cinnamon.org'
    ]"
  elif [ "$cinnamon_spice" == "extensions" ]
  then
    cinnamon_spice_dconf="[
      'transparent-panels@germanfr'
    ]"
  fi
  dconf write /org/cinnamon/enabled-$cinnamon_spice "$cinnamon_spice_dconf"

  let "i++"
done

dconf write /org/cinnamon/favorite-apps "[
  'cinnamon-settings.desktop',
  'mintinstall.desktop',
  'cinnamon-settings-info.desktop'
]"
dconf write /org/cinnamon/panels-enabled "[
  '1:0:top',
  '2:0:left'
]"
dconf write /org/cinnamon/panels-height "[
  '1:32',
  '2:52'
]"
dconf write /org/cinnamon/panel-zone-icon-sizes "'"'[{"panelId": 1, "left": 20, "center": 20, "right": 20}, {"panelId": 2, "left": 32, "center": 32, "right": 32}]'"'"
dconf write /org/cinnamon/no-adjacent-panel-barriers "true"
dconf write /org/cinnamon/theme/symbolic-relative-size "1.0"
dconf write /org/cinnamon/desktop/interface/clock-show-date "true"
dconf write /org/cinnamon/desktop/interface/clock-show-seconds "true"
dconf write /org/cinnamon/desktop/screensaver/date-format "' %A   %d/%m/%Y'"
dconf write /org/cinnamon/desktop/screensaver/time-format "'%H:%M:%S'"
dconf write /org/cinnamon/desktop/screensaver/use-custom-format "true"
dconf write /org/cinnamon/desktop/privacy/remember-recent-files "false"
dconf write /org/gnome/desktop/privacy/remember-recent-files "false"

for i in {1..10}
do
  file="`ls -1 $HOME/.cinnamon/configs/menu@cinnamon.org/*.json 2> /dev/null | tail -n1`"
  if [ -f "$file" ]
  then
    json="`cat "$file"`"
    json="`echo "$json" | jq '."menu-custom"."value"=true'`"
    json="`echo "$json" | jq '."menu-icon"."value"="cinnamon-symbolic"'`"
    json="`echo "$json" | jq '."menu-label"."value"=" Cinnamon Desktop"'`"
    echo "$json" > "$file"
    break
  else
    if [ $i == 1 ]
    then
      echo -n "Waiting for menu@cinnamon.org..."
    else
      echo -n "."
    fi
    sleep 1
  fi
done
if [ $i != 1 ]
then
  echo ""
fi

for i in {1..10}
do
  file="`ls -1 $HOME/.cinnamon/configs/calendar@cinnamon.org/*.json 2> /dev/null | tail -n1`"
  if [ -f "$file" ]
  then
    json="`cat "$file"`"
    json="`echo "$json" | jq '."use-custom-format"."value"=true'`"
    json="`echo "$json" | jq '."custom-format"."value"="%d/%m/%Y  %H:%M:%S"'`"
    echo "$json" > "$file"
    break
  else
    if [ $i == 1 ]
    then
      echo -n "Waiting for calendar@cinnamon.org..."
    else
      echo -n "."
    fi
    sleep 1
  fi
done
if [ $i != 1 ]
then
  echo ""
fi

for i in {1..10}
do
  file="`ls -1 $HOME/.cinnamon/configs/weather@mockturtl/*.json 2> /dev/null | tail -n1`"
  if [ -f "$file" ]
  then
    json="`cat "$file"`"
    json="`echo "$json" | jq '."manualLocation"."value"=true'`"
    json="`echo "$json" | jq '."location"."value"="Mirandópolis,BR"'`"
    json="`echo "$json" | jq '."show24Hours"."value"=true'`"
    json="`echo "$json" | jq '."forecastDays"."value"=5'`"
    json="`echo "$json" | jq '."useSymbolicIcons"."value"=true'`"
    json="`echo "$json" | jq '."showCommentInPanel"."value"=false'`"
    echo "$json" > "$file"
    break
  else
    if [ $i == 1 ]
    then
      echo -n "Waiting for weather@mockturtl..."
    else
      echo -n "."
    fi
    sleep 1
  fi
done
if [ $i != 1 ]
then
  echo ""
fi

for i in {1..10}
do
  file="`ls -1 $HOME/.cinnamon/configs/notifications@cinnamon.org/*.json 2> /dev/null | tail -n1`"
  if [ -f "$file" ]
  then
    json="`cat "$file"`"
    json="`echo "$json" | jq '."showEmptyTray"."value"=true'`"
    echo "$json" > "$file"
    break
  else
    if [ $i == 1 ]
    then
      echo -n "Waiting for notifications@cinnamon.org..."
    else
      echo -n "."
    fi
    sleep 1
  fi
done
if [ $i != 1 ]
then
  echo ""
fi

for i in {1..10}
do
  file="`ls -1 $HOME/.cinnamon/configs/sound@cinnamon.org/*.json 2> /dev/null | tail -n1`"
  if [ -f "$file" ]
  then
    json="`cat "$file"`"
    json="`echo "$json" | jq '."extendedPlayerControl"."value"=true'`"
    echo "$json" > "$file"
    break
  else
    if [ $i == 1 ]
    then
      echo -n "Waiting for sound@cinnamon.org..."
    else
      echo -n "."
    fi
    sleep 1
  fi
done
if [ $i != 1 ]
then
  echo ""
fi

for i in {1..10}
do
  file="`ls -1 $HOME/.cinnamon/configs/power@cinnamon.org/*.json 2> /dev/null | tail -n1`"
  if [ -f "$file" ]
  then
    json="`cat "$file"`"
    json="`echo "$json" | jq '."labelinfo"."value"="percentage"'`"
    echo "$json" > "$file"
    break
  else
    if [ $i == 1 ]
    then
      echo -n "Waiting for power@cinnamon.org..."
    else
      echo -n "."
    fi
    sleep 1
  fi
done
if [ $i != 1 ]
then
  echo ""
fi

for i in {1..10}
do
  file="`ls -1 $HOME/.cinnamon/configs/grouped-window-list@cinnamon.org/*.json 2> /dev/null | tail -n1`"
  if [ -f "$file" ]
  then
    json="`cat "$file"`"
    json="`echo "$json" | jq '."left-click-action"."value"=3'`"
    json="`echo "$json" | jq '."middle-click-action"."value"=2'`"
    json="`echo "$json" | jq '."pinned-apps"."value"=[
      "org.gnome.Terminal.desktop",
      "nemo.desktop",
      "google-chrome.desktop",
      "spotify_spotify.desktop",
      "steam.desktop",
      "virtualbox.desktop",
      "org.remmina.Remmina.desktop",
      "org.gnome.Screenshot.desktop",
      "org.gnome.Calculator.desktop",
      "org.gnome.gedit.desktop",
      "code_code.desktop",
      "postman_postman.desktop",
      "mysql-workbench.desktop"
    ]'`"
    json="`echo "$json" | jq '."show-all-workspaces"."value"=true'`"
    json="`echo "$json" | jq '."enable-app-button-dragging"."value"=false'`"
    json="`echo "$json" | jq '."launcher-animation-effect"."value"=3'`"
    json="`echo "$json" | jq '."list-monitor-windows"."value"=false'`"
    json="`echo "$json" | jq '."thumbnail-size"."value"=12'`"
    json="`echo "$json" | jq '."animate-thumbnails"."value"=true'`"
    json="`echo "$json" | jq '."vertical-thumbnails"."value"=true'`"
    echo "$json" > "$file"
    break
  else
    if [ $i == 1 ]
    then
      echo -n "Waiting for grouped-window-list@cinnamon.org..."
    else
      echo -n "."
    fi
    sleep 1
  fi
done
if [ $i != 1 ]
then
  echo ""
fi

for i in {1..10}
do
  file="`ls -1 $HOME/.cinnamon/configs/transparent-panels@germanfr/*.json 2> /dev/null | tail -n1`"
  if [ -f "$file" ]
  then
    json="`cat "$file"`"
    json="`echo "$json" | jq '."transparency-type"."value"="panel-transparent"'`"
    echo "$json" > "$file"
    break
  else
    if [ $i == 1 ]
    then
      echo -n "Waiting for transparent-panels@germanfr..."
    else
      echo -n "."
    fi
    sleep 1
  fi
done
if [ $i != 1 ]
then
  echo ""
fi

echo "spices have been configured"

printLine "Cinnamon Appearances"

IFS=$'\n'
cinnamon_bookmarks_ignored=("`xdg-user-dir DESKTOP`" "$HOME/GPUCache" "$HOME/portable" "$HOME/snap")
cinnamon_bookmarks=(`ls -1 -d $HOME/*/ | sort`)
cinnamon_bookmarks_list="$HOME/.config/gtk-3.0/bookmarks"
cinnamon_bookmarks_count=0
cp /dev/null "$cinnamon_bookmarks_list"
i=0
while [ $i != ${#cinnamon_bookmarks[@]} ]
do
  cinnamon_bookmark=${cinnamon_bookmarks[$i]%/*}

  if ! [[ "${cinnamon_bookmarks_ignored[@]}" =~ "$cinnamon_bookmark" ]]
  then
    cinnamon_bookmark=${cinnamon_bookmark##*/}
    cinnamon_bookmark="file://$HOME/`urlEncode "$cinnamon_bookmark"` $cinnamon_bookmark"

    echo "$cinnamon_bookmark" >> "$cinnamon_bookmarks_list"
    let "cinnamon_bookmarks_count++"
  fi

  let "i++"
done
unset $IFS

dconf write /org/nemo/window-state/sidebar-bookmark-breakpoint "$cinnamon_bookmarks_count"

cinnamon_icon_name="Mint-Y-Dark"
cinnamon_icon_name_backup="Mint-Y-Dark"
cinnamon_cursor_name="DMZ-Black"
cinnamon_theme_name="Mint-Y-Dark"
cinnamon_theme_name_backup="Mint-Y-Dark"
cinnamon_theme_name_window="Mint-Y-Dark"
cinnamon_theme_name_window_backup="Mint-Y-Dark"
cinnamon_nemo_columns="['name', 'size', 'detailed_type', 'group', 'permissions', 'date_modified']"
cinnamon_nemo_search_columns="['name', 'size', 'detailed_type', 'where']"
cinnamon_nautilus_columns="['name', 'size', 'type', 'group', 'permissions', 'date_modified']"

dconf write /org/cinnamon/desktop/interface/icon-theme "'$cinnamon_icon_name'"
dconf write /org/cinnamon/desktop/interface/icon-theme-backup "'$cinnamon_icon_name_backup'"
dconf write /org/cinnamon/settings-daemon/plugins/xsettings/buttons-have-icons "true"
dconf write /org/nemo/desktop/computer-icon-visible "false"
dconf write /org/nemo/desktop/network-icon-visible "false"
dconf write /org/nemo/desktop/trash-icon-visible "true"
dconf write /org/nemo/preferences/show-home-icon-toolbar "true"
dconf write /org/nemo/preferences/show-reload-icon-toolbar "true"
dconf write /org/nemo/preferences/show-open-in-terminal-toolbar "true"
dconf write /org/cinnamon/desktop/interface/cursor-theme "'$cinnamon_cursor_name'"
dconf write /org/cinnamon/theme/name "'$cinnamon_theme_name'"
dconf write /org/cinnamon/desktop/interface/gtk-theme "'$cinnamon_theme_name'"
dconf write /org/cinnamon/desktop/interface/gtk-theme-backup "'$cinnamon_theme_name_backup'"
dconf write /org/cinnamon/desktop/wm/preferences/theme "'$cinnamon_theme_name_window'"
dconf write /org/cinnamon/desktop/wm/preferences/theme-backup "'$cinnamon_theme_name_window_backup'"
dconf write /org/cinnamon/desktop/wm/preferences/button-layout "'close,minimize,maximize:'"
dconf write /org/nemo/window-state/sidebar-width "210"
dconf write /org/nemo/icon-view/default-zoom-level "'small'"
dconf write /org/nemo/list-view/default-zoom-level "'small'"
dconf write /org/nemo/list-view/default-column-order "$cinnamon_nemo_columns"
dconf write /org/nemo/list-view/default-visible-columns "$cinnamon_nemo_columns"
dconf write /org/nemo/list-view/search-visible-columns "$cinnamon_nemo_search_columns"
dconf write /org/nemo/preferences/date-format "'iso'"
dconf write /org/nemo/preferences/default-folder-viewer "'list-view'"
dconf write /org/nemo/preferences/show-advanced-permissions "true"
dconf write /org/nemo/preferences/ignore-view-metadata "true"
dconf write /org/gnome/nautilus/window-state/sidebar-width "210"
dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
dconf write /org/gnome/nautilus/list-view/default-zoom-level "'standard'"
dconf write /org/gnome/nautilus/list-view/default-column-order "$cinnamon_nautilus_columns"
dconf write /org/gnome/nautilus/list-view/default-visible-columns "$cinnamon_nautilus_columns"
dconf write /org/gnome/nautilus/list-view/use-tree-view "true"
dconf write /org/gnome/nautilus/preferences/default-folder-viewer "'list-view'"

conf=$'[Greeter]\n'
conf+=$'show-hostname=true\n'
conf+=$'draw-grid=false\n'
conf+=$'theme-name=Mint-Y-Dark\n'
conf+=$'icon-theme-name=Mint-Y-Dark\n'
echo "$conf" | sudo tee "/etc/lightdm/slick-greeter.conf"

conf=$'[desktop-monitor-0]\n'
conf+=$'desktop-horizontal=true\n'
conf+=$'desktop-grid-adjust=107;75;\n'
echo "$conf" > "$HOME/.config/nemo/desktop-metadata"

echo "appearances have been configured"

printLine "Cinnamon Actions"

dconf write /org/cinnamon/alttab-switcher-enforce-primary-monitor "true"
dconf write /org/cinnamon/alttab-switcher-show-all-workspaces "true"
dconf write /org/cinnamon/bring-windows-to-current-workspace "true"
dconf write /org/cinnamon/muffin/attach-modal-dialogs "false"
dconf write /org/cinnamon/desktop/wm/preferences/mouse-button-modifier "'<Super>'"
dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action "'nothing'"
dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action "'nothing'"
dconf write /org/gnome/nautilus/compression/default-compression-format "'7z'"
dconf write /org/gnome/nautilus/preferences/executable-text-activation "'ask'"
dconf write /org/gnome/terminal/legacy/menu-accelerator-enabled "false"

echo "actions have been configured"

printLine "Finished"
echo "Done, please reboot your system."
echo ""