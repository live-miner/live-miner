GETROOT := sudo
XSETTINGS_DEB := xsettingsd_0.0.20090828-1_amd64.deb

.PHONY: binary
binary: config/packages.chroot/$(XSETTINGS_DEB)
	$(GETROOT) lb clean
	lb config
	time -p $(GETROOT) lb build

config/packages.chroot/$(XSETTINGS_DEB):
	cd external/xsettingsd && dpkg-buildpackage -us -uc -b
	cp external/$(XSETTINGS_DEB) $@
