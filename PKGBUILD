# Maintainer: Mike Yuan <me@yhndnzj.com>

pkgname=btrfs-snapshot-git
pkgver=2.0.0.r11.g9a599db
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
    "btrfs-snapshot@.service"
    "btrfs-snapshot@.timer"
    "README.md"
    "LICENSE"
)
sha256sums=('19e7f335ba4a31b4914d05319fee2e113def581424056b5085623ec3bf3cf9c5'
            'd1b60e1ae87db97322594413c157f723b155e0ee600ba194221b6e0455f8bf11'
            '9d5509431316daff56b339c6342a0df4d86ada7d189a296d0402303b5681a48d'
            'c890846321841900b7e406058271ee81497edac1bd3e26b994dcae346c2b0139'
            '2b53ba7a2b208596907f4f32e31e0c089a5ba8716947064d36e795584faeded4'
            '6e227f3c8aecc4e91e406233ea22fc3733e2b39595aded92279858925ed5c1ad')

pkgver() {
    git describe --long | sed -r 's/([^-]*-g)/r\1/;s/-/./g'
}

package() {
    sed -e 's|\(^_f_parseopts\)=.*|\1=/usr/lib/btrfs-snapshot-po|' \
        -e 's|\(^_d_config\)=.*|\1=/etc/btrfs-snapshot|' \
        -e "s|VERSION|${pkgver}|g" \
        -i btrfs-snapshot

    install -dm755 "${pkgdir}"/etc/btrfs-snapshot
    install -Dm755 btrfs-snapshot "${pkgdir}"/usr/bin/btrfs-snapshot
    install -Dm644 parseopts "${pkgdir}"/usr/lib/btrfs-snapshot-po

    install -Dt "${pkgdir}"/usr/lib/systemd/system -m644 systemd/btrfs-snapshot@.{service,timer}

    install -Dm644 README.md "${pkgdir}"/usr/share/doc/btrfs-snapshot/README.md
    install -Dm644 LICENSE "${pkgdir}"/usr/share/licenses/btrfs-snapshot/LICENSE
}

# vim: set ts=4 sw=4 et:
