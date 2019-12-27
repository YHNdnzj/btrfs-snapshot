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
sha256sums=('53a9b3cb1b4cf63829aa17fb80ee2e7662c48d6806250710a0d616e132120ef1'
            'd7976f6a48e73adaed19d647863f371aed2918ded5e40e9138ac35c1262b1be2'
            'a9de67e025de0780d0c635a5cc2236163e456f29bf80d0c5001fefda13903617'
            '6c3eba5c5ea5506d6dba5359d1a440bf0bc475b5a80cb78e12066dbf604a35a7'
            '7ab6bfc0e29d44a1e084157e08c5cb0985c9d3d39102bf2e43743ddbe7546b4b'
            '64047925b416bf6331a9c4209ff4f33da2275b19263799c3d96c6c83f7d01354'
            'b4d71fd745c3267e7cd797b96098de9b03c48dd50ac5334cdc3298480b4759c9'
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
