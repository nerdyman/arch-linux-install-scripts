# Arch Linux Install Scripts (ALIS)

An opinionated set of scripts to ease the installation and configuration of Arch Linux.

## Download

```
curl -L https://codeload.github.com/nerdyman/arch-linux-install-scripts/tar.gz/master | tar xz
```

## Why?

Arch is awesome&hellip; but it's a hassle to set-up, especially when you have a specific
set-up in mind.

This project provides modular scripts to ease in the installation process.

## Structure

-   `scripts` - Individual scripts
-   `installers` - *Mostly* automated sequence of `scripts` to provide a functioning system
-   `configs` - Static configuration files

### Scripts
-   `scripts/development` - Scripts to install software development environments and tools
-   `scripts/helpers` - Utility scripts which don't make any persistent changes or only return data
-   `scripts/meta` - Scripts that manage packages in groups
-   `scripts/security` - Scripts for things related to security
-   `scripts/core` - Scripts which are used to install a base system (systemd-boot, partitioning etc.)
-   `scripts/ui` - Scripts for anything UI releated (GTK+, qt, etc.)

### Installers

Installers use scripts from the `scripts/` directory and settings from `installers/config.bash` to automate the install procedure.

### Static Configs

All **static** configs are located in `configs/`. Configs which require dynamic settings are located in the `scripts` folder.

Config directories:

-   `configs/etc` - targets `/etc` on installed system

## Configuration

Simply change the settings in `config.bash` and `configs/*` to suit your needs and the scripts will take care of the rest.

### Running in a Virtual Machine

The installers can automatically determine if you're running in a VirtualBox virtual machine and will install appropriate packages where necessary.

You can force this option by setting `CONFIG_IS_VM` to `true` or `false` in `installers/config.bash`.

## TODO

-   Error handling
    -   Retry scripts
    -   Retry last failed script in installer
    -   Skip last failed script in installer

## Thanks

The scripts are heavily influenced by [helmuthdu's](<https://github.com/helmuthdu>) [Arch Ultimate Install](<https://github.com/helmuthdu/aui>) and Altercation's [Bullet Proof Arch Install](<https://wiki.archlinux.org/index.php/User:Altercation/Bullet_Proof_Arch_Install>).

They also use some bit and pieces from the Urbanslug's [dm-crypt, luks, systemd-boot and UEFI on Archlinux](<https://blog.urbanslug.com/posts/2016-09-11-dm-crypt-systemd-boot-and-efi-on-archlinux.html>).
