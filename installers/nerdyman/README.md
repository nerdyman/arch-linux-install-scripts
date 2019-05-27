# Nerdyman Installer

Useful if you're a JavaScript/Web Developer.

## What you get

### Packages

Unofficial packages have links.

| Software category  	| Software used |
| --- | --- |
| Admin tools			| htop, nftables, [vtop](<https://github.com/MrRio/vtop>)
| AUR package manager	| [pacaur](<https://aur.archlinux.org/packages/pacaur/>) |
| Boot manager			| systemd-boot |
| Browser				| chromium ([pepper-flash](<https://aur.archlinux.org/packages/pepper-flash/>)), firefox |
| Desktop Environment	| budgie-desktop, [i3-gaps](<https://aur.archlinux.org/packages/i3-gaps/>) |
| Desktop apps			| arandr, deluge, file-roller, eog, galculator, gimp, inkscape, lxappearance, [pulseeffects](<https://aur.archlinux.org/packages/pulseeffects/>), xfce4-screenshooter |
| Dev tools				| atom (see `$PACKAGE_APM` for packages), ffmpeg, gnome-boxes, imagemagick, libvirt, mysql-workbench, python-pip, [robomongo-bin](<https://aur.archlinux.org/packages/robomongo-bin/>), vagrant, vim, virtualbox, yarn |
| Dev languages			| nodejs, python, python2 |
| Display manager  		| TBD |
| File manager			| thunar (thunar-archive-plugin, thunar-media-tags-plugin, thunar-volman) |
| Gaming				| steam |
| Kernel				| linux, linux-hardened |
| Lock screen			| TBD |
| Multimedia			| [cava](<https://aur.archlinux.org/packages/cava/>), parole, quodlibet, vlc |
| Security				| arch-audit, checksec, clamav, firewalld, lynis |
| Shell					| zsh ([oh-my-zsh-git](https://aur.archlinux.org/packages/oh-my-zsh-git/) w/ [archlinux](<https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/archlinux>), [colored-man-pages](<https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/colored-man-pages>), [emoji](<https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/emoji>), zsh-syntax-highlighting) |
| Terminal emulator		| termite, xterm |
| Themes				| arc-gtk-theme, [arc-icon-theme-git](<https://aur.archlinux.org/packages/arc-icon-theme-git/>),  [moka-icon-theme-git](<https://aur.archlinux.org/packages/moka-icon-theme-git/>) |

## Hardening
-   `-` [Automatic Logout](<https://wiki.archlinux.org/index.php/security#Custom_hardening_flagsAutomatic_logout>) - need to fix termite exiting (automatic logout should only apply to tty)
-   [Boot partition mount restrictions](<https://wiki.archlinux.org/index.php/security#Mount_options>)
-   [DNSCrypt](<https://wiki.archlinux.org/index.php/DNSCrypt>)
-   `✔` [Hosts file](<https://github.com/StevenBlack/hosts>)
-   `✔` [File access permissions](<https://wiki.archlinux.org/index.php/security#File_access_permissions>)
-   `✔` Linux Hardened kernel
-   `✔` [TCP/IP Hardening](<https://wiki.archlinux.org/index.php/Sysctl#TCP.2FIP_stack_hardening>)
-   `✔` [linux-hardened](<https://www.archlinux.org/packages/community/x86_64/linux-hardened/>)
-   `✔` [nftables](<https://wiki.archlinux.org/index.php/nftables>)
-   `✔` Set `077` as default umask in `/etc/profile`
-   `✔` SSH - Key based login
-   `✔` SSH - Disable root login
-   `✔` SSH - Disable service by default

## Requirements

This script will only work if you have the following:
-   UEFI motherboard

## Assumptions
The scripts make a few assumptions about your system. These assumptions shouldn't break anything but may need to be changed depending on your system.

The scripts assumes the following:
-   The installation target (`$DISK_TARGET`) is an SSD, if not find and remove any mention `discards` in the scripts
