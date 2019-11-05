# Desktop Environment Script

### Supported Desktops
* [Cinnamon - 4.0 ~ 4.2](https://github.com/linuxmint/cinnamon)
* [GNOME - 3.32 ~ 3.34](https://www.gnome.org/)

### Supported Systems
* Ubuntu and Derivatives
  * [Ubuntu - 18.04 ~ 19.10](https://ubuntu.com/)
  * [Linux Mint - 19.1 ~ 19.2](https://linuxmint.com/)

<br/>

# Preparing to Run the Script

### Cinnamon - Ubuntu and Derivatives
```bash
sudo apt install curl wget unzip tar jq dconf-cli dconf-editor -y
```

### GNOME - Ubuntu and Derivatives
```bash
sudo apt install curl wget unzip dconf-cli dconf-editor gnome-software-plugin-snap gnome-software-plugin-flatpak gnome-tweaks chrome-gnome-shell x11-utils gir1.2-gtop-2.0 lm-sensors -y
```

<br/>

# Running the Script

### Cinnamon
```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/desktop-environment-script/master/cinnamon.sh | bash
```

### GNOME
```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/desktop-environment-script/master/gnome.sh | bash
```

<br/>

# Screenshots

### Cinnamon
![Linux Mint Cinnamon](https://user-images.githubusercontent.com/29760411/67599877-5ad29680-f747-11e9-859e-9a333afb3fe9.png)

### GNOME
![Ubuntu GNOME](https://user-images.githubusercontent.com/29760411/67599980-8eadbc00-f747-11e9-87dd-6790acd5cb1d.png)

<br/>

# Installations and Configurations

### Cinnamon Spices
* Applets - Latest
  * [Num Lock/Caps Lock indicator with notifications](https://cinnamon-spices.linuxmint.com/applets/view/83)
  * [Simple CPU Monitor](https://cinnamon-spices.linuxmint.com/applets/view/8)
  * [Simple Memory Monitor](https://cinnamon-spices.linuxmint.com/applets/view/34)
  * [Weather](https://cinnamon-spices.linuxmint.com/applets/view/17)
* Extensions - Latest
  * [Transparent panels](https://cinnamon-spices.linuxmint.com/extensions/view/42)
* Dconf
  * /org/cinnamon/next-applet-id
  * /org/cinnamon/next-desklet-id
  * /org/cinnamon/enabled-applets
  * /org/cinnamon/enabled-desklets
  * /org/cinnamon/enabled-extensions
  * /org/cinnamon/favorite-apps
  * /org/cinnamon/panels-enabled
  * /org/cinnamon/panels-height
  * /org/cinnamon/panel-zone-icon-sizes
  * /org/cinnamon/no-adjacent-panel-barriers
  * /org/cinnamon/theme/symbolic-relative-size
  * /org/cinnamon/desktop/interface/clock-show-date
  * /org/cinnamon/desktop/interface/clock-show-seconds
  * /org/cinnamon/desktop/screensaver/date-format
  * /org/cinnamon/desktop/screensaver/time-format
  * /org/cinnamon/desktop/screensaver/use-custom-format
  * /org/cinnamon/desktop/privacy/remember-recent-files
  * /org/gnome/desktop/privacy/remember-recent-files
* Json
  * ~/.cinnamon/configs/menu@cinnamon.org/*.json
  * ~/.cinnamon/configs/calendar@cinnamon.org/*.json
  * ~/.cinnamon/configs/weather@mockturtl/*.json
  * ~/.cinnamon/configs/notifications@cinnamon.org/*.json
  * ~/.cinnamon/configs/sound@cinnamon.org/*.json
  * ~/.cinnamon/configs/power@cinnamon.org/*.json
  * ~/.cinnamon/configs/grouped-window-list@cinnamon.org/*.json
  * ~/.cinnamon/configs/transparent-panels@germanfr/*.json

### Cinnamon Appearances
* Dconf
  * /org/nemo/window-state/sidebar-bookmark-breakpoint
  * /org/cinnamon/desktop/interface/icon-theme
  * /org/cinnamon/desktop/interface/icon-theme-backup
  * /org/cinnamon/settings-daemon/plugins/xsettings/buttons-have-icons
  * /org/nemo/desktop/computer-icon-visible
  * /org/nemo/desktop/home-icon-visible
  * /org/nemo/desktop/network-icon-visible
  * /org/nemo/desktop/trash-icon-visible
  * /org/nemo/preferences/show-home-icon-toolbar
  * /org/nemo/preferences/show-reload-icon-toolbar
  * /org/nemo/preferences/show-open-in-terminal-toolbar
  * /org/cinnamon/desktop/interface/cursor-theme
  * /org/cinnamon/theme/name
  * /org/cinnamon/desktop/interface/gtk-theme
  * /org/cinnamon/desktop/interface/gtk-theme-backup
  * /org/cinnamon/desktop/wm/preferences/theme
  * /org/cinnamon/desktop/wm/preferences/theme-backup
  * /org/cinnamon/desktop/wm/preferences/button-layout
  * /org/nemo/window-state/sidebar-width
  * /org/nemo/icon-view/default-zoom-level
  * /org/nemo/list-view/default-zoom-level
  * /org/nemo/list-view/default-column-order
  * /org/nemo/list-view/default-visible-columns
  * /org/nemo/list-view/search-visible-columns
  * /org/nemo/preferences/date-format
  * /org/nemo/preferences/default-folder-viewer
  * /org/nemo/preferences/show-advanced-permissions
  * /org/nemo/preferences/ignore-view-metadata
  * /org/gnome/nautilus/window-state/sidebar-width
  * /org/gnome/nautilus/icon-view/default-zoom-level
  * /org/gnome/nautilus/list-view/default-zoom-level
  * /org/gnome/nautilus/list-view/default-column-order
  * /org/gnome/nautilus/list-view/default-visible-columns
  * /org/gnome/nautilus/list-view/use-tree-view
  * /org/gnome/nautilus/preferences/default-folder-viewer
  * /org/cinnamon/desktop/interface/text-scaling-factor
* Conf
  * /etc/lightdm/slick-greeter.conf
  * ~/.config/nemo/desktop-metadata
* List
  * ~/.config/gtk-3.0/bookmarks

### Cinnamon Actions
* Dconf
  * /org/cinnamon/alttab-switcher-enforce-primary-monitor
  * /org/cinnamon/alttab-switcher-show-all-workspaces
  * /org/cinnamon/bring-windows-to-current-workspace
  * /org/cinnamon/muffin/attach-modal-dialogs
  * /org/cinnamon/desktop/wm/preferences/mouse-button-modifier
  * /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action
  * /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action
  * /org/gnome/nautilus/compression/default-compression-format
  * /org/gnome/nautilus/preferences/executable-text-activation
  * /org/gnome/terminal/legacy/menu-accelerator-enabled

<hr/>

### GNOME Spices
* Extensions
  * [Unite - v33](https://extensions.gnome.org/extension/1287/unite/)
  * [Clock Override - v12](https://extensions.gnome.org/extension/1206/clock-override/)
  * [OpenWeather - v97](https://extensions.gnome.org/extension/750/openweather/)
  * [Vitals - v24](https://extensions.gnome.org/extension/1460/vitals/)
  * [Printers - v10](https://extensions.gnome.org/extension/1218/printers/)
  * [Lock Keys - v28](https://extensions.gnome.org/extension/36/lock-keys/)
  * [Dual Shock 4 battery percentage - v4](https://extensions.gnome.org/extension/1283/dual-shock-4-battery-percentage/)
  * [Sound Input & Output Device Chooser - v25](https://extensions.gnome.org/extension/906/sound-output-device-chooser/)
  * [Tweaks in System Menu - v8](https://extensions.gnome.org/extension/1653/tweaks-in-system-menu/)
  * [User Themes - v37](https://extensions.gnome.org/extension/19/user-themes/)
* Dconf
  * /org/gnome/shell/enabled-extensions
  * /org/gnome/shell/extensions/unite/extend-left-box
  * /org/gnome/shell/extensions/unite/use-system-fonts
  * /org/gnome/shell/extensions/unite/notifications-position
  * /org/gnome/shell/extensions/unite/window-buttons-theme
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
  * /org/gnome/shell/extensions/printers/show-icon
  * /org/gnome/shell/extensions/lockkeys/notifications
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
  * /org/gnome/desktop/app-folders/folders/*
  * /org/gnome/desktop/app-folders/folder-children
* Desktop
  * /usr/share/applications/info.desktop

### GNOME Appearances
* Dconf
  * /org/gnome/desktop/interface/cursor-theme
  * /org/gnome/desktop/interface/icon-theme
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
* List
  * ~/.config/gtk-3.0/bookmarks

### GNOME Actions
* Dconf
  * /org/gnome/mutter/attach-modal-dialogs
  * /org/gnome/settings-daemon/plugins/power/lid-close-battery-action
  * /org/gnome/settings-daemon/plugins/power/lid-close-ac-action
  * /org/gnome/nautilus/compression/default-compression-format
  * /org/gnome/nautilus/preferences/executable-text-activation
  * /org/gnome/terminal/legacy/menu-accelerator-enabled
* X11
  * /usr/share/X11/xkb/symbols/br