#!/bin/bash
cd /tmp || exit 1
wget -O btrfs-snapshot.zip https://github.com/YHNdnzj/btrfs-snapshot/archive/master.zip
unzip btrfs-snapshot.zip
cd btrfs-snapshot-master || exit 1
install -Dm755 btrfs-snapshot.sh /usr/local/bin/btrfs-snapshot
install -Dt /etc/systemd/system -m644 systemd/*
cd ..
rm -rf btrfs-snapshot{.zip,-master}
