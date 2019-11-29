# Maintainer: Mike Yuan <me@yhndnzj.com>

pkgname=btrfs-snapshot-git
pkgver=git
pkgrel=1
pkgdesc="Tool for creating btrfs snapshots"
arch=('any')
url="https://github.com/YHNdnzj/btrfs-snapshot"
license=('MIT')
depends=('bash' 'btrfs-progs')
makedepends=('git')
provides=('btrfs-snapshot')
conflicts=('btrfs-snapshot')
source=(
    "btrfs-snapshot"
    "functions"
    btrfs-snapshot{,@}.service
    btrfs-snapshot{,@}.timer
    "README.md"
    "LICENSE"
)
sha256sums=('b2e858e6e9a4a941e30cb60483d12c4ae0bccd3fc6d20a853c1e6171ca668ba4'
            'd7976f6a48e73adaed19d647863f371aed2918ded5e40e9138ac35c1262b1be2'
            'a9de67e025de0780d0c635a5cc2236163e456f29bf80d0c5001fefda13903617'
            '6c3eba5c5ea5506d6dba5359d1a440bf0bc475b5a80cb78e12066dbf604a35a7'
            '7ab6bfc0e29d44a1e084157e08c5cb0985c9d3d39102bf2e43743ddbe7546b4b'
            '64047925b416bf6331a9c4209ff4f33da2275b19263799c3d96c6c83f7d01354'
            '003954fefaccae55b36ca3d828decc565d0dad38097e325d9e64b6300040a400'
            '6e227f3c8aecc4e91e406233ea22fc3733e2b39595aded92279858925ed5c1ad')

pkgver() {
    git describe --long | sed -r 's/([^-]*-g)/r\1/;s/-/./g'
}

prepare() {
    sed -e 's|\(^_f_functions\)=.*|\1=/usr/lib/btrfs-snapshot/functions|' \
        -e 's|\(^_d_configs\)=.*|\1=/etc/btrfs-snapshot|' \
        -e "s|%VERSION%|$pkgver|g" \
        -i btrfs-snapshot
}

package() {
    install -Dm755 btrfs-snapshot "$pkgdir/usr/bin/btrfs-snapshot"

    install -Dm644 functions "$pkgdir/usr/lib/btrfs-snapshot/functions"
    install -dm755 "$pkgdir/etc/btrfs-snapshot"

    install -Dt "$pkgdir/usr/lib/systemd/system" -m644 btrfs-snapshot{,@}.{service,timer}

    install -Dm644 README.md "$pkgdir/usr/share/doc/btrfs-snapshot/README.md"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/btrfs-snapshot/LICENSE"
}

# vim: set ts=4 sw=4 et:
