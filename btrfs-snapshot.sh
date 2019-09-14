#!/bin/bash
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
[[ -f $dest ]] && rm "$dest"
[[ ! -e $dest ]] && mkdir -p "$dest"
_num=$(( $(ls "$dest" | wc -l) - 9 ))
mapfile -t snapshot < <(ls -dr "$dest"/* | tail -n $_num)
(( _num > 0 )) && btrfs subvolume delete "${snapshot[@]}"
btrfs subvolume snapshot "$subvol" "$dest/$date"
