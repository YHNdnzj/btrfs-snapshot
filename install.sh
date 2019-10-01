#!/bin/bash
cd /tmp || exit 1
wget -O btrfs-snapshot.zip https://github.com/YHNdnzj/btrfs-snapshot/archive/master.zip
unzip btrfs-snapshot.zip
cd btrfs-snapshot-master || exit 1
install -dm755 /usr/local/lib/btrfs-snapshot
sed -e 's|\(^_f_parseopts\)=.*|\1=/usr/local/lib/btrfs-snapshot/parseopts|' \
    < btrfs-snapshot.sh > /usr/local/bin/btrfs-snapshot
chmod 755 /usr/local/bin/btrfs-snapshot
install -Dm644 parseopts /usr/local/lib/btrfs-snapshot/parseopts
install -Dt /etc/systemd/system -m644 systemd/*
cd ..
rm -rf btrfs-snapshot{.zip,-master}

# vim: set ft=sh ts=4 sw=4 et:
