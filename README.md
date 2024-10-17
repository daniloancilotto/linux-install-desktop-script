# Linux Install Desktop Script

### Supported Environments
- [Plasma - 6.2 (Base)](https://kde.org/plasma-desktop/)

### Supported Systems
- [Ubuntu - 24.04 (Base)](https://ubuntu.com/download)

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
curl -H 'Cache-Control: no-cache' -sSL https://raw.githubusercontent.com/daniloancilotto/linux-install-desktop-script/master/plasma-ubuntu.sh | bash
```

<br/>

# Installations and Configurations

### Plasma - Ubuntu
- Crudini - Latest (Repository)
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
- KDE Connect - Latest (Repository)
- LibreOffice Plasma - Latest (Repository)
- Partition Manager - Latest (Repository)
- Seahorse - Latest (Repository)
  - Autostart
    - ~/.config/autostart/gnome-keyring-pkcs11.desktop
    - ~/.config/autostart/gnome-keyring-secrets.desktop
    - ~/.config/autostart/gnome-keyring-ssh.desktop
- Anthy Dictionary Editor (Configuration Only)
  - Menu
    - ~/.local/share/applications/kasumi.desktop
- Discover (Configuration Only)
  - Menu
    - ~/.local/share/applications/org.kde.discover.desktop
- KRdp (Configuration Only)
  - Menu
    - ~/.local/share/applications/org.kde.krdp.desktop
- UserFeedback Console (Configuration Only)
  - Menu
    - ~/.local/share/applications/org.kde.kuserfeedback-console.desktop