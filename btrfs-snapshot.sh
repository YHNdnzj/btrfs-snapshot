#!/bin/bash
#
# btrfs-snapshot - tool for creating btrfs snapshots
#

usage() {
    cat <<EOF
usage: ${0##*/} [options]

  Options:
   -s, --subvolume <subvolume>      Subvolume for creating snapshots
   -n, --nkeep <num>                Number of snapshots to be kept

EOF
}

set_var() {
	date="$(date -I)"
	if [[ $subvol == / ]]; then
		dest=/snapshot/root
	elif [[ $subvol ]]; then
		dest=/snapshot$subvol
	else
		echo "No source given, exiting…"
		exit 1
	fi
}

create_dest() {
	[[ -f $dest ]] && rm "$dest"
	[[ ! -e $dest ]] && mkdir -p "$dest"
}

create_snap() {
	btrfs subvolume snapshot "$subvol" "$dest"/"$date"
}

delete_snap() {
	local _num=$(( $(ls "$dest" | wc -l) - nkeep ))
	mapfile -t snapshot < <(ls -d "$dest"/* | head -n $_num)
	(( _num > 0 )) && btrfs subvolume delete "${snapshot[@]}"
}

while :; do
	case $1 in
		-s|--subvolume)
			shift
			subvol="$1"
			;;
		-n|--nkeep)
			shift
			nkeep=$1
			;;
        -h|--help)
            usage
            exit 0
            ;;
	esac
	shift
done

set_var
create_dest
create_snap
delete_snap

# vim: set ft=sh ts=4 sw=4 et:
