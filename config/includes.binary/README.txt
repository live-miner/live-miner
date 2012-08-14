Bitlive
=======
Sam Morris <sam@robots.org.uk>

Burn this image to a CD, or write it to a USB stick, and when booted a system
will automatically begin mining bitcoins.

Sent bug reports to sam@robots.org.uk. If you are feeling generous, send spare
BTC to `1MjtnhbdVAL21meEBnhHwfMSovN7kYtrH6`.

Requirements
------------

An x86_64 PC with an AMD Radeon HD 5000, 6000 or 7000 series graphics card.

Configuration
-------------

Configuration happens in two places:

 1. Boot parameters
 2. Configuration file (`live/bitlive.conf`)

Values from boot parameters override values from the file, so use them if you
don't want to remaster the CD. If you are booting several systems then use
the boot parameters in combination with network booting.

In order to escape spaces in boot parameters, use octal. For instance:

    bitlive.urls=http://user:pass@host0:port\040http://user:pass@host1:port

See `live/bitlive.conf` for the list of options, and their corresponding boot
parameters.

Bugs
----

None!

TODO
----

Explain network booting.

Automatically run one instance of poclbm for each ATI graphics card in the
system.

Switch distribution to wheezy (`fglrx` has not migrated yet).

Use `aticonfig` to detect whether the Xorg driver should be forced to `fglrx`.

Acknowledgements
----------------

The authors of live-build for making it incredibly easy to build a custom
Debian Live CD.
