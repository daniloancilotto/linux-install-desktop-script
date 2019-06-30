# Desktop Environment Script

### Supported Systems
* [Linux Mint - 19.1](https://linuxmint.com/)
  * Cinnamon - 4.0.10

### Install Applications
* Base - Latest
  * Snap
  * Flatpak
  * Curl
  * Wget
  * Git
  * Unzip
  * Tar
  * Neofetch
  * Htop
* [Angry IP Scanner - 3.5.5 (Dpkg)](https://angryip.org/)
* Dconf Editor - Latest
* [Discord - Latest (Snap)](https://snapcraft.io/discord)
* Dropbox - Latest
* Furius ISO Mount - Latest
* [Google Chrome - Latest (Dpkg)](https://www.google.com/chrome/)
* GParted - Latest
* [OBS Studio - Latest (Flatpak)](https://flathub.org/apps/details/com.obsproject.Studio)
* [Oracle VM VirtualBox - 6.0.8 (Dpkg)](https://www.virtualbox.org/)
* [Oracle VM VirtualBox Extension Pack - 6.0.8](https://www.virtualbox.org/)
* Remmina - Latest
* Remmina Plugin - Latest
  * RDP
  * VNC
* [Spotify - Latest (Snap)](https://snapcraft.io/spotify)
* Steam - Latest

<br/>

# Cinnamon Add-ons

### Install Spices
  * Cinnamon Applets - Latest
    * [Num Lock/Caps Lock indicator with notifications](https://cinnamon-spices.linuxmint.com/applets/view/83)
    * [Simple CPU Monitor](https://cinnamon-spices.linuxmint.com/applets/view/8)
    * [Simple Memory Monitor](https://cinnamon-spices.linuxmint.com/applets/view/34)
    * [Weather](https://cinnamon-spices.linuxmint.com/applets/view/17)
  * Cinnamon Extensions - Latest
    * [Transparent panels](https://cinnamon-spices.linuxmint.com/extensions/view/42)

### Install Themes
  * Cinnamon Skins
    * [Mojave - 2019-06-23 (Dark)](https://github.com/daniloancilotto/Mojave-gtk-theme)
  * Cinnamon Icons
    * [Korla - 1.1.4 (Dark)](https://github.com/bikass/korla)
  * Cinnamon Cursors
    * [Capitaine Cursors - R3 (Light)](https://github.com/keeferrourke/capitaine-cursors)
  * Cinnamon Backgrounds
    * [Wallhaven (Dark)](https://wallhaven.cc/)

### Add Dconf Values
* Cinnamon Panels
  * /org/cinnamon/desktop/interface/clock-show-date
  * /org/cinnamon/desktop/interface/clock-show-seconds
  * /org/cinnamon/desktop/screensaver/date-format
  * /org/cinnamon/desktop/screensaver/time-format
  * /org/cinnamon/desktop/screensaver/use-custom-format
  * /org/cinnamon/favorite-apps
  * /org/cinnamon/panels-enabled
  * /org/cinnamon/panels-height
  * /org/cinnamon/panel-zone-icon-sizes
* Cinnamon Windows
  * /org/cinnamon/alttab-switcher-enforce-primary-monitor
  * /org/cinnamon/alttab-switcher-show-all-workspaces
  * /org/cinnamon/alttab-switcher-style
  * /org/cinnamon/bring-windows-to-current-workspace
  * /org/cinnamon/desktop/wm/preferences/mouse-button-modifier
  * /org/cinnamon/muffin/attach-modal-dialogs
* Cinnamon Plugins
  * /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action
  * /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action
* Cinnamon Spices
  * /org/cinnamon/next-applet-id
  * /org/cinnamon/next-desklet-id
  * /org/cinnamon/enabled-applets
  * /org/cinnamon/enabled-desklets
  * /org/cinnamon/enabled-extensions
* Cinnamon Themes
  * /org/cinnamon/desktop/background/picture-uri
  * /org/cinnamon/desktop/background/slideshow/delay
  * /org/cinnamon/desktop/background/slideshow/image-source
  * /org/cinnamon/desktop/background/slideshow/random-order
  * /org/cinnamon/desktop/background/slideshow/slideshow-enabled
  * /org/cinnamon/desktop/interface/cursor-theme
  * /org/cinnamon/desktop/interface/gtk-theme
  * /org/cinnamon/desktop/interface/gtk-theme-backup
  * /org/cinnamon/desktop/interface/icon-theme
  * /org/cinnamon/desktop/interface/icon-theme-backup
  * /org/cinnamon/desktop/wm/preferences/button-layout
  * /org/cinnamon/desktop/wm/preferences/theme
  * /org/cinnamon/desktop/wm/preferences/theme-backup
  * /org/cinnamon/desktop/wm/preferences/titlebar-font
  * /org/cinnamon/theme/name
  * /org/cinnamon/theme/symbolic-relative-size
  * /org/cinnamon/settings-daemon/plugins/xsettings/buttons-have-icons

<br/>

# Execution Examples
```bash
sudo curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/desktop-environment-script/master/install.sh | bash
```

<br/>

### With Add-ons
> **Caution:**  This script change your panels, windows, plugins and theme configurations.

```bash
sudo curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/desktop-environment-script/master/install.sh | bash -s -- --with-add-ons
```