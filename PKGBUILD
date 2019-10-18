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
sha256sums=('3b53245c6bf736313e8aa7c2f178f24f769fd60cb00c048bde8f34d1397e714c'
            'd1b60e1ae87db97322594413c157f723b155e0ee600ba194221b6e0455f8bf11'
            '2e74d5c6dedeb3c0f663885cee8df4dc2bbc89b95e163e3ba3bbbd63e5814b0b'
            '81bcec46fed123aa677178fe07c88618192e0af2ee92444edf37cf286861426b'
            '4e7b5fbd26256f1a4c3e436cac7ff9ef06db1e4551aca86947610308eacd0169'
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
