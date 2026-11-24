#!/bin/sh

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/i3-updates"
count_file="$cache_dir/count"
stamp_file="$cache_dir/stamp"
lock_file="$cache_dir/lock"
max_age=60

mkdir -p "$cache_dir"

check() {
	updates=$(checkupdates --nocolor 2>/dev/null)
	status=$?

	case $status in
		0) count=$(printf '%s\n' "$updates" | grep -c .) ;;
		2) count=0 ;;
		*) return 1 ;;
	esac

	printf '%s\n' "$count" > "$count_file.tmp" && mv "$count_file.tmp" "$count_file"
}

refresh() {
	exec 9>"$lock_file"
	flock -n 9 || return 0
	touch "$stamp_file"
	check
}

notify() {
	exec 9>"$lock_file"
	flock 9
	touch "$stamp_file"

	if ! check; then
		notify-send -a i3-updates -u normal "Updates" "Check failed, no network?"
		return 1
	fi

	count=$(cat "$count_file")
	if [ "$count" -eq 0 ]; then
		notify-send -a i3-updates -u low "Updates" "System is up to date"
	else
		notify-send -a i3-updates -u normal "Updates" "$count pending"
	fi
}

show() {
	if [ -z "$(find "$stamp_file" -mmin "-$max_age" 2>/dev/null)" ]; then
		setsid "$0" refresh >/dev/null 2>&1 &
	fi
	cat "$count_file" 2>/dev/null || echo 0
}

case "${1:-show}" in
	refresh) refresh ;;
	notify) notify ;;
	show) show ;;
	*) echo "usage: $0 [show|refresh|notify]" >&2; exit 1 ;;
esac
