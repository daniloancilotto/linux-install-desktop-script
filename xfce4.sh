#!/bin/bash
system="`lsb_release -sd`"

echo "DESKTOP ENVIRONMENT SCRIPT - XFCE4"
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

printLine "Xfce4 Spices"

xfce4_panel_0_plugin_names=("launcher_1" "launcher_2" "launcher_3" "appmenu" "separator_1" "systray" "notification-plugin" "indicator" "statusnotifier" "power-manager-plugin" "pulseaudio" "clock")
xfce4_panel_0_plugin_types=""
xfce4_panel_0_plugin_values=""
xfce4_panel_1_plugin_names=("whiskermenu" "tasklist" "separator_2")
xfce4_panel_1_plugin_types=""
xfce4_panel_1_plugin_values=""

j=0
while [ $j != ${#xfce4_panel_0_plugin_names[@]} ]
do
  xfce4_panel_0_plugin_name=${xfce4_panel_0_plugin_names[$j]}
  xfce4_panel_0_plugin_varname="xfce4_panel_0_plugin_${xfce4_panel_0_plugin_name//-/_}"
  xfce4_panel_0_plugin_name=${xfce4_panel_0_plugin_name%_*}
  declare $xfce4_panel_0_plugin_varname=0

  let "j++"
done
j=0
while [ $j != ${#xfce4_panel_1_plugin_names[@]} ]
do
  xfce4_panel_1_plugin_name=${xfce4_panel_1_plugin_names[$j]}
  xfce4_panel_1_plugin_varname="xfce4_panel_1_plugin_${xfce4_panel_1_plugin_name//-/_}"
  xfce4_panel_1_plugin_name=${xfce4_panel_1_plugin_name%_*}
  declare $xfce4_panel_1_plugin_varname=0

  let "j++"
done

for i in {1..999}
do
  xfce4_panel_plugin_name=(`xfconf-query -c xfce4-panel -p /plugins/plugin-$i -lv`)
  if [[ "$xfce4_panel_plugin_name" =~ "/" ]]
  then
    xfce4_panel_plugin_name=${xfce4_panel_plugin_name[1]}

    k=false
    j=0
    while [ $j != ${#xfce4_panel_0_plugin_names[@]} ]
    do
      xfce4_panel_0_plugin_name=${xfce4_panel_0_plugin_names[$j]}
      xfce4_panel_0_plugin_varname="xfce4_panel_0_plugin_${xfce4_panel_0_plugin_name//-/_}"
      xfce4_panel_0_plugin_name=${xfce4_panel_0_plugin_name%_*}
      if [ "$xfce4_panel_plugin_name" == "$xfce4_panel_0_plugin_name" ] && [ ${!xfce4_panel_0_plugin_varname} == 0 ]
      then
        declare $xfce4_panel_0_plugin_varname=$i

        k=true
        j=${#xfce4_panel_0_plugin_names[@]}
      else
        let "j++"
      fi
    done
    if $k
    then
      continue
    fi 
    j=0
    while [ $j != ${#xfce4_panel_1_plugin_names[@]} ]
    do
      xfce4_panel_1_plugin_name=${xfce4_panel_1_plugin_names[$j]}
      xfce4_panel_1_plugin_varname="xfce4_panel_1_plugin_${xfce4_panel_1_plugin_name//-/_}"
      xfce4_panel_1_plugin_name=${xfce4_panel_1_plugin_name%_*}
      if [ "$xfce4_panel_plugin_name" == "$xfce4_panel_1_plugin_name" ] && [ ${!xfce4_panel_1_plugin_varname} == 0 ]
      then
        declare $xfce4_panel_1_plugin_varname=$i

        k=true
        j=${#xfce4_panel_1_plugin_names[@]}
      else
        let "j++"
      fi
    done
  else
    break
  fi
done

j=0
while [ $j != ${#xfce4_panel_0_plugin_names[@]} ]
do
  xfce4_panel_0_plugin_name=${xfce4_panel_0_plugin_names[$j]}
  xfce4_panel_0_plugin_varname="xfce4_panel_0_plugin_${xfce4_panel_0_plugin_name//-/_}"
  xfce4_panel_0_plugin_number=${xfce4_panel_0_plugin_name##*_}
  xfce4_panel_0_plugin_name=${xfce4_panel_0_plugin_name%_*}
  if [ ${!xfce4_panel_0_plugin_varname} == 0 ]
  then
    xfconf-query -c xfce4-panel -p /plugins/plugin-$i -n -t string -s "$xfce4_panel_0_plugin_name"
    declare $xfce4_panel_0_plugin_varname=$i

    let "i++"
  fi

  k="${!xfce4_panel_0_plugin_varname}"
  if [ "$xfce4_panel_0_plugin_name" == "launcher" ]
  then
    case $xfce4_panel_0_plugin_number in
      1)
        mkdir -pv "$HOME/.config/xfce4/panel/launcher-$k"
        file="$HOME/.config/xfce4/panel/launcher-$k/window-close.desktop"
        if [ ! -f "$file" ]
        then
          conf=$'[Desktop Entry]\n'
          conf+=$'Version=1.0\n'
          conf+=$'Type=Application\n'
          conf+=$'Name=Window Close\n'
          conf+=$'Comment=\n'
          conf+=$'Exec=wmctrl -c ":ACTIVE:"\n'
          conf+=$'Icon=window-close\n'
          conf+=$'Path=/tmp/\n'
          conf+=$'Terminal=false\n'
          conf+=$'StartupNotify=false\n'
          echo "$conf" > "$file"
        fi

        xfconf-query -c xfce4-panel -p /plugins/plugin-$k/disable-tooltips -n -t bool -s true
        xfconf-query -c xfce4-panel -p /plugins/plugin-$k/items -n -a -t string -s "window-close.desktop"
      ;;
      2)
        mkdir -pv "$HOME/.config/xfce4/panel/launcher-$k"
        file="$HOME/.config/xfce4/panel/launcher-$k/window-minimize.desktop"
        if [ ! -f "$file" ]
        then
          conf=$'[Desktop Entry]\n'
          conf+=$'Version=1.0\n'
          conf+=$'Type=Application\n'
          conf+=$'Name=Window Minimize\n'
          conf+=$'Comment=\n'
          conf+=$'Exec=xdotool key alt+space key n\n'
          conf+=$'Icon=window-minimize\n'
          conf+=$'Path=/tmp/\n'
          conf+=$'Terminal=false\n'
          conf+=$'StartupNotify=false\n'
          echo "$conf" > "$file"
        fi

        xfconf-query -c xfce4-panel -p /plugins/plugin-$k/disable-tooltips -n -t bool -s true
        xfconf-query -c xfce4-panel -p /plugins/plugin-$k/items -n -a -t string -s "window-minimize.desktop"
      ;;
      3)
        mkdir -pv "$HOME/.config/xfce4/panel/launcher-$k"
        file="$HOME/.config/xfce4/panel/launcher-$k/window-maximize.desktop"
        if [ ! -f "$file" ]
        then
          conf=$'[Desktop Entry]\n'
          conf+=$'Version=1.0\n'
          conf+=$'Type=Application\n'
          conf+=$'Name=Window Maximize\n'
          conf+=$'Comment=\n'
          conf+=$'Exec=wmctrl -r ":ACTIVE:" -b toggle,maximized_vert,maximized_horz\n'
          conf+=$'Icon=window-maximize\n'
          conf+=$'Path=/tmp/\n'
          conf+=$'Terminal=false\n'
          conf+=$'StartupNotify=false\n'
          echo "$conf" > "$file"
        fi

        xfconf-query -c xfce4-panel -p /plugins/plugin-$k/disable-tooltips -n -t bool -s true
        xfconf-query -c xfce4-panel -p /plugins/plugin-$k/items -n -a -t string -s "window-maximize.desktop"
      ;;
    esac
  elif [ "$xfce4_panel_0_plugin_name" == "separator" ]
  then
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/expand -n -t bool -s true
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/style -n -t int -s 0
  fi

  xfce4_panel_0_plugin_types="$xfce4_panel_0_plugin_types -t int"
  xfce4_panel_0_plugin_values="$xfce4_panel_0_plugin_values -s ${!xfce4_panel_0_plugin_varname}"

  let "j++"
done
j=0
while [ $j != ${#xfce4_panel_1_plugin_names[@]} ]
do
  xfce4_panel_1_plugin_name=${xfce4_panel_1_plugin_names[$j]}
  xfce4_panel_1_plugin_varname="xfce4_panel_1_plugin_${xfce4_panel_1_plugin_name//-/_}"
  xfce4_panel_1_plugin_number=${xfce4_panel_1_plugin_name##*_}
  xfce4_panel_1_plugin_name=${xfce4_panel_1_plugin_name%_*}
  if [ ${!xfce4_panel_1_plugin_varname} == 0 ]
  then
    xfconf-query -c xfce4-panel -p /plugins/plugin-$i -n -t string -s "$xfce4_panel_1_plugin_name"
    declare $xfce4_panel_1_plugin_varname=$i

    let "i++"
  fi

  k="${!xfce4_panel_1_plugin_varname}"
  if [ "$xfce4_panel_1_plugin_name" == "tasklist" ]
  then
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/show-handle -n -t bool -s false
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/show-labels -n -t bool -s false
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/flat-buttons -n -t bool -s true
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/grouping -n -t int -s 1
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/sort-order -n -t int -s 4
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/include-all-workspaces -n -t bool -s true
  elif [ "$xfce4_panel_1_plugin_name" == "separator" ]
  then
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/expand -n -t bool -s true
    xfconf-query -c xfce4-panel -p /plugins/plugin-$k/style -n -t int -s 0
  fi

  xfce4_panel_1_plugin_types="$xfce4_panel_1_plugin_types -t int"
  xfce4_panel_1_plugin_values="$xfce4_panel_1_plugin_values -s ${!xfce4_panel_1_plugin_varname}"

  let "j++"
done

xfconf-query -c xfce4-panel -p /panels -n -t int -t int -s 0 -s 1
xfconf-query -c xfce4-panel -p /panels/panel-0/size -n -t int -s 27
xfconf-query -c xfce4-panel -p /panels/panel-0/plugin-ids -n -a $xfce4_panel_0_plugin_types $xfce4_panel_0_plugin_values
xfconf-query -c xfce4-panel -p /panels/panel-1/mode -n -t int -s 2
xfconf-query -c xfce4-panel -p /panels/panel-1/position -n -t string -s "p=7;x=17;y=360"
xfconf-query -c xfce4-panel -p /panels/panel-1/length -n -t int -s 96
xfconf-query -c xfce4-panel -p /panels/panel-1/length-adjust -n -t bool -s false
xfconf-query -c xfce4-panel -p /panels/panel-1/size -n -t int -s 39
xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids -n -a $xfce4_panel_1_plugin_types $xfce4_panel_1_plugin_values
xfce4-panel -r

xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -n -t bool -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-home -n -t bool -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -n -t bool -s false
xfconf-query -c xfce4-notifyd -p /primary-monitor -n -t int -s 1

echo "spices have been configured"

printLine "Xfce4 Appearances"

xfconf-query -c xsettings -p /Net/IconThemeName -n -t string -s "Humanity-Dark"
xfconf-query -c xsettings -p /Net/FallbackIconTheme -n -t string -s "ubuntu-mono-dark"
xfconf-query -c xsettings -p /Net/ThemeName -n -t string -s "Adwaita-dark"
xfconf-query -c xsettings -p /Gtk/DecorationLayout -n -t string -s "close,minimize,maximize:"
xfconf-query -c xfwm4 -p /general/button_layout -n -t string -s "CHM|"
xfconf-query -c xfwm4 -p /general/theme -n -t string -s "Numix"
xfconf-query -c xfwm4 -p /general/titleless_maximize -n -t bool -s true
xfconf-query -c xfce4-desktop -p /desktop-icons/gravity -n -t int -s 1

echo "appearances have been configured"

printLine "Xfce4 Actions"

xfconf-query -c xfwm4 -p /general/easy_click -n -t string -s "Super"
xfconf-query -c xfwm4 -p /general/cycle_workspaces -n -t bool -s true

echo "actions have been configured"

printLine "Finished"
echo "Done, please reboot your system."
echo ""