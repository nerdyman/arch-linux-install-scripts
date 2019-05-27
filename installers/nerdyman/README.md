# Nerdyman Installer

Useful if you're a JavaScript/Web Developer.

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
