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
subvol=/
dest=/.snapshot/root
nkeep=10
```

##### Enable systemd timer

`# systemctl enable --now btrfs-snapshot`