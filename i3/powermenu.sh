#!/usr/bin/env bash

options="Lock\nSuspend\nLogout\nReboot\nShutdown"

selected=$(printf '%b' "$options" | dmenu -i -p "Power:" \
    -fn "Poppins:size=11" \
    -nb "#000000" \
    -nf "#FFFFFF" \
    -sb "#FFFFFF" \
    -sf "#000000")

case "$selected" in
    Lock)
        ~/.config/i3/lock.sh
        ;;
    Suspend)
        systemctl suspend
        ;;
    Logout)
        i3-msg exit
        ;;
    Reboot)
        systemctl reboot
        ;;
    Shutdown)
        systemctl poweroff
        ;;
esac
