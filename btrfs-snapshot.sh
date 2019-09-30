#!/bin/bash
#
# btrfs-snapshot - tool for creating btrfs snapshots
#

_f_parseopts=parseopts

usage() {
    cat <<EOF
usage: ${0##*/} [options]

  Options:
   -s, --subvolume <subvolume>      Subvolume for creating snapshot
   -r, --readonly                   Create a readonly snapshot
   -n, --nkeep <number>             Limit number of snapshots to keep
   -p, --prefix <prefix>            Prefix of snapshot dir (default: /snapshot)
   -h, --help                       Display this message and exit

EOF
}

set_var() {
    prefix=/snapshot
    _date=$(date -I)
}

set_dest() {
    if [[ $subvol = / ]]; then
        dest=$prefix/root
    elif [[ $subvol ]]; then
        dest=$prefix/$subvol
    else
        echo "Invalid command -- subvolume must be set"
        exit 1
    fi
    mkdir -p "$dest"
}

create_snap() {
    if [[ $ro = true ]]; then
        btrfs subvolume snapshot -r "$subvol" "$dest/$_date"
    else
        btrfs subvolume snapshot "$subvol" "$dest/$_date"
    fi
}

delete_snap() {
    local _ndel=$(( $(ls "$dest" | wc -l) - nkeep ))
    (( _ndel > 0 )) && {
        local _snapshot=()
        mapfile -t _snapshot < <(ls -d "$dest"/* | head -n $_ndel)
        btrfs subvolume delete "${_snapshot[@]}"
    }
}

. "$_f_parseopts"

_opt_short='s:rn:p:h'
_opt_long=('subvolume:' 'readonly' 'nkeep:' 'prefix:' 'help')

parseopts "$_opt_short" "${_opt_long[@]}" -- "$@" || exit 1
set -- "${OPTRET[@]}"
unset _opt_short _opt_long OPTRET

set_var

while :; do
    case $1 in
        -s|--subvolume)
            shift
            subvol=$1
            ;;
        -r|--readonly)
            ro=true
            ;;
        -n|--nkeep)
            shift
            nkeep=$1
            ;;
        -p|--prefix)
            shift
            prefix=$1
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        --)
            shift
            break 2
            ;;
    esac
    shift
done

set_dest
create_snap
[[ $nkeep ]] && delete_snap

# vim: set ft=sh ts=4 sw=4 et:
