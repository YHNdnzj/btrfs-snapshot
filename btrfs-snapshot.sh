#!/bin/bash
#
# btrfs-snapshot - tool for creating btrfs snapshots
#

_f_parseopts=parseopts

usage() {
    cat <<EOF
usage: ${0##*/} [options]

  Options:
   -s, --subvolume <subvolume>      Subvolume for creating snapshots
   -p, --prefix <prefix>            Prefix of snapshot dir (default: /snapshot)
   -n, --nkeep <number>             Number of snapshots to keep

EOF
}

set_var() {
    prefix=/snapshot
    _date=$(date -I)
}

set_dest() {
    if [[ $subvol == / ]]; then
        dest=$prefix/root
    else
        dest=$prefix/$subvol
    fi
}

delete_snap() {
    local _ndel=$(( $(ls "$dest" | wc -l) - nkeep ))
    local _snapshot=()
    mapfile -t _snapshot < <(ls -d "$dest"/* | head -n $_ndel)
    (( _ndel > 0 )) && btrfs subvolume delete "${_snapshot[@]}"
}

. "$_f_parseopts"

_opt_short='s:n:p:h'
_opt_long=('subvolume:' 'nkeep:' 'prefix:' 'help')

parseopts "$_opt_short" "${_opt_long[@]}" -- "$@" || exit 1
set -- "${OPTRET[@]}"
unset _opt_short _opt_long OPTRET

while :; do
    case $1 in
        -s|--subvolume)
            shift
            subvol=$1
            ;;
        -n|--nkeep)
            shift
            nkeep=$1
            ;;
        -p|--prefix)
            shift
            prefix=$1
            ;;
        -h|--help|--)
            usage
            exit 0
            ;;
    esac
    shift
done

set_var
set_dest
mkdir -p "$dest"
btrfs subvolume snapshot "$subvol" "$dest/$_date"
[[ $nkeep ]] && delete_snap

# vim: set ft=sh ts=4 sw=4 et:
