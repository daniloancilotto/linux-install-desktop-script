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

xfce4_panel_0_plugin_names=()
xfce4_panel_0_plugin_values=""
xfce4_panel_0_plugin_types=""
xfce4_panel_1_plugin_names=("whiskermenu" "tasklist")
xfce4_panel_1_plugin_values=""
xfce4_panel_1_plugin_types=""

j=0
while [ $j != ${#xfce4_panel_0_plugin_names[@]} ]
do
  xfce4_panel_0_plugin_name=${xfce4_panel_0_plugin_names[$j]}
  xfce4_panel_0_plugin_varname="xfce4_panel_0_plugin_$xfce4_panel_0_plugin_name"
  declare $xfce4_panel_0_plugin_varname=0

  let "j++"
done
j=0
while [ $j != ${#xfce4_panel_1_plugin_names[@]} ]
do
  xfce4_panel_1_plugin_name=${xfce4_panel_1_plugin_names[$j]}
  xfce4_panel_1_plugin_varname="xfce4_panel_1_plugin_$xfce4_panel_1_plugin_name"
  declare $xfce4_panel_1_plugin_varname=0

  let "j++"
done

for i in {1..999}
do
  xfce4_panel_plugin_name=(`xfconf-query -c xfce4-panel -p /plugins/plugin-$i -lv`)
  if [[ "$xfce4_panel_plugin_name" =~ "/" ]]
  then
    xfce4_panel_plugin_name=${xfce4_panel_plugin_name[1]}

    j=0
    while [ $j != ${#xfce4_panel_0_plugin_names[@]} ]
    do
      xfce4_panel_0_plugin_name=${xfce4_panel_0_plugin_names[$j]}
      xfce4_panel_0_plugin_varname="xfce4_panel_0_plugin_$xfce4_panel_0_plugin_name"
      if [ "$xfce4_panel_plugin_name" == "$xfce4_panel_0_plugin_name" ] && [ ${!xfce4_panel_0_plugin_varname} == 0 ]
      then
        declare $xfce4_panel_0_plugin_varname=$i

        j=${#xfce4_panel_0_plugin_names[@]}
      else
        let "j++"
      fi
    done
    j=0
    while [ $j != ${#xfce4_panel_1_plugin_names[@]} ]
    do
      xfce4_panel_1_plugin_name=${xfce4_panel_1_plugin_names[$j]}
      xfce4_panel_1_plugin_varname="xfce4_panel_1_plugin_$xfce4_panel_1_plugin_name"
      if [ "$xfce4_panel_plugin_name" == "$xfce4_panel_1_plugin_name" ] && [ ${!xfce4_panel_1_plugin_varname} == 0 ]
      then
        declare $xfce4_panel_1_plugin_varname=$i

        j=${#xfce4_panel_1_plugin_names[@]}
      else
        let "j++"
      fi
    done

    case $xfce4_panel_plugin_name in
      "tasklist")
        xfconf-query -c xfce4-panel -p /plugins/plugin-$i/flat-buttons -s true -n -t bool
        xfconf-query -c xfce4-panel -p /plugins/plugin-$i/grouping -s 1 -n -t int
        xfconf-query -c xfce4-panel -p /plugins/plugin-$i/include-all-workspaces -s true -n -t bool
        xfconf-query -c xfce4-panel -p /plugins/plugin-$i/show-handle -s false -n -t bool
        xfconf-query -c xfce4-panel -p /plugins/plugin-$i/show-labels -s false -n -t bool
        xfconf-query -c xfce4-panel -p /plugins/plugin-$i/sort-order -s 4 -n -t int
      ;;
    esac
  else
    break
  fi
done

j=0
while [ $j != ${#xfce4_panel_0_plugin_names[@]} ]
do
  xfce4_panel_0_plugin_name=${xfce4_panel_0_plugin_names[$j]}
  xfce4_panel_0_plugin_varname="xfce4_panel_0_plugin_$xfce4_panel_0_plugin_name"
  if [ ${!xfce4_panel_0_plugin_varname} == 0 ]
  then
    xfconf-query -c xfce4-panel -p /plugins/plugin-$i -s "$xfce4_panel_0_plugin_name" -n -t string
    declare $xfce4_panel_0_plugin_varname=$i

    let "i++"
  fi

  xfce4_panel_0_plugin_values="$xfce4_panel_0_plugin_values -s ${!xfce4_panel_0_plugin_varname}"
  xfce4_panel_0_plugin_types="$xfce4_panel_0_plugin_types -t int"

  let "j++"
done
j=0
while [ $j != ${#xfce4_panel_1_plugin_names[@]} ]
do
  xfce4_panel_1_plugin_name=${xfce4_panel_1_plugin_names[$j]}
  xfce4_panel_1_plugin_varname="xfce4_panel_1_plugin_$xfce4_panel_1_plugin_name"
  if [ ${!xfce4_panel_1_plugin_varname} == 0 ]
  then
    xfconf-query -c xfce4-panel -p /plugins/plugin-$i -s "$xfce4_panel_1_plugin_name" -n -t string
    declare $xfce4_panel_1_plugin_varname=$i

    let "i++"
  fi

  xfce4_panel_1_plugin_values="$xfce4_panel_1_plugin_values -s ${!xfce4_panel_1_plugin_varname}"
  xfce4_panel_1_plugin_types="$xfce4_panel_1_plugin_types -t int"

  let "j++"
done

xfconf-query -c xfce4-panel -p /panels -s 0 -s 1  -n  -t int -t int
xfconf-query -c xfce4-panel -p /panels/panel-0/size -s 27 -n -t int
#xfconf-query -c xfce4-panel -p /panels/panel-0/plugin-ids $xfce4_panel_0_plugin_values  -n $xfce4_panel_0_plugin_types
xfconf-query -c xfce4-panel -p /panels/panel-1/length -s 96 -n -t int
xfconf-query -c xfce4-panel -p /panels/panel-1/length-adjust -s false -n -t bool
xfconf-query -c xfce4-panel -p /panels/panel-1/mode -s 2 -n -t int
xfconf-query -c xfce4-panel -p /panels/panel-1/position -s "p=7;x=17;y=360" -n -t string
xfconf-query -c xfce4-panel -p /panels/panel-1/size -s 37 -n -t int
xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids $xfce4_panel_1_plugin_values  -n $xfce4_panel_1_plugin_types
xfce4-panel -r

xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-home -s false
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -s false
xfconf-query -c xfce4-notifyd -p /primary-monitor -s 1

echo "spices have been configured"

printLine "Xfce4 Appearances"

xfconf-query -c xsettings -p /Net/IconThemeName -s "Humanity-Dark"
xfconf-query -c xsettings -p /Net/FallbackIconTheme -s "ubuntu-mono-dark"
xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita-dark"
xfconf-query -c xsettings -p /Gtk/DecorationLayout -s "close,minimize,maximize:"
xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"
xfconf-query -c xfwm4 -p /general/theme -s "Numix"
xfconf-query -c xfce4-desktop -p /desktop-icons/gravity -s 1

echo "appearances have been configured"

printLine "Xfce4 Actions"

xfconf-query -c xfwm4 -p /general/easy_click -s "Super"
xfconf-query -c xfwm4 -p /general/cycle_workspaces -s true

echo "actions have been configured"

printLine "Finished"
echo "Done, please reboot your system."
echo ""