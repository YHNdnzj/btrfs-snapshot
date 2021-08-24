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
)
sha256sums=('SKIP'
            'SKIP'
            'SKIP'
            'SKIP'
            'SKIP'
            'SKIP'
            'SKIP')

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
}

# vim: set ts=4 sw=4 et:
