# Linux Desktop Script

### Supported Environments
- [Plasma - 5.27](https://kde.org/plasma-desktop/)

### Supported Systems
- [Ubuntu - 22.04 (Base)](https://ubuntu.com/download)

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
- Crudini - Latest (Repository)
- Build Essential - Latest (Repository)
- CMake - Latest (Repository)
- Kssh Askpass - Latest (Repository)
  - Autostart Scripts
    - ~/.config/autostart-scripts/ssh-askpass.sh
- AppMenu GTK Modules - Latest (Repository)
- Network File Sharing - Latest (Repository)
- Software & Updates - Latest (Repository)
  - Menu
    - ~/.local/share/applications/software-properties-qt.desktop
- Kate - Latest (Repository)
- KColorChooser - Latest (Repository)
- LibreOffice KDE - Latest (Repository)
- Partition Manager - Latest (Repository)
- Seahorse - Latest (Repository)
  - Autostart
    - ~/.config/autostart/gnome-keyring-pkcs11.desktop
    - ~/.config/autostart/gnome-keyring-secrets.desktop
    - ~/.config/autostart/gnome-keyring-ssh.desktop