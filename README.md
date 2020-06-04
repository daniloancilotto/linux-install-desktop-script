# Linux Desktop Script

### Supported Environments
* [GNOME Shell - 3.36](https://www.gnome.org/)

### Supported Systems
* [Ubuntu - 20.04](https://ubuntu.com/)

### Supported Architectures
* x86_64 (amd64)

<br/>

# Preparing to Run the Script

### Ubuntu
```bash
sudo apt install curl -y
```

<br/>

# Running the Script

### Ubuntu
```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/linux-desktop-script/master/ubuntu.sh | bash
```

<br/>

# Installations and Configurations

### Ubuntu
* Wget - Latest
* Zip - Latest
* Crudini - Latest
* Gtop - Latest
* LM Sensors - Latest
* X11 Utils - Latest
* Qt5 Settings - Latest
* Dconf Editor - Latest
* GNOME Tweaks - Latest
* GNOME Extensions - Latest
  * Integrations - Latest
    * Google Chrome
    * Mozilla Firefox
* GNOME Spices 
  * Extensions
    * [Unite - v41](https://extensions.gnome.org/extension/1287/unite/)
    * [Clock Override - v12](https://extensions.gnome.org/extension/1206/clock-override/)
    * [OpenWeather - v102](https://extensions.gnome.org/extension/750/openweather/)
    * [Vitals - v33](https://extensions.gnome.org/extension/1460/vitals/)
    * [Caffeine - v35](https://extensions.gnome.org/extension/517/caffeine/)
    * [Clipboard Indicator - v34](https://extensions.gnome.org/extension/779/clipboard-indicator/)
    * [Sound Input & Output Device Chooser - v31](https://extensions.gnome.org/extension/906/sound-output-device-chooser/)
    * [Applications Overview Tooltip - v8](https://extensions.gnome.org/extension/1071/applications-overview-tooltip/)
    * [User Themes - v40](https://extensions.gnome.org/extension/19/user-themes/)
  * Dconf
    * /org/gnome/shell/enabled-extensions
    * /org/gnome/shell/extensions/unite/desktop-name-text
    * /org/gnome/shell/extensions/unite/hide-app-menu-icon
    * /org/gnome/shell/extensions/unite/show-window-title
    * /org/gnome/shell/extensions/unite/notifications-position
    * /org/gnome/shell/extensions/unite/hide-aggregate-menu-arrow
    * /org/gnome/shell/extensions/unite/window-buttons-placement
    * /org/gnome/shell/extensions/unite/window-buttons-theme
    * /org/gnome/shell/extensions/unite/extend-left-box
    * /org/gnome/shell/extensions/unite/use-system-fonts
    * /org/gnome/shell/extensions/clock_override/override-string
    * /org/gnome/shell/extensions/openweather/city
    * /org/gnome/shell/extensions/openweather/days-forecast
    * /org/gnome/shell/extensions/openweather/decimal-places
    * /org/gnome/shell/extensions/openweather/pressure-unit
    * /org/gnome/shell/extensions/openweather/unit
    * /org/gnome/shell/extensions/openweather/wind-speed-unit
    * /org/gnome/shell/extensions/vitals/alphabetize
    * /org/gnome/shell/extensions/vitals/position-in-panel
    * /org/gnome/shell/extensions/vitals/hot-sensors
    * /org/gnome/shell/extensions/vitals/storage-path
    * /org/gnome/shell/extensions/caffeine/enable-fullscreen
    * /org/gnome/shell/extensions/caffeine/show-notifications
    * /org/gnome/shell/extensions/caffeine/restore-state
    * /org/gnome/shell/extensions/clipboard-indicator/enable-keybindings
    * /org/gnome/shell/extensions/clipboard-indicator/cache-only-favorites
    * /org/gnome/shell/extensions/clipboard-indicator/preview-size
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
    * ~/.local/share/applications/info.desktop
    * ~/.local/share/applications/software-properties-drivers.desktop
    * ~/.local/share/applications/software-properties-livepatch.desktop
    * ~/.local/share/applications/yelp.desktop
* GNOME Appearances
  * Dconf
    * /org/gnome/shell/extensions/user-theme/name
    * /org/gnome/desktop/interface/icon-theme
    * /org/gnome/desktop/interface/cursor-theme
    * /org/gnome/desktop/interface/gtk-theme
    * /org/gnome/desktop/wm/preferences/theme
    * /org/gnome/desktop/wm/preferences/button-layout
    * /org/gnome/desktop/background/picture-uri
    * /org/gnome/desktop/screensaver/picture-uri
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
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/visible-name
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-theme-colors
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-theme-transparency
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/bold-is-bright
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/background-color
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/foreground-color
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/palette
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/highlight-colors-set
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/highlight-background-color
    * /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/highlight-foreground-color
  * Desktop
    * ~/.local/share/applications/org.gnome.Nautilus.desktop
  * Wallpapers
    * ~/.local/share/backgrounds/ubuntu-80s-glitch.jpg
  * Bookmarks
    * ~/.hidden
    * ~/.config/gtk-3.0/bookmarks
  * Preferences
    * ~/.config/qt5ct/qt5ct.conf
  * Environment
    * /etc/profile.d/qpa-platformtheme-qt5ct.sh
* GNOME Actions
  * Dconf
    * /org/gnome/mutter/attach-modal-dialogs
    * /org/gnome/settings-daemon/plugins/power/lid-close-battery-action
    * /org/gnome/settings-daemon/plugins/power/lid-close-ac-action
    * /org/gnome/nautilus/preferences/executable-text-activation
    * /org/gnome/terminal/legacy/menu-accelerator-enabled
  * Autostart
    * ~/.config/autostart/ignore-lid-switch-tweak.desktop
  * Scripts
    * ~/.local/share/nautilus/scripts/Comprimir
    * ~/.local/share/nautilus/scripts/Extrair aqui
  * Symbols
    * /usr/share/X11/xkb/symbols/br
  * Environment
    * /etc/profile.d/im-module-cedilla.sh

<br/>

# Screenshots

### Ubuntu
![Ubuntu](https://user-images.githubusercontent.com/29760411/81328940-1e77df80-9074-11ea-97c1-047cfedf93ec.png)
![Ubuntu](https://user-images.githubusercontent.com/29760411/81328943-1e77df80-9074-11ea-827d-959356658b10.png)
![Ubuntu](https://user-images.githubusercontent.com/29760411/81328937-1d46b280-9074-11ea-979e-bed4a8e2db83.png)