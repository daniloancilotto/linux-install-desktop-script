# Desktop Environment Script

### Supported Desktops
* [Cinnamon - 4.0 ~ 4.2](https://github.com/linuxmint/cinnamon)
* [GNOME - 3.30 ~ 3.32](https://www.gnome.org/)

### Install Cinnamon Spices
* Applets - Latest
  * [Num Lock/Caps Lock indicator with notifications](https://cinnamon-spices.linuxmint.com/applets/view/83)
  * [Simple CPU Monitor](https://cinnamon-spices.linuxmint.com/applets/view/8)
  * [Simple Memory Monitor](https://cinnamon-spices.linuxmint.com/applets/view/34)
  * [Weather](https://cinnamon-spices.linuxmint.com/applets/view/17)
* Extensions - Latest
  * [Transparent panels](https://cinnamon-spices.linuxmint.com/extensions/view/42)
* User Configurations
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

### Install Cinnamon Appearances
* Themes
  * [Mojave - 2019-06-23 (Dark)](https://github.com/daniloancilotto/mojave-gtk-theme)
* Icons
  * [Korla - 1.1.6 (Dark)](https://github.com/bikass/korla)
* Cursors
  * [Capitaine Cursors - R3 (Light)](https://github.com/keeferrourke/capitaine-cursors)
* Backgrounds
  * [Wallhaven (Dark)](https://wallhaven.cc/)
* User Configurations
  * Dconf
    * /org/cinnamon/theme/name
    * /org/cinnamon/desktop/interface/gtk-theme
    * /org/cinnamon/desktop/interface/gtk-theme-backup
    * /org/cinnamon/desktop/wm/preferences/theme
    * /org/cinnamon/desktop/wm/preferences/theme-backup
    * /org/cinnamon/desktop/wm/preferences/button-layout
    * /org/nemo/window-state/sidebar-bookmark-breakpoint
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
    * /org/cinnamon/desktop/interface/icon-theme
    * /org/cinnamon/desktop/interface/icon-theme-backup
    * /org/cinnamon/settings-daemon/plugins/xsettings/buttons-have-icons
    * /org/nemo/desktop/computer-icon-visible
    * /org/nemo/desktop/network-icon-visible
    * /org/nemo/desktop/trash-icon-visible
    * /org/nemo/preferences/show-home-icon-toolbar
    * /org/nemo/preferences/show-reload-icon-toolbar
    * /org/nemo/preferences/show-open-in-terminal-toolbar
    * /org/cinnamon/desktop/interface/cursor-theme
    * /org/cinnamon/desktop/background/picture-uri
    * /org/cinnamon/desktop/background/slideshow/image-source
    * /org/cinnamon/desktop/background/slideshow/delay
    * /org/cinnamon/desktop/background/slideshow/random-order
    * /org/cinnamon/desktop/background/slideshow/slideshow-enabled
  * Conf
    * /etc/lightdm/slick-greeter.conf
    * ~/.config/nemo/desktop-metadata
  * List
    * ~/.config/gtk-3.0/bookmarks
    * ~/.cinnamon/backgrounds/user-folders.lst

### Install Cinnamon Actions
* User Configurations
  * Dconf
    * /org/cinnamon/alttab-switcher-enforce-primary-monitor
    * /org/cinnamon/alttab-switcher-show-all-workspaces
    * /org/cinnamon/bring-windows-to-current-workspace
    * /org/cinnamon/desktop/wm/preferences/mouse-button-modifier
    * /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action
    * /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action
    * /org/gnome/nautilus/compression/default-compression-format
    * /org/gnome/nautilus/preferences/executable-text-activation
    * /org/gnome/terminal/legacy/menu-accelerator-enabled

### Install GNOME Spices
* Extensions
  * [Unite - v31](https://extensions.gnome.org/extension/1287/unite/)
  * [Clock Override - v12](https://extensions.gnome.org/extension/1206/clock-override/)
  * [OpenWeather - v97](https://extensions.gnome.org/extension/750/openweather/)
  * [Vitals - v20](https://extensions.gnome.org/extension/1460/vitals/)
  * [Trash - v16](https://extensions.gnome.org/extension/48/trash/)
  * [Removable Drive Menu - v40](https://extensions.gnome.org/extension/7/removable-drive-menu/)
  * [Printers - v9](https://extensions.gnome.org/extension/1218/printers/)
  * [Lock Keys - v28](https://extensions.gnome.org/extension/36/lock-keys/)
  * [Dual Shock 4 battery percentage - v4](https://extensions.gnome.org/extension/1283/dual-shock-4-battery-percentage/)
  * [Tweaks in System Menu - v3](https://extensions.gnome.org/extension/1653/tweaks-in-system-menu/)
  * [Desktop Icons - v14](https://extensions.gnome.org/extension/1465/desktop-icons/)
  * [User Themes - v37](https://extensions.gnome.org/extension/19/user-themes/)
* User Configurations
  * Dconf
    * /org/gnome/shell/enabled-extensions
    * /org/gnome/shell/extensions/unite/extend-left-box
    * /org/gnome/shell/extensions/unite/use-system-fonts
    * /org/gnome/shell/extensions/unite/show-window-title
    * /org/gnome/shell/extensions/unite/window-buttons-theme
    * /org/gnome/shell/extensions/clock_override/override-string
    * /org/gnome/shell/extensions/vitals/alphabetize
    * /org/gnome/shell/extensions/vitals/position-in-panel
    * /org/gnome/shell/extensions/vitals/hot-sensors
    * /org/gnome/shell/extensions/openweather/city
    * /org/gnome/shell/extensions/openweather/days-forecast
    * /org/gnome/shell/extensions/openweather/decimal-places
    * /org/gnome/shell/extensions/openweather/pressure-unit
    * /org/gnome/shell/extensions/openweather/unit
    * /org/gnome/shell/extensions/openweather/wind-speed-unit
    * /org/gnome/shell/extensions/printers/show-icon
    * /org/gnome/shell/favorite-apps

<br/>

# Preparing to Run the Script

## Ubuntu and Derivatives

### Cinnamon
```bash
sudo apt install curl wget unzip tar jq dconf-cli dconf-editor -y
```

### GNOME
```bash
sudo apt install curl wget unzip tar jq dconf-cli dconf-editor gnome-tweaks chrome-gnome-shell -y
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
![Cinnamon](https://user-images.githubusercontent.com/29760411/61247926-6d8d0680-a728-11e9-9026-ba6b457aae82.png)