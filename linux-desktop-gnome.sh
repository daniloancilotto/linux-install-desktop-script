#!/bin/bash
system="`lsb_release -sd`"

echo "LINUX DESKTOP GNOME"
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
      "https://extensions.gnome.org/extension-data/unitehardpixel.eu.v39.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/clock-overridegnomeshell.kryogenix.org.v12.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/openweather-extensionjenslody.de.v100.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/VitalsCoreCoding.com.v31.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/lockkeysvaina.lt.v38.shell-extension.zip" \
      "https://extensions.gnome.org/extension-data/sound-output-device-chooserkgshank.net.v28.shell-extension.zip" \
    )
    gnome_spice_items_names=( \
      "unite@hardpixel.eu" \
      "clock-override@gnomeshell.kryogenix.org" \
      "openweather-extension@jenslody.de" \
      "Vitals@CoreCoding.com" \
      "lockkeys@vaina.lt" \
      "sound-output-device-chooser@kgshank.net" \
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
      'lockkeys@vaina.lt',
      'sound-output-device-chooser@kgshank.net'
    ]"
  fi
  dconf write /org/gnome/shell/enabled-$gnome_spice "$gnome_spice_dconf"

  let "i++"
done

dconf write /org/gnome/shell/extensions/unite/extend-left-box "false"
dconf write /org/gnome/shell/extensions/unite/use-system-fonts "false"
dconf write /org/gnome/shell/extensions/unite/window-buttons-theme "'yaru'"
dconf write /org/gnome/shell/extensions/clock_override/override-string "'%d/%m/%Y  %H:%M:%S'"
dconf write /org/gnome/shell/extensions/vitals/alphabetize "false"
dconf write /org/gnome/shell/extensions/vitals/position-in-panel "1"
dconf write /org/gnome/shell/extensions/vitals/hot-sensors "[
  '_processor_average_',
  '__temperature_avg__',
  '_memory_usage_',
  '_storage_free_'
]"
dconf write /org/gnome/shell/extensions/vitals/storage-path "'$HOME'"
dconf write /org/gnome/shell/extensions/openweather/city "'-21.1328313,-51.1029422>Mirandópolis, BR>-1'"
dconf write /org/gnome/shell/extensions/openweather/days-forecast "10"
dconf write /org/gnome/shell/extensions/openweather/decimal-places "0"
dconf write /org/gnome/shell/extensions/openweather/pressure-unit "'hPa'"
dconf write /org/gnome/shell/extensions/openweather/unit "'celsius'"
dconf write /org/gnome/shell/extensions/openweather/wind-speed-unit "'kph'"
dconf write /org/gnome/shell/extensions/lockkeys/notifications "false"
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
  'spotify_spotify.desktop',
  'steam.desktop',
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
  'arduino-arduinoide-esp32.desktop',
  'code_code.desktop',
  'mysql-workbench.desktop',
  'postman_postman.desktop'
]"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Internet/ name "Internet"
dconf write /org/gnome/desktop/app-folders/folders/Internet/apps "[
  '4kvideodownloader.desktop',
  'firefox.desktop',
  'freerapiddownloader.desktop',
  'google-chrome.desktop',
  'slack_slack.desktop',
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
  'gnome-session-properties.desktop',
  'nvidia-settings.desktop',
  'org.gnome.Extensions.desktop',
  'org.gnome.tweaks.desktop'
]"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Updaters/ name "Atualizações"
dconf write /org/gnome/desktop/app-folders/folders/Updaters/apps "[
  'org.gnome.Software.desktop',
  'software-properties-drivers.desktop',
  'software-properties-gtk.desktop',
  'software-properties-livepatch.desktop',
  'update-manager.desktop'
]"
gsettings set org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Utilities/ name "Utilitários"
dconf write /org/gnome/desktop/app-folders/folders/Utilities/apps "[
  'appimagekit-balena-etcher-electron.desktop',
  'cpu-x.desktop',
  'dropbox.desktop',
  'eog.desktop',
  'gnome-language-selector.desktop',
  'gnome-system-log.desktop',
  'gnome-system-monitor.desktop',
  'gparted.desktop',
  'htop.desktop',
  'im-config.desktop',
  'ipscan.desktop',
  'nemo.desktop',
  'openjdk-8-policytool.desktop',
  'org.gnome.Characters.desktop',
  'org.gnome.DiskUtility.desktop',
  'org.gnome.eog.desktop',
  'org.gnome.Evince.desktop',
  'org.gnome.FileRoller.desktop',
  'org.gnome.font-viewer.desktop',
  'org.gnome.PowerStats.desktop',
  'org.gnome.seahorse.Application.desktop',
  'scrcpy.desktop',
  'yelp.desktop'
]"
dconf write /org/gnome/desktop/app-folders/folders/Utilities/excluded-apps "[
  'org.gnome.Screenshot.desktop'
]"
dconf write /org/gnome/desktop/app-folders/folders/Utilities/translate "false"
dconf write /org/gnome/desktop/app-folders/folder-children "[
  'Development',
  'Internet',
  'LibreOffice',
  'Settings',
  'Updaters',
  'Utilities'
]"

file="/usr/share/applications/info.desktop"
if [ -f "$file" ]
then
  sudo sed -i '/^NoDisplay=/{h;s/=.*/=true/};${x;/^$/{s//NoDisplay=true/;H};x}' "$file"
fi

echo "spices have been configured"

printLine "GNOME Appearances"

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
    gnome_bookmark="file://$HOME/${gnome_bookmark// /%20} $gnome_bookmark"

    echo "$gnome_bookmark" >> "$gnome_bookmarks_list"
    let "gnome_bookmarks_count++"
  fi

  let "i++"
done
unset $IFS

gnome_icon_name="Yaru"
gnome_cursor_name="Yaru"
gnome_theme_name="Yaru-dark"
gnome_nautilus_columns="['name', 'size', 'detailed_type', 'group', 'permissions', 'date_modified']"
gnome_nemo_columns="['name', 'size', 'detailed_type', 'group', 'permissions', 'date_modified']"
gnome_nemo_search_columns="['name', 'size', 'detailed_type', 'where']"

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
dconf write /org/nemo/preferences/show-home-icon-toolbar "true"
dconf write /org/nemo/preferences/show-reload-icon-toolbar "true"
dconf write /org/nemo/preferences/show-open-in-terminal-toolbar "true"
dconf write /org/nemo/window-state/sidebar-bookmark-breakpoint "$gnome_bookmarks_count"
dconf write /org/nemo/window-state/sidebar-width "210"
dconf write /org/nemo/icon-view/default-zoom-level "'small'"
dconf write /org/nemo/list-view/default-zoom-level "'small'"
dconf write /org/nemo/list-view/default-column-order "$gnome_nemo_columns"
dconf write /org/nemo/list-view/default-visible-columns "$gnome_nemo_columns"
dconf write /org/nemo/list-view/search-visible-columns "$gnome_nemo_search_columns"
dconf write /org/nemo/preferences/date-format "'iso'"
dconf write /org/nemo/preferences/default-folder-viewer "'list-view'"
dconf write /org/nemo/preferences/ignore-view-metadata "true"

echo "appearances have been configured"

printLine "GNOME Actions"

dconf write /org/gnome/mutter/attach-modal-dialogs "false"
dconf write /org/gnome/settings-daemon/plugins/power/lid-close-battery-action "'nothing'"
dconf write /org/gnome/settings-daemon/plugins/power/lid-close-ac-action "'nothing'"
dconf write /org/gnome/nautilus/compression/default-compression-format "'7z'"
dconf write /org/gnome/nautilus/preferences/executable-text-activation "'ask'"
dconf write /org/gnome/terminal/legacy/menu-accelerator-enabled "false"

file="/usr/share/X11/xkb/symbols/br"
sudo sed -i ':a;N;$!ba;s/ modifier_map Mod3   { Scroll_Lock };/ \/\/modifier_map Mod3   { Scroll_Lock };/g' "$file"

echo "actions have been configured"

printLine "Finished"
echo "Done, please reboot your system."
echo ""