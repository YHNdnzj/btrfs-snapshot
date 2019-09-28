#!/bin/bash
cd /tmp || exit 1
wget -O btrfs-snapshot.zip https://github.com/YHNdnzj/btrfs-snapshot/archive/master.zip
unzip btrfs-snapshot.zip
cd btrfs-snapshot-master || exit 1
install -Dm755 btrfs-snapshot.sh /usr/local/bin/btrfs-snapshot
install -dm755 /usr/local/lib/btrfs-snapshot
install -Dm644 parseopts /usr/local/lib/btrfs-snapshot/parseopts
sed -e 's|\(^_f_parseopts\)=.*|\1=/usr/local/lib/btrfs-snapshot/parseopts|' \
    < btrfs-snapshot > /usr/local/bin/btrfs-snapshot
install -Dt /etc/systemd/system -m644 systemd/*
cd ..
rm -rf btrfs-snapshot{.zip,-master}

# vim: set ft=sh ts=4 sw=4 et:
