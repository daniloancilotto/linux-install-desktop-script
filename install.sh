#!/bin/bash
args=("$@")
arch="amd64"
if [ "`uname -m`" != "x86_64" ]
then
  arch="i386"
fi

echo "DESKTOP ENVIRONMENT SCRIPT"
echo "Author: Danilo Ancilotto"
echo "Arguments: [$args]"
echo "Architecture: $arch"
echo "Interface: $DESKTOP_SESSION"
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

dpkgInstall() {
  file="$HOME/$1"
  wget -O "$file" "$2"
  sudo dpkg -i "$file"
  rm -fv "$file"
  sudo apt install -fy
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

printLine "Base Apps"
sudo apt update
sudo apt install curl wget git unzip tar jq neofetch htop -y

if ! [[ "${args[@]}" =~ "--only-add-ons" ]]
then
  printLine "App Hubs"
  sudo apt install snapd flatpak -y
  sudo systemctl enable --now snapd.socket
  sudo flatpak remote-add --if-not-exists flathub "https://dl.flathub.org/repo/flathub.flatpakrepo"

  printLine "4K Video Downloader"
  if [ ! -f "/usr/bin/4kvideodownloader" ]
  then
    dpkgInstall "4kvideodownloader.deb" "https://dl.4kdownload.com/app/4kvideodownloader_4.8.0-1_$arch.deb"
  else
    echo "4kvideodownloader is already installed"
  fi

  printLine "Angry IP Scanner"
  if [ ! -f "/usr/bin/ipscan" ]
  then
    dpkgInstall "angryipscanner.deb" "https://github.com/angryip/ipscan/releases/download/3.5.5/ipscan_3.5.5_$arch.deb"
  else
    echo "angryipscanner is already installed"
  fi

  printLine "Dconf Tools"
  sudo apt install dconf-tools -y

  printLine "Discord"
  echo "Running snap, please wait..."
  sudo snap install discord

  printLine "Dropbox"
  sudo apt install dropbox -y

  printLine "Furius ISO Mount"
  sudo apt install furiusisomount -y

  printLine "Google Chrome"
  if [ -z "`google-chrome --version`" ]
  then
    dpkgInstall "google-chrome.deb" "https://dl.google.com/linux/direct/google-chrome-stable_current_$arch.deb"
  else
    echo "google-chrome is already installed"
  fi

  printLine "GParted"
  sudo apt install gparted -y

  printLine "OBS Studio"
  sudo flatpak install flathub com.obsproject.Studio -y

  printLine "Oracle VM VirtualBox"
  if [ -z "`vboxmanage --version`" ]
  then
    dpkgInstall "oracle-vm-virtualbox.deb" "https://download.virtualbox.org/virtualbox/6.0.8/virtualbox-6.0_6.0.8-130520~Ubuntu~bionic_$arch.deb"
  else
    echo "vbox is already installed"
  fi
  if [ -z "`vboxmanage list extpacks | grep -i 'version'`" ]
  then
    file="$HOME/Oracle_VM_VirtualBox_Extension_Pack.vbox-extpack"
    wget -O "$file" "https://download.virtualbox.org/virtualbox/6.0.8/Oracle_VM_VirtualBox_Extension_Pack-6.0.8.vbox-extpack"
    echo y | sudo vboxmanage extpack install "$file"
    rm -fv "$file"
  else
    echo "vbox-extpack is already installed"
  fi
  sudo usermod -aG vboxusers $USER

  printLine "Remmina"
  sudo apt install remmina remmina-plugin-rdp remmina-plugin-vnc -y

  printLine "Spotify"
  echo "Running snap, please wait..."
  sudo snap install spotify

  printLine "Steam"
  sudo apt install steam -y
fi

if [[ "${args[@]}" =~ "--with-add-ons" ]] || [[ "${args[@]}" =~ "--only-add-ons" ]]
then
  if [ "$DESKTOP_SESSION" == "cinnamon" ]
  then
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
          'panel1:center:0:cpu-monitor-text@gnemonix',
          'panel1:center:1:mem-monitor-text@datanom.net',
          'panel1:right:0:notifications@cinnamon.org',
          'panel1:right:1:weather@mockturtl',
          'panel1:right:2:trash@cinnamon.org',
          'panel1:right:3:removable-drives@cinnamon.org',
          'panel1:right:4:systray@cinnamon.org',
          'panel1:right:5:keyboard@cinnamon.org',
          'panel1:right:6:betterlock',
          'panel1:right:7:xrandr@cinnamon.org',
          'panel1:right:8:blueberry@cinnamon.org',
          'panel1:right:9:network@cinnamon.org',
          'panel1:right:10:sound@cinnamon.org',
          'panel1:right:11:power@cinnamon.org',
          'panel1:right:12:calendar@cinnamon.org',
          'panel1:right:13:show-desktop@cinnamon.org',
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

    for i in {1..10}
    do
      file="`ls -1 $HOME/.cinnamon/configs/menu@cinnamon.org/*.json 2> /dev/null | tail -n1`"
      if [ -f "$file" ]
      then
        json="`cat "$file"`"
        json="`echo "$json" | jq '."menu-custom"."value"=true'`"
        json="`echo "$json" | jq '."menu-icon"."value"="linuxmint-logo-flat-4-symbolic"'`"
        json="`echo "$json" | jq '."menu-label"."value"=" Menu"'`"
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
      file="`ls -1 $HOME/.cinnamon/configs/calendar@cinnamon.org/*.json 2> /dev/null | tail -n1`"
      if [ -f "$file" ]
      then
        json="`cat "$file"`"
        json="`echo "$json" | jq '."use-custom-format"."value"=true'`"
        json="`echo "$json" | jq '."custom-format"."value"="  %H:%M:%S\n%d/%m/%Y"'`"
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
      file="`ls -1 $HOME/.cinnamon/configs/show-desktop@cinnamon.org/*.json 2> /dev/null | tail -n1`"
      if [ -f "$file" ]
      then
        json="`cat "$file"`"
        json="`echo "$json" | jq '."peek-at-desktop"."value"=true'`"
        echo "$json" > "$file"
        break
      else
        if [ $i == 1 ]
        then
          echo -n "Waiting for show-desktop@cinnamon.org..."
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
          "discord_discord.desktop",
          "steam.desktop",
          "virtualbox.desktop",
          "org.remmina.Remmina.desktop",
          "org.gnome.Screenshot.desktop",
          "org.gnome.Calculator.desktop",
          "slack.desktop",
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

    printLine "Cinnamon Themes"

    cinnamon_windows_dir="$HOME/.themes"
    cinnamon_window_name="Mojave-2019-06-23-Dark"
    if [ ! -d "$cinnamon_windows_dir/$cinnamon_window_name" ]
    then
      mkdir -pv "$cinnamon_windows_dir"
      file="$cinnamon_windows_dir/mojave-dark.tar.xz"
      wget -O "$file" "https://github.com/daniloancilotto/mojave-gtk-theme/releases/download/2019-06-23/Mojave-dark.tar.xz"
      tar -xf "$file" -C "$cinnamon_windows_dir"
      mv -fv "$cinnamon_windows_dir/Mojave-dark" "$cinnamon_windows_dir/$cinnamon_window_name"
      rm -fv "$file"
    else
      echo "$cinnamon_window_name is already installed"
    fi
    cinnamon_window_name_backup="Mint-Y-Dark"
    if [ ! -d "$cinnamon_windows_dir/$cinnamon_window_name" ]
    then
      cinnamon_window_name="$cinnamon_window_name_backup"
    fi

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

    dconf write /org/cinnamon/theme/name "'$cinnamon_window_name'"
    dconf write /org/cinnamon/desktop/interface/gtk-theme "'$cinnamon_window_name'"
    dconf write /org/cinnamon/desktop/interface/gtk-theme-backup "'$cinnamon_window_name_backup'"
    dconf write /org/cinnamon/desktop/wm/preferences/theme "'$cinnamon_window_name'"
    dconf write /org/cinnamon/desktop/wm/preferences/theme-backup "'$cinnamon_window_name_backup'"
    dconf write /org/cinnamon/desktop/wm/preferences/button-layout "'close,minimize,maximize:'"
    dconf write /org/nemo/window-state/sidebar-bookmark-breakpoint "$cinnamon_bookmarks_count"
    dconf write /org/nemo/window-state/sidebar-width "210"
    dconf write /org/nemo/icon-view/default-zoom-level "'small'"
    dconf write /org/nemo/preferences/date-format "'iso'"
    dconf write /org/nemo/preferences/show-advanced-permissions "true"
    dconf write /org/nemo/preferences/ignore-view-metadata "true"
    dconf write /org/gnome/nautilus/window-state/sidebar-width "210"
    dconf write /org/gnome/nautilus/icon-view/default-zoom-level "'small'"
    dconf write /org/gnome/nautilus/list-view/default-zoom-level "'small'"
    dconf write /org/gnome/nautilus/compression/default-compression-format "'7z'"
    dconf write /org/gnome/nautilus/preferences/executable-text-activation "'ask'"
    dconf write /org/gnome/terminal/legacy/menu-accelerator-enabled "false"

    cinnamon_icons_dir="$HOME/.icons"
    cinnamon_icon_name="Korla-1.1.4-Dark"
    if [ ! -d "$cinnamon_icons_dir/$cinnamon_icon_name" ]
    then
      mkdir -pv "$cinnamon_icons_dir"
      file="$cinnamon_icons_dir/korla-dark.zip"
      wget -O "$file" "https://github.com/bikass/korla/archive/v1.1.4.zip"
      unzip -q "$file" -d "$cinnamon_icons_dir"
      mv -fv "$cinnamon_icons_dir/korla-1.1.4/korla" "$cinnamon_icons_dir/$cinnamon_icon_name"
      rm -rf "$cinnamon_icons_dir/korla-1.1.4"
      rm -fv "$file"
    else
      echo "$cinnamon_icon_name is already installed"
    fi
    cinnamon_icon_name_backup="Mint-Y"
    if [ ! -d "$cinnamon_icons_dir/$cinnamon_icon_name" ]
    then
      cinnamon_icon_name="$cinnamon_icon_name_backup"
    fi

    dconf write /org/cinnamon/desktop/interface/icon-theme "'$cinnamon_icon_name'"
    dconf write /org/cinnamon/desktop/interface/icon-theme-backup "'$cinnamon_icon_name_backup'"
    dconf write /org/cinnamon/settings-daemon/plugins/xsettings/buttons-have-icons "true"
    dconf write /org/nemo/desktop/computer-icon-visible "false"
    dconf write /org/nemo/desktop/network-icon-visible "true"
    dconf write /org/nemo/desktop/trash-icon-visible "true"
    dconf write /org/nemo/preferences/show-home-icon-toolbar "true"
    dconf write /org/nemo/preferences/show-reload-icon-toolbar "true"
    dconf write /org/nemo/preferences/show-open-in-terminal-toolbar "true"

    cinnamon_cursors_dir="$HOME/.icons"
    cinnamon_cursor_name="Capitaine-Cursors-R3-Light"
    if [ ! -d "$cinnamon_cursors_dir/$cinnamon_cursor_name" ]
    then
      mkdir -pv "$cinnamon_cursors_dir"
      file="$cinnamon_cursors_dir/capitaine-cursors-light.tar.xz"
      wget -O "$file" "https://github.com/keeferrourke/capitaine-cursors/releases/download/r3/capitaine-cursors-light.tar.xz"
      tar -xf "$file" -C "$cinnamon_cursors_dir"
      mv -fv "$cinnamon_cursors_dir/dist-white" "$cinnamon_cursors_dir/$cinnamon_cursor_name"
      rm -fv "$file"
    else
      echo "$cinnamon_cursor_name is already installed"
    fi
    cinnamon_cursor_name_backup="DMZ-White"
    if [ ! -d "$cinnamon_cursors_dir/$cinnamon_cursor_name" ]
    then
      cinnamon_cursor_name="$cinnamon_cursor_name_backup"
    fi

    dconf write /org/cinnamon/desktop/interface/cursor-theme "'$cinnamon_cursor_name'"

    cinnamon_backgrounds_dir="$HOME/.cinnamon/backgrounds"
    cinnamon_backgrounds=( \
      "Light" \
      "Dark" \
    )
    cinnamon_backgrounds_list="$cinnamon_backgrounds_dir/user-folders.lst"
    mkdir -pv "$cinnamon_backgrounds_dir"
    cp /dev/null "$cinnamon_backgrounds_list"
    i=0
    while [ $i != ${#cinnamon_backgrounds[@]} ]
    do
      cinnamon_background="${cinnamon_backgrounds[$i]}"

      cinnamon_background_items_dir="$cinnamon_backgrounds_dir/$cinnamon_background"
      cinnamon_background_items=()
      if [ "$cinnamon_background" == "Dark" ]
      then
        cinnamon_background_items=( \
          "https://w.wallhaven.cc/full/nk/wallhaven-nkmjyq.jpg" \
          "https://w.wallhaven.cc/full/0q/wallhaven-0qk8qr.jpg" \
          "https://w.wallhaven.cc/full/ym/wallhaven-ymxx57.jpg" \
        )
      fi
      mkdir -pv "$cinnamon_background_items_dir"
      echo "$cinnamon_background_items_dir" >> "$cinnamon_backgrounds_list"
      j=0
      while [ $j != ${#cinnamon_background_items[@]} ]
      do
        cinnamon_background_item="${cinnamon_background_items[$j]}"

        cinnamon_background_item_file="${cinnamon_background_item##*/}"
        if [ ! -f "$cinnamon_background_items_dir/$cinnamon_background_item_file" ]
        then
          wget -O "$cinnamon_background_items_dir/$cinnamon_background_item_file" "$cinnamon_background_item"
        else
          echo "$cinnamon_background_item_file is already installed"
        fi

        let "j++"
      done

      let "i++"
    done

    dconf write /org/cinnamon/desktop/background/picture-uri "'file://$cinnamon_background_items_dir/$cinnamon_background_item_file'"
    dconf write /org/cinnamon/desktop/background/slideshow/image-source "'directory://$cinnamon_background_items_dir'"
    dconf write /org/cinnamon/desktop/background/slideshow/delay "10"
    dconf write /org/cinnamon/desktop/background/slideshow/random-order "true"
    dconf write /org/cinnamon/desktop/background/slideshow/slideshow-enabled "true"

    conf=$'[Greeter]\n'
    conf+=$'show-hostname=true\n'
    conf+=$'draw-grid=false\n'
    conf+=$'theme-name=Mint-Y-Dark-Blue\n'
    conf+=$'icon-theme-name=Mint-Y-Blue\n'
    echo "$conf" | sudo tee "/etc/lightdm/slick-greeter.conf"

    conf=$'[desktop-monitor-0]\n'
    conf+=$'desktop-horizontal=true\n'
    conf+=$'desktop-grid-adjust=107;75;\n'
    echo "$conf" > "$HOME/.config/nemo/desktop-metadata"

    echo "themes have been configured"

    printLine "Cinnamon Actions"

    dconf write /org/cinnamon/alttab-switcher-enforce-primary-monitor "true"
    dconf write /org/cinnamon/alttab-switcher-show-all-workspaces "true"
    dconf write /org/cinnamon/bring-windows-to-current-workspace "true"
    dconf write /org/cinnamon/muffin/attach-modal-dialogs "true"
    dconf write /org/cinnamon/desktop/wm/preferences/mouse-button-modifier "'<Super>'"
    dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action "'nothing'"
    dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action "'nothing'"

    echo "actions have been configured"
  fi
fi

printLine "Finished"
echo "Done, please reboot your system."
echo ""
