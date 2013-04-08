#!/bin/sh

xsetroot -solid grey30
xsetroot -cursor_name left_ptr

x-terminal-emulator -e /usr/local/bin/poclbm-wrapper &
x-terminal-emulator -e 'watch /opt/adl3/atitweak --status' &

exec x-window-manager
