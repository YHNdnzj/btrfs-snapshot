#!/bin/bash
#
# btrfs-snapshot - tool for creating btrfs snapshots
#

usage() {
    cat <<EOF
usage: ${0##*/} [options]

  Options:
   -s, --subvolume <subvolume>      Subvolume for creating snapshots
   -n, --nkeep <number>             Number of snapshots to keep

EOF
}

set_var() {
	_date="$(date -I)"
	if [[ $subvol == / ]]; then
		dest=/snapshot/root
	else
		dest=/snapshot$subvol
	fi
}

create_snap() {
	btrfs subvolume snapshot "$subvol" "$dest"/"$_date"
}

delete_snap() {
	local _n_del=$(( $(ls "$dest" | wc -l) - _n_keep ))
    local _snapshot=()
	mapfile -t _snapshot < <(ls -d "$dest"/* | head -n $_n_del)
	(( _n_del > 0 )) && btrfs subvolume delete "${_snapshot[@]}"
}

while :; do
	case $1 in
		-s|--subvolume)
			shift
			subvol="$1"
			;;
		-n|--nkeep)
			shift
			_n_keep=$1
			;;
        -h|--help)
            usage
            exit 0
            ;;
	esac
	shift
done

set_var
mkdir -p "$dest"
create_snap
delete_snap

# vim: set ft=sh ts=4 sw=4 et:
