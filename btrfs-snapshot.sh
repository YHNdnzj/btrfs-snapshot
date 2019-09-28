#!/bin/bash
num=10

set_var () {
	subvol="$1"
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

create_dest () {
	[[ -f $dest ]] && rm "$dest"
	[[ ! -e $dest ]] && mkdir -p "$dest"
}

create_snap () {
	btrfs subvolume snapshot "$subvol" "$dest"/"$date"
}

delete_snap () {
	local _num=$(( $(ls "$dest" | wc -l) - num ))
	mapfile -t snapshot < <(ls -d "$dest"/* | head -n $_num)
	(( _num > 0 )) && btrfs subvolume delete "${snapshot[@]}"
}

set_var "$@"
create_dest
create_snap
delete_snap
