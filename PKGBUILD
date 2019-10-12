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
    "parseopts"
    "btrfs-snapshot.service"
    "btrfs-snapshot.timer"
    "README.md"
    "LICENSE"
)
sha256sums=('6dcb277efcbe07d0e27b7331edb5c83106b3233f88bdeeb9b21ada408d595a2d'
            'd1b60e1ae87db97322594413c157f723b155e0ee600ba194221b6e0455f8bf11'
            '7cba0bb674abe71a79c0750a984110465d590cb42c07ba613c0f8674e679dc9d'
            '81bcec46fed123aa677178fe07c88618192e0af2ee92444edf37cf286861426b'
            '2b53ba7a2b208596907f4f32e31e0c089a5ba8716947064d36e795584faeded4'
            '6e227f3c8aecc4e91e406233ea22fc3733e2b39595aded92279858925ed5c1ad')

pkgver() {
    git describe --long | sed -r 's/([^-]*-g)/r\1/;s/-/./g'
}

package() {
    sed "s|\(^_f_parseopts\)=.*|\1=/usr/lib/btrfs-snapshot-po|
         s|\(^_d_config\)=.*|\1=/etc/btrfs-snapshot|
         s|%VERSION%|$pkgver|g" \
        btrfs-snapshot | install -Dm755 /dev/stdin \
        "$pkgdir/usr/bin/btrfs-snapshot"

    install -Dm644 parseopts "$pkgdir/usr/lib/btrfs-snapshot-po"
    install -dm755 "$pkgdir/etc/btrfs-snapshot"

    install -Dt "$pkgdir/usr/lib/systemd/system" -m644 btrfs-snapshot.{service,timer}

    install -Dm644 README.md "$pkgdir/usr/share/doc/btrfs-snapshot/README.md"
    install -Dm644 LICENSE "$pkgdir/usr/share/licenses/btrfs-snapshot/LICENSE"

    chmod -Rc u=rwX,go=rX "$pkgdir"
}

# vim: set ts=4 sw=4 et:
