# btrfs-snapshot

Tool for creating btrfs snapshots

### Installation

`$ aur_helper -S btrfs-snapshot`

### Usage

`# btrfs-snapshot --help`

#### Daily create snapshots

```
$ systemd-escape -p /path/to/subvolume
# systemctl enable --now btrfs-snapshot@escaped-path.timer
```

It keeps 10 snapshots by default. To change it, [edit](https://wiki.archlinux.org/index.php/Systemd#Editing_provided_units) `btrfs-snapshot@.service` and change `--nkeep` option in `ExecStart=`
