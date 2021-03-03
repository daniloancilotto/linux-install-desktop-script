# Linux Desktop Script

### Supported Systems
- [Ubuntu - 20.04 (Base)](https://ubuntu.com/download)

### Supported Architectures
- x86_64 (amd64)

### Supported Environments
- [Plasma - 5.18](https://kde.org/plasma-desktop/)
- [GNOME - 3.36](https://www.gnome.org/)

<br/>

# Preparing to Run the Script

### Ubuntu
```bash
sudo apt install curl -y
```

<br/>

# Running the Script

### Ubuntu - Plasma
```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/linux-desktop-script/master/ubuntu-plasma.sh | bash
```

### Ubuntu - GNOME
```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/linux-desktop-script/master/ubuntu-gnome.sh | bash
```

<br/>

# Installations and Configurations

### Ubuntu - Plasma
- Wget - Latest (Repository)
- Zip - Latest (Repository)
- Elisa - Latest (Repository)
- Kate - Latest (Repository)
- Kvantum Manager - Latest (Repository)
- Latte - Latest (Repository)
- Plasma Widgets
  - Applets
    - [Window AppMenu Applet - d77d038](https://github.com/psifidotos/applet-window-appmenu)
    - [Window Buttons Applet - 16c66e9](https://github.com/psifidotos/applet-window-buttons)
    - [Window Title Applet - c33da19](https://github.com/psifidotos/applet-window-title)

### Ubuntu - GNOME
- Wget - Latest (Repository)
- Zip - Latest (Repository)
- Crudini - Latest (Repository)
- Gtop - Latest (Repository)
- LM Sensors - Latest (Repository)
- X11 Utils - Latest (Repository)
- Qt5 Settings - Latest (Repository)
  - Preferences
    - ~/.config/qt5ct/qt5ct.conf
  - Environment
    - /etc/profile.d/qpa-platformtheme-qt5ct.sh
- Dconf Editor - Latest (Repository)
- GNOME Tweaks - Latest (Repository)
- GNOME Extensions - Latest (Repository)
- GNOME Browser Integration - Latest (Repository)
- GNOME AppGrid
  - Preferences
    - dconf://org/gnome/desktop/privacy/remember-app-usage
    - dconf://org/gnome/desktop/privacy/remember-recent-files
    - dconf://org/gnome/desktop/search-providers/disable-external
    - dconf://org/gnome/desktop/wm/preferences/num-workspaces
    - dconf://org/gnome/mutter/dynamic-workspaces
    - dconf://org/gnome/desktop/app-folders/folder-children
- GNOME Widgets
  - Extensions
    - [Unite - v45](https://extensions.gnome.org/extension/1287/unite/)
    - [Clock Override - v12](https://extensions.gnome.org/extension/1206/clock-override/)
    - [OpenWeather - v105](https://extensions.gnome.org/extension/750/openweather/)
    - [Vitals - v39](https://extensions.gnome.org/extension/1460/vitals/)
    - [Clipboard Indicator - v34](https://extensions.gnome.org/extension/779/clipboard-indicator/)
    - [Sound Input & Output Device Chooser - v34](https://extensions.gnome.org/extension/906/sound-output-device-chooser/)
    - [Bluetooth quick connect - v13](https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/)
    - [Applications Overview Tooltip - v9](https://extensions.gnome.org/extension/1071/applications-overview-tooltip/)
    - [User Themes - v40](https://extensions.gnome.org/extension/19/user-themes/)
    - [Dash to Dock - v69](https://extensions.gnome.org/extension/307/dash-to-dock/)
  - Preferences
    - dconf://org/gnome/shell/extensions/dash-to-dock/show-apps-at-top
    - dconf://org/gnome/shell/extensions/dash-to-dock/animate-show-apps
  - Styles
    - ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/stylesheet.css
- GNOME Appearances
  - Backgrounds
    - /usr/share/backgrounds/mojave_dynamic