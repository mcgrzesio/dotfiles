#!/bin/bash
while [ "$select" != "BACK" -a "$select" != "LOCK" -a "$select" != "LOGOUT" -a "$select" != "POWEROFF" -a "$select" != "REBOOT" -a "$select" != "SUSPEND" -a "$select" != "HIBERNATE" ]; do
    select=$(echo -e 'BACK\nLOCK\nLOGOUT\nPOWEROFF\nREBOOT\nSUSPEND\nHIBERNATE' |
        dmenu -nb '#151515' -nf '#999999' -sb '#f00060' -sf '#000000' -fn '-*-*-medium-r-normal-*-*-*-*-*-*-100-*-*' -i -p "WHAT DO YOU WANT?")
done

case $select in
    'LOCK')      /home/grzesio/.config/i3/i3lock-fancy-multimonitor/lock ;;
    'LOGOUT')    i3-msg exit ;;
    'POWEROFF')  shutdown -h now ;;
    'REBOOT')    reboot ;;
    'SUSPEND')   /home/grzesio/.config/i3/i3lock-fancy-multimonitor/lock && systemctl suspend ;;
    'HIBERNATE') /home/grzesio/.config/i3/i3lock-fancy-multimonitor/lock && systemctl hibernate ;;
esac
