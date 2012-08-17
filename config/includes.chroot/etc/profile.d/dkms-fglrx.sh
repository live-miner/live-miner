# fglrx.ko can not be redistributed, so it is not included in the image.
# Instead, build it now.
if [[ -z "${DISPLAY}" && $(tty) = /dev/tty1 ]]; then
	sudo dpkg-reconfigure fglrx-modules-dkms

	# If the above compilation fails, Xorg will exit, only to be restarted again
	# and again by live-config. Break this loop by removing live-config's xorg
	# configuration file; this will enable driver auto-detection and should result
	# in the vesa module being used.
	if [[ -z $(find /lib/modules/$(uname -r) -name fglrx.ko) ]]; then
		sudo rm -f /etc/X11/xorg.conf.d/99-live.conf
	fi
fi

# vim: ft=sh
