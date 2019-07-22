# Desktop Environment Script

### Supported Systems
* [Linux Mint - 19.1 ~ 19.2](https://linuxmint.com/)

### Supported Desktops
* [Cinnamon - 4.0 ~ 4.2](https://github.com/linuxmint/cinnamon)

### Supported Architectures
* amd64 (64-bit) - Fully
* i386 (32-bit) - Partially

### Install Apps
* Base Apps - Latest
  * Curl
  * Wget
  * Git
  * Unzip
  * Tar
  * Jq
  * Neofetch
  * Htop
* App Hubs - Latest
  * [Snap](https://snapcraft.io/store)
  * [Flatpak](https://flathub.org/home)
    * Repositories
      * Flathub
* OpenJDK - 8
* [4K Video Downloader - 4.8.0 (Dpkg)](https://www.4kdownload.com/products/product-videodownloader)
* [Angry IP Scanner - 3.5.5 (Dpkg)](https://angryip.org/)
* [CPU-X - 3.2.4 (Portable)](https://github.com/X0rg/CPU-X)
  * User Configurations
    * Desktop
      * ~/.local/share/applications/cpu-x.desktop
* Dconf Tools - Latest
* [Discord - Latest (Snap)](https://snapcraft.io/discord)
* Dropbox - Latest
* [FreeRapid Downloader - 0.9.4 (Portable)](http://wordrider.net/freerapid/)
  * User Configurations
    * Desktop
      * ~/.local/share/applications/freerapiddownloader.desktop
* Furius ISO Mount - Latest
* [Google Chrome - Latest (Dpkg)](https://www.google.com/chrome/)
* GParted - Latest
* [OBS Studio - Latest (Flatpak)](https://flathub.org/apps/details/com.obsproject.Studio)
* [Oracle VM VirtualBox - 6.0.10 (Dpkg)](https://www.virtualbox.org/)
  * Extension Pack - 6.0.10
  * User Groups
    * vboxusers
* Remmina - Latest
  * Plugins - Latest
    * RDP
    * VNC
* [Spotify - Latest (Snap)](https://snapcraft.io/spotify)
* Steam - Latest

### Uninstall Apps
* HexChat
* Thunderbird

### Install Add-ons (Conditional)
* [Cinnamon Spices](https://cinnamon-spices.linuxmint.com/)
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
      * ~/.cinnamon/configs/notifications@cinnamon.org/*.json
      * ~/.cinnamon/configs/weather@mockturtl/*.json
      * ~/.cinnamon/configs/sound@cinnamon.org/*.json
      * ~/.cinnamon/configs/power@cinnamon.org/*.json
      * ~/.cinnamon/configs/calendar@cinnamon.org/*.json
      * ~/.cinnamon/configs/show-desktop@cinnamon.org/*.json
      * ~/.cinnamon/configs/grouped-window-list@cinnamon.org/*.json
      * ~/.cinnamon/configs/transparent-panels@germanfr/*.json
* Cinnamon Themes
  * Windows
    * [Mojave - 2019-06-23 (Dark)](https://github.com/daniloancilotto/mojave-gtk-theme)
  * Icons
    * [Korla - 1.1.5 (Dark)](https://github.com/bikass/korla)
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
      * /org/gnome/nautilus/compression/default-compression-format
      * /org/gnome/nautilus/preferences/default-folder-viewer
      * /org/gnome/nautilus/preferences/executable-text-activation
      * /org/gnome/terminal/legacy/menu-accelerator-enabled
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
* Cinnamon Actions
  * User Configurations
    * Dconf
      * /org/cinnamon/alttab-switcher-enforce-primary-monitor
      * /org/cinnamon/alttab-switcher-show-all-workspaces
      * /org/cinnamon/bring-windows-to-current-workspace
      * /org/cinnamon/muffin/attach-modal-dialogs
      * /org/cinnamon/desktop/wm/preferences/mouse-button-modifier
      * /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action
      * /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action

<br/>

# Execution Examples

```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/desktop-environment-script/master/install.sh | bash
```

<br/>

### With Add-ons
> **Caution:** This script changes your settings of applets, desklets, extensions, icons, cursors, backgrounds, and actions.

```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/desktop-environment-script/master/install.sh | bash -s -- --with-add-ons
```

<br/>

### Only Add-ons
> **Caution:** This script changes your settings of applets, desklets, extensions, icons, cursors, backgrounds, and actions.

```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/desktop-environment-script/master/install.sh | bash -s -- --only-add-ons
```

<br/>

# Screenshots

![Linux Mint 19.1 - Cinnamon](https://user-images.githubusercontent.com/29760411/61247926-6d8d0680-a728-11e9-9026-ba6b457aae82.png)