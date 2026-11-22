#!/usr/bin/env bash

install_epoch=0

if [ -f /var/log/pacman.log ]; then
    first_date=$(head -n 1 /var/log/pacman.log | grep -o '^[0-9T:+-]*' || true)
    if [ -z "$first_date" ]; then
        first_date=$(head -n 1 /var/log/pacman.log | sed -n 's/^\[\([^]]*\)\].*/\1/p' || true)
    fi
    if [ -n "$first_date" ]; then
        install_epoch=$(date -d "$first_date" +%s 2>/dev/null || echo 0)
    fi
fi

if [ "$install_epoch" -le 0 ]; then
    install_epoch=$(stat -c %W / 2>/dev/null || echo 0)
    if [ "$install_epoch" -le 0 ]; then
        install_epoch=$(stat -c %Y /etc/machine-id 2>/dev/null || echo 0)
    fi
fi

now_epoch=$(date +%s)
diff_seconds=$(( now_epoch - install_epoch ))
if [ "$diff_seconds" -lt 0 ]; then
    diff_seconds=0
fi

days=$(( diff_seconds / 86400 ))

# Mohs Hardness Scale 
minerals=(
    "Talc"
    "Gypsum"
    "Calcite"
    "Fluorite"
    "Apatite"
    "Orthoclase"
    "Quartz"
    "Topaz"
    "Corundum"
    "Diamond"
)
tiers=("V" "IV" "III" "II" "I")

tier_index=$(( days / 7 ))

if [ "$tier_index" -lt 50 ]; then
    m_idx=$(( tier_index / 5 ))
    t_idx=$(( tier_index % 5 ))
    mineral="${minerals[$m_idx]}"
    tier="${tiers[$t_idx]}"
    rank="${mineral} ${tier}"
else
    rank="Diamond I"
fi

if [ "$days" -eq 1 ]; then
    day_str="1 day"
else
    day_str="${days} days"
fi

echo "${rank} [${day_str}]"
