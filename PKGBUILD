# Maintainer: Mike Yuan <me@yhndnzj.com>

pkgname=btrfs-snapshot-git
pkgver=git
pkgrel=1
pkgdesc="Tool for creating btrfs snapshots"
arch=('any')
url="https://github.com/YHNdnzj/btrfs-snapshot"
license=('MIT')
optdepends=('systemd: scheduled snapshot creation support')
makedepends=('git')
provides=('btrfs-snapshot')
conflicts=('btrfs-snapshot')
source=(
    "btrfs-snapshot"
    "functions"
    "btrfs-snapshot"{,@}.{service,timer}
    "README.md"
    "LICENSE"
)
sha256sums=('bfc63c15303ab0007456fe6cf2c79396b6bc0ea5d83b865178c075e93776c942'
            'd7976f6a48e73adaed19d647863f371aed2918ded5e40e9138ac35c1262b1be2'
            '0f9676d25d82201a0408d3dddef90bb10452df20efaf28040eff9d8552aecae6'
            'bcb0f61715518e8c00762310df2f41ff9734a047fdc5ddfbfdbc8afc6bdda001'
            '19e9be25dd5bf5e113e6c84a16eb9bb10609e3110bef2b197012684358d11b7b'
            '84f3c5551f4f93fb6559ddcb0284dfb76537fd54a644a9dd86ad6417bc7e6d8c'
            '83e4d8c6f105c6592981d56136e04927e71833c7e447b94894f5bc8450517a91'
            '6e227f3c8aecc4e91e406233ea22fc3733e2b39595aded92279858925ed5c1ad')

pkgver() {
    git describe --long | sed -r 's/([^-]*-g)/r\1/;s/-/./g'
}

package() {
    depends=('btrfs-progs' 'coreutils')

    sed -e 's|\(^_f_functions\)=.*|\1=/usr/lib/btrfs-snapshot/functions|' \
        -e 's|\(^_d_configs\)=.*|\1=/etc/btrfs-snapshot|' \
        -e "s|%VERSION%|$pkgver|g" \
        -i btrfs-snapshot

    install -Dm755 btrfs-snapshot "$pkgdir/usr/bin/btrfs-snapshot"

    install -Dm644 functions "$pkgdir/usr/lib/btrfs-snapshot/functions"
    install -dm755 "$pkgdir/etc/btrfs-snapshot"

    install -Dt "$pkgdir/usr/lib/systemd/system" -m644 btrfs-snapshot{,@}.{service,timer}

    install -Dm644 README.md "$pkgdir/usr/share/doc/btrfs-snapshot/README.md"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/btrfs-snapshot/LICENSE"
}

# vim: set ts=4 sw=4 et:
