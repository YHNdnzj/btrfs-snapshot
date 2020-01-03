# btrfs-snapshot

Tool for creating btrfs snapshots

### Installation

`$ aur_helper -S btrfs-snapshot`

### Usage

`# btrfs-snapshot --help`

#### Scheduled snapshot creation

##### Configuration example

```bash
/etc/btrfs-snapshot/root.conf

# vim:set ft=sh
SUBVOL=/
DEST=/.snapshot/root
NKEEP=10
```

##### Enable systemd timer

`# systemctl enable --now btrfs-snapshot.timer`

Or

`# systemctl enable --now btrfs-snapshot@root.timer`

*OnCalendar* is set to *daily* by default. [Edit](https://wiki.archlinux.org/index.php/Systemd#Editing_provided_units) the corresponding systemd timer if necessary.