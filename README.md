# btrfs-snapshot

Tool for creating btrfs snapshots

### Installation

`$ aur_helper -S btrfs-snapshot`

### Usage

`# btrfs-snapshot --help`

#### Daily create snapshots

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