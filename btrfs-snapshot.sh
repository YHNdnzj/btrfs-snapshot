#!/bin/bash
#
# btrfs-snapshot - tool for creating btrfs snapshots
#

_f_parseopts=parseopts
_i_date=$(date -I)

usage() {
    cat <<EOF
usage: ${0##*/} [options]

  Options:
   -s, --subvolume <subvolume>      Subvolume for creating snapshots
   -n, --nkeep <number>             Number of snapshots to keep

EOF
}

set_dest() {
    if [[ $subvol == / ]]; then
        dest=/snapshot/root
    else
        dest=/snapshot$subvol
    fi
}

delete_snap() {
    local _i_ndel=$(( $(ls "$dest" | wc -l) - _i_nkeep ))
    local _d_snapshot=()
    mapfile -t _d_snapshot < <(ls -d "$dest"/* | head -n $_i_ndel)
    (( _i_ndel > 0 )) && btrfs subvolume delete "${_d_snapshot[@]}"
}

. "$_f_parseopts"

_opt_short='s:n:h'
_opt_long=('subvolume:' 'nkeep:' 'help')

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
            _i_nkeep=$1
            ;;
        -h|--help)
            usage
            exit 0
            ;;
    esac
    shift
done

set_dest
mkdir -p "$dest"
btrfs subvolume snapshot "$subvol" "$dest/$_i_date"
[[ $_i_nkeep ]] && delete_snap

# vim: set ft=sh ts=4 sw=4 et:
