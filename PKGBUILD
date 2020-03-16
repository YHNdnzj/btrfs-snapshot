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
            '85ffd39367ea53f9626ffdef0bc27a8c52986f6d50c23401546ddb35e1c510e6'
            '19e9be25dd5bf5e113e6c84a16eb9bb10609e3110bef2b197012684358d11b7b'
            'fe7447cfffd49d20145f4140ccf166a14e1f587ebceb7404ce84f7a32e6862ae'
            '41c6a3183753e423fd056379b1f197816ee65f412abea4741742016fe724b587'
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
