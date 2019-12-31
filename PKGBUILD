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
sha256sums=('d8bf22afc3a30b501426fd6290f9c18199ad02e4c539ae41cf7b7a79481b8b64'
            'd7976f6a48e73adaed19d647863f371aed2918ded5e40e9138ac35c1262b1be2'
            '0f9676d25d82201a0408d3dddef90bb10452df20efaf28040eff9d8552aecae6'
            '19e9be25dd5bf5e113e6c84a16eb9bb10609e3110bef2b197012684358d11b7b'
            '81bcec46fed123aa677178fe07c88618192e0af2ee92444edf37cf286861426b'
            '6428f09b75a26e645b85ab8b9b388bcc6662a804016c2dc5782983bb233096a9'
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
