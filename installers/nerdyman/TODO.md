# TODO

## General
-   ~~Log output to `$LOG_FILE` where necessary~~
-   ~~Change GFX packages based on demo option~~
-   ~~Add config options to opt out of intel-ucode~~
-   Add config options to specifiy GFX driver (ati|intel|~~nvidia~~)
-   ~~Add config option for Xorg keyboard config~~
-   ~~Add messages from `_log` and `_log_info` to `$LOG_FILE`~~
-   Add oneliner to get the repo, extract it and cd into it
-   Add resume script to execute the last successful function if the install fails
-   ~~Run all scripts through [shellcheck](<https://github.com/koalaman/shellcheck>)~~
-   ~~Split installers into individual files~~

## Base install
-   ~~Setup encrypted LVM~~
-   ~~Install systemd boot with encrypted LVM support~~
-   ~~Set hardware clock~~
-   ~~Copy scripts to container~~
-   ~~Automatically run `install-last.bash` on container login~~
-   ~~Automatically spawn container in background~~
-   ~~Move locale and keyboard setup to install-first script~~

## Install Last
-   Add xinit config for i3-xfce desktop environment
-   Choose Display manager ([SSDM](https://wiki.archlinux.org/index.php/SDDM)?)
-   ~~Install atom packages via APM~~
-   Add global git aliases (lg, pretty diff, etc.)
-   Add `en_US` as secondary locale (for Steam)
-   ~~Nopasswd for sudo users during install~~
-   Enable passwd for sudo users on install complete
-   ~~set xorg keyboard layout (`localectl --no-convert set-x11-keymap cz,us pc104 ,dvorak grp:alt_shift_toggle`)~~
-   Add systemd config for locking box on sleep [example](https://github.com/meskarune/i3lock-fancy#extras)
-   ~~Copy configs in `configs/home` to `${CONFIG_USERNAME}`'s home directory~~
-   Add GPG config for caching SSH keys with timeout
-   Add post install option to run custom scripts on install complete
-   Set defaults
-   -   Set default GTK config
-   -   Set default icon theme
-   -   Set default atom config
-   -   Set rofi theme
-   -   Set [default applications](https://wiki.archlinux.org/index.php/default_applications)
-   [Configure super pretty font rendering](https://gist.github.com/cryzed/e002e7057435f02cc7894b9e748c5671#creating-an-infinality-like-fontconfig-configuration)
-   Add [SFNS font](<https://github.com/supermarin/YosemiteSanFranciscoFont>)
-   [Disable](<https://linux-audit.com/nftables-beginners-guide-to-traffic-filtering/>) `iptables` and `ip6tables` (replaced by `nftables`)
-   Protect single user mode [1](<https://cisofy.com/controls/AUTH-9308/>), [2](<https://cisofy.com/controls/BOOT-5260/>)

## Security
-   Consider adding [Open Snitch](<https://github.com/evilsocket/opensnitch>)
-   Add [gksu](<https://wiki.archlinux.org/index.php/Sudo#gksu>) config
-   Review output of `lynis audit system` and make changes where necessary
-   Ensure systemd config files and directories have the correct permissions (`0664`)

## Virtual Machine
-   Add service to enable `VBoxClient-all` on boot if `$IS_VM` is `true`
-   ~~Add demo virtualbox guest packages so Virtualbox VM works out of the box~~
