# Linux Desktop Script

### Supported Systems
* [Ubuntu - 20.04](https://ubuntu.com/)

### Supported Desktops
* [GNOME - 3.36](https://www.gnome.org/)

<br/>

# Preparing to Run the Script

### Ubuntu GNOME
```bash
sudo apt install curl wget unzip p7zip-full dconf-cli dconf-editor gnome-software gnome-tweaks gnome-shell-extension-prefs chrome-gnome-shell x11-utils gir1.2-gtop-2.0 lm-sensors -y
```

<br/>

# Running the Script

### GNOME
```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/linux-desktop-script/master/linux-desktop-gnome.sh | bash
```

<br/>

# Installations and Configurations

### GNOME Spices
* Extensions
  * [Unite - v40](https://extensions.gnome.org/extension/1287/unite/)
  * [Clock Override - v12](https://extensions.gnome.org/extension/1206/clock-override/)
  * [OpenWeather - v102](https://extensions.gnome.org/extension/750/openweather/)
  * [Vitals - v31](https://extensions.gnome.org/extension/1460/vitals/)
  * [Lock Keys - v38](https://extensions.gnome.org/extension/36/lock-keys/)
  * [User Themes - v40](https://extensions.gnome.org/extension/19/user-themes/)
  * [Sound Input & Output Device Chooser - v29](https://extensions.gnome.org/extension/906/sound-output-device-chooser/)
  * [Applications Overview Tooltip - v8](https://extensions.gnome.org/extension/1071/applications-overview-tooltip/)
* Dconf
  * /org/gnome/shell/enabled-extensions
  * /org/gnome/shell/extensions/unite/desktop-name-text
  * /org/gnome/shell/extensions/unite/show-window-title
  * /org/gnome/shell/extensions/unite/window-buttons-placement
  * /org/gnome/shell/extensions/unite/window-buttons-theme
  * /org/gnome/shell/extensions/unite/extend-left-box
  * /org/gnome/shell/extensions/unite/use-system-fonts
  * /org/gnome/shell/extensions/clock_override/override-string
  * /org/gnome/shell/extensions/vitals/alphabetize
  * /org/gnome/shell/extensions/vitals/position-in-panel
  * /org/gnome/shell/extensions/vitals/hot-sensors
  * /org/gnome/shell/extensions/vitals/storage-path
  * /org/gnome/shell/extensions/openweather/city
  * /org/gnome/shell/extensions/openweather/days-forecast
  * /org/gnome/shell/extensions/openweather/decimal-places
  * /org/gnome/shell/extensions/openweather/pressure-unit
  * /org/gnome/shell/extensions/openweather/unit
  * /org/gnome/shell/extensions/openweather/wind-speed-unit
  * /org/gnome/shell/extensions/lockkeys/notifications
  * /org/gnome/shell/extensions/applications-overview-tooltip/borders
  * /org/gnome/shell/extensions/dash-to-dock/dock-fixed
  * /org/gnome/shell/extensions/dash-to-dock/extend-height
  * /org/gnome/shell/extensions/dash-to-dock/show-apps-at-top
  * /org/gnome/shell/extensions/dash-to-dock/animate-show-apps
  * /org/gnome/shell/extensions/dash-to-dock/apply-custom-theme
  * /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size
  * /org/gnome/shell/extensions/dash-to-dock/click-action
  * /org/gnome/shell/extensions/dash-to-dock/show-delay
  * /org/gnome/shell/extensions/dash-to-dock/hide-delay
  * /org/gnome/shell/extensions/dash-to-dock/show-trash
  * /org/gnome/shell/extensions/desktop-icons/icon-size
  * /org/gnome/shell/extensions/desktop-icons/show-home
  * /org/gnome/shell/extensions/desktop-icons/show-trash
  * /org/gnome/shell/favorite-apps
  * /org/gnome/desktop/interface/clock-show-date
  * /org/gnome/desktop/interface/clock-show-seconds
  * /org/gnome/desktop/interface/show-battery-percentage
  * /org/gnome/desktop/privacy/remember-app-usage
  * /org/gnome/desktop/privacy/remember-recent-files
  * /org/gnome/desktop/search-providers/disable-external
  * /org/gnome/desktop/wm/preferences/num-workspaces
  * /org/gnome/mutter/dynamic-workspaces
  * /org/gnome/desktop/app-folders/folders/Development
  * /org/gnome/desktop/app-folders/folders/Internet
  * /org/gnome/desktop/app-folders/folders/LibreOffice
  * /org/gnome/desktop/app-folders/folders/Settings
  * /org/gnome/desktop/app-folders/folders/Utilities
  * /org/gnome/desktop/app-folders/folder-children
* Desktop
  * ~/.local/share/applications/htop.desktop
  * ~/.local/share/applications/info.desktop
  * ~/.local/share/applications/openjdk-8-policytool.desktop
  * ~/.local/share/applications/software-properties-drivers.desktop
  * ~/.local/share/applications/software-properties-livepatch.desktop
  * ~/.local/share/applications/yelp.desktop

### GNOME Appearances
* Dconf
  * /org/gnome/shell/extensions/user-theme/name
  * /org/gnome/desktop/interface/icon-theme
  * /org/gnome/desktop/interface/cursor-theme
  * /org/gnome/desktop/interface/gtk-theme
  * /org/gnome/desktop/wm/preferences/theme
  * /org/gnome/desktop/wm/preferences/button-layout
  * /org/gnome/nautilus/window-state/sidebar-width
  * /org/gnome/nautilus/icon-view/default-zoom-level
  * /org/gnome/nautilus/list-view/default-zoom-level
  * /org/gnome/nautilus/list-view/default-column-order
  * /org/gnome/nautilus/list-view/default-visible-columns
  * /org/gnome/nautilus/list-view/use-tree-view
  * /org/gnome/nautilus/preferences/default-folder-viewer
  * /org/gnome/gedit/preferences/editor/bracket-matching
  * /org/gnome/gedit/preferences/editor/highlight-current-line
  * /org/gnome/gedit/preferences/editor/search-highlighting
* Bookmarks
  * ~/.config/gtk-3.0/bookmarks
* Desktop
  * ~/.local/share/applications/org.gnome.Nautilus.desktop
  * ~/.local/share/applications/snap-store_ubuntu-software.desktop

### GNOME Actions
* Dconf
  * /org/gnome/mutter/attach-modal-dialogs
  * /org/gnome/settings-daemon/plugins/power/lid-close-battery-action
  * /org/gnome/settings-daemon/plugins/power/lid-close-ac-action
  * /org/gnome/nautilus/preferences/executable-text-activation
  * /org/gnome/terminal/legacy/menu-accelerator-enabled
* Autostart
  * ~/.config/autostart/ignore-lid-switch-tweak.desktop
* Script
  * ~/.local/share/nautilus/scripts/Comprimir
  * ~/.local/share/nautilus/scripts/Extrair aqui
* Keyboard
  * /etc/profile.d/im-module-cedilla.sh
  * /usr/share/X11/xkb/symbols/br

<br/>

# Screenshots

### Ubuntu GNOME
![Ubuntu GNOME](https://user-images.githubusercontent.com/29760411/79165085-cae9dd00-7db8-11ea-85f7-d10d779292e1.png)