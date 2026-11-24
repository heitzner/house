#!/bin/sh

updater="$HOME/.config/i3/updates.sh"

while IFS= read -r line; do
	case $line in
		\[*\]|,\[*\])
			count=$("$updater" show 2>/dev/null)
			case $count in
				''|*[!0-9]*) count=0 ;;
			esac
			if [ "$count" -eq 0 ]; then
				color="#555555"
			else
				color="#9A6700"
			fi
			if [ "${line#,}" != "$line" ]; then
				prefix=",["
				rest="${line#,\[}"
			else
				prefix="["
				rest="${line#\[}"
			fi
			block="{\"full_text\":\"Package Delivery: $count\",\"color\":\"$color\",\"name\":\"updates\"}"
			if [ "$rest" = "]" ]; then
				printf '%s%s]\n' "$prefix" "$block"
			else
				printf '%s%s,%s\n' "$prefix" "$block" "$rest"
			fi
			;;
		*)
			printf '%s\n' "$line"
			;;
	esac
done
