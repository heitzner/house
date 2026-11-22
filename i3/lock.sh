#!/usr/bin/env bash

BG="000000"            
TEXT="ffffffff"          
SUBTEXT="a9b1d6ff"       
RING_IDLE="4c7899ff"     
RING_KEYPRESS="2e9ef4ff" 
RING_WRONG="dc322fff"    
RING_VERIFY="2aa198ff"   
INSIDE="1a1b2688"        

FONT="Poppins"

i3lock \
    --nofork \
    --color="${BG}" \
    --clock \
    --indicator \
    --radius=150 \
    --ring-width=16 \
    --time-str="%I:%M %p" \
    --date-str="%A, %B %d" \
    --time-font="${FONT}" \
    --date-font="${FONT}" \
    --verif-font="${FONT}" \
    --wrong-font="${FONT}" \
    --time-size=32 \
    --date-size=14 \
    --time-color="${TEXT}" \
    --date-color="${SUBTEXT}" \
    --inside-color="${INSIDE}" \
    --ring-color="${RING_IDLE}" \
    --keyhl-color="${RING_KEYPRESS}" \
    --bshl-color="${RING_WRONG}" \
    --separator-color="00000000" \
    --insidever-color="${INSIDE}" \
    --ringver-color="${RING_VERIFY}" \
    --verif-color="${TEXT}" \
    --verif-text="Verifying..." \
    --insidewrong-color="${INSIDE}" \
    --ringwrong-color="${RING_WRONG}" \
    --wrong-color="${TEXT}" \
    --wrong-text="Incorrect" \
    --noinput-text="" \
    --line-uses-inside
