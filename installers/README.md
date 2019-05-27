# Installers

Installers provide a (mostly) automated way of installing a fully functional system.

## Workflow

(**\***) Requires user input

0.  Edit `config.bash` to suit your needs
0.  Run `bash <installer-directory>/install.bash`
0.  `install-first.bash` will be executed
    -   Enter your disk encryption password **\***
    -   Enter your root password **\***
    -   Enter your superuser password **\***
0.  Systemd container will be launched for newly installed system
0.  `install-last.bash` will run within container to fully configure system
0.  Partitions will be unmounted
0.  Done! - reboot

## Scripts

| Script                | Purpose                            | Comments                            |
|-----------------------|------------------------------------|-------------------------------------|
| `bootstrap.bash`      | Install dependencies for installer |                                     |
| `install-first.bash`  | Configure and install base system  | Uses `arch-chroot` to do basic configuration |
| `install-last.bash`   | Configure everything needed for a full functional system | Runs from within an installed system |
| `install.bash`        | Wrapper script to run `install-first.bash` and `install-last.bash` | Uses systemd container to run `install-last.bash` |
