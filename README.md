# Linux Desktop Script

### Supported Environments
- [Plasma - 5.25](https://kde.org/plasma-desktop/)

### Supported Systems
- [Ubuntu - 20.04 (Base)](https://ubuntu.com/download)

### Supported Architectures
- x86_64 (amd64)

<br/>

# Preparing to Run the Script

### Plasma - Ubuntu
```bash
sudo apt install curl -y
```

<br/>

# Running the Script

### Plasma - Ubuntu
```bash
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/linux-desktop-script/master/plasma-ubuntu.sh | bash
```

<br/>

# Installations and Configurations

### Plasma - Ubuntu
- NVIDIA X Server Settings (Configuration Only)
  - Autostart Scripts
    - ~/.config/autostart-scripts/nvidia-settings.sh
- Wget - Latest (Repository)
- Zip - Latest (Repository)
- Git - Latest (Repository)
- Build Essential - Latest (Repository)
- CMake - Latest (Repository)
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
- Kate - Latest (Repository)
- KColorChooser - Latest (Repository)
- LibreOffice KDE - Latest (Repository)
- Partition Manager - Latest (Repository)
- Seahorse - Latest (Repository)
  - Autostart
    - ~/.config/autostart/gnome-keyring-pkcs11.desktop
    - ~/.config/autostart/gnome-keyring-secrets.desktop
    - ~/.config/autostart/gnome-keyring-ssh.desktop
- Plasma Widgets
  - Applets
    - [Window AppMenu Applet - 1de99c9 (Script)](https://github.com/psifidotos/applet-window-appmenu)
    - [Window Title Applet - efa9e78 (Script)](https://github.com/psifidotos/applet-window-title)
  - Styles
    - /usr/share/plasma/plasmoids/org.kde.plasma.systemmonitor/contents/ui/CompactRepresentation.qml
    - /usr/share/plasma/plasmoids/org.kde.plasma.trash/contents/ui/main.qml
    - ~/.local/share/plasma/plasmoids/org.kde.windowtitle/contents/ui/main.qml