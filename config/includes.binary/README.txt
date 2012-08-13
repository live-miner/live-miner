Bitlive
=======
Sam Morris <sam@robots.org.uk>

Boot from this CD and your system will automatically begin mining bitcoins.

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
don't want to remaster the CD.

In order to escape spaces in boot parameters, use octal. For instance:

    bitlive.urls=http://user:pass@host0:port\040http://user:pass@host1:port

Bugs
----

None!

TODO
----

Explain network booting.

Automatically run one instance of poclbm for each ATI graphics card in the
system.

Acknowledgements
----------------

The authors of live-build for making it incredibly easy to build a custom
Debian Live CD.
