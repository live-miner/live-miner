#!/bin/sh

xsetroot -solid grey30
xsetroot -cursor_name left_ptr

x-terminal-emulator -e /usr/local/bin/poclbm-wrapper &
x-terminal-emulator -e 'sh -c "watch /opt/adl3/atitweak --status"' &

. /etc/X11/xinit/xinitrc
