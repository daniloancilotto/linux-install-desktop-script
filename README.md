# Linux Desktop Script

### Supported Systems
- [Ubuntu - 20.04 ~ 21.04 (Base)](https://ubuntu.com/download)

### Supported Architectures
- x86_64 (amd64)

### Supported Environments
- [Plasma - 5.18 ~ 5.22](https://kde.org/plasma-desktop/)
- [GNOME - 3.36 ~ 3.38](https://www.gnome.org/)

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
- NVIDIA X Server Settings (Configuration Only)
  - Autostart Scripts
    - ~/.config/autostart-scripts/nvidia-settings.sh
- Wget - Latest (Repository)
- Zip - Latest (Repository)
- G++ - Latest (Repository)
- Make - Latest (Repository)
- Get Text - Latest (Repository)
- X11 Libraries - Latest (Repository)
- Qt5 Libraries - Latest (Repository)
- Plasma Libraries - Latest (Repository)
- Kssh Askpass - Latest (Repository)
  - Autostart Scripts
    - ~/.config/autostart-scripts/ssh-askpass.sh
- AppMenu GTK Modules - Latest (Repository)
- Network File Sharing - Latest (Repository)
- Software & Updates - Latest (Repository)
- Elisa - Latest (Repository)
- Kvantum Manager - Latest (Repository)
- Latte - Latest (Repository)
- LibreOffice KDE - Latest (Repository)
- Partition Manager - Latest (Repository)
- Seahorse - Latest (Repository)
  - Autostart
    - ~/.config/autostart/gnome-keyring-pkcs11.desktop
    - ~/.config/autostart/gnome-keyring-secrets.desktop
    - ~/.config/autostart/gnome-keyring-ssh.desktop
- Plasma Widgets
  - Applets
    - [Window AppMenu Applet - 2e953f8](https://github.com/psifidotos/applet-window-appmenu)
    - [Window Buttons Applet - 9910320](https://github.com/psifidotos/applet-window-buttons)
    - [Window Title Applet - ba2b24b](https://github.com/psifidotos/applet-window-title)
  - Styles
    - /usr/share/plasma/plasmoids/org.kde.plasma.digitalclock/contents/ui/DigitalClock.qml

### Ubuntu - GNOME
- Wget - Latest (Repository)
- Zip - Latest (Repository)
- Crudini - Latest (Repository)
- Gtop - Latest (Repository)
- LM Sensors - Latest (Repository)
- X11 Utils - Latest (Repository)
- Dconf Editor - Latest (Repository)
- GNOME Browser Integration - Latest (Repository)
- GNOME Extensions - Latest (Repository)
- GNOME Tweaks - Latest (Repository)
- Gparted - Latest (Repository)
- LibreOffice GNOME - Latest (Repository)
- Qt5 Settings - Latest (Repository)
  - Preferences
    - ~/.config/qt5ct/qt5ct.conf
  - Environment
    - /etc/profile.d/qpa-platformtheme-qt5ct.sh
- Seahorse - Latest (Repository)
  - Autostart
    - ~/.config/autostart/gnome-keyring-pkcs11.desktop
    - ~/.config/autostart/gnome-keyring-secrets.desktop
    - ~/.config/autostart/gnome-keyring-ssh.desktop
- GNOME Widgets
  - Extensions
    - [Unite - v52](https://extensions.gnome.org/extension/1287/unite/)
    - [Clock Override - v12](https://extensions.gnome.org/extension/1206/clock-override/)
    - [OpenWeather - v105](https://extensions.gnome.org/extension/750/openweather/)
    - [Vitals - v39](https://extensions.gnome.org/extension/1460/vitals/)
    - [Clipboard Indicator - v34](https://extensions.gnome.org/extension/779/clipboard-indicator/)
    - [Sound Input & Output Device Chooser - v38](https://extensions.gnome.org/extension/906/sound-output-device-chooser/)
    - [Bluetooth quick connect - v13](https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/)
    - [Applications Overview Tooltip - v9](https://extensions.gnome.org/extension/1071/applications-overview-tooltip/)
    - [User Themes - v40](https://extensions.gnome.org/extension/19/user-themes/)
    - [Dash to Dock - v69](https://extensions.gnome.org/extension/307/dash-to-dock/)
  - Preferences
    - dconf://org/gnome/shell/extensions/dash-to-dock/show-apps-at-top
    - dconf://org/gnome/shell/extensions/dash-to-dock/animate-show-apps
  - Styles
    - ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/stylesheet.css
- GNOME Desktop
  - Preferences
    - dconf://org/gnome/desktop/privacy/remember-app-usage
    - dconf://org/gnome/desktop/privacy/remember-recent-files
    - dconf://org/gnome/desktop/search-providers/disable-external
    - dconf://org/gnome/desktop/wm/preferences/num-workspaces
    - dconf://org/gnome/mutter/dynamic-workspaces
    - dconf://org/gnome/desktop/app-folders/folder-children
- GNOME Appearances
  - Backgrounds
    - /usr/share/backgrounds/mojave_dynamic