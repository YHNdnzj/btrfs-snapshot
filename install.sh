#!/bin/bash
cd /tmp || exit 1
wget -O btrfs-snapshot.zip https://github.com/YHNdnzj/btrfs-snapshot/archive/master.zip
unzip btrfs-snapshot.zip
cd btrfs-snapshot-master || exit 1
sed -e 's|\(^_f_parseopt\)=.*|\1=/usr/local/lib/btrfs-snapshot/parseopt|' \
    < btrfs-snapshot > btrfs-snapshot.sh
install -Dm755 btrfs-snapshot.sh /usr/local/bin/btrfs-snapshot
install -m644 parseopt /usr/lib/btrfs-snapshot/parseopt
install -Dt /etc/systemd/system -m644 systemd/*
cd ..
rm -rf btrfs-snapshot{.zip,-master}

# vim: set ft=sh ts=4 sw=4 et:
