live-miner
==========
Sam Morris <sam@robots.org.uk>

Burn this image to a CD, or write it to a USB stick, and when booted a system
will automatically begin mining bitcoins by using
https://github.com/m0mchil/poclbm[poclbm].

You can find the latest version at http://live-miner.github.com/. If something
doesn't work, https://github.com/live-miner/live-miner/issues[file a bug] or
mailto:sam@robots.org.uk[send me an email].  If you are feeling generous, send
spare BTC to `1MjtnhbdVAL21meEBnhHwfMSovN7kYtrH6`.

Requirements
------------

An x86_64 PC with an AMD Radeon HD 5000, 6000 or 7000 series graphics card.

Configuration
-------------

Configuration happens in two places:

 1. Boot parameters
 2. Configuration file (`live/live-miner.conf`)

See `live/live-miner.conf` for the list of options and their corresponding boot
parameters. In order to escape spaces in boot parameters, use octal. For
instance:

----
live-miner.urls=http://user:pass@host0:port\040http://user:pass@host1:port
----

Values from boot parameters override values from the file. Which ones you use
depend on how you are going to boot:

USB stick
~~~~~~~~~

Write `binary.hybrid.iso` to your USB stick. On Linux, you can do something
like this:

----
dd if=binary.hybrid.iso of=/dev/sdX
----

This will erase anything already on the device, so make sure you aren't
accidentally overwriting your hard disk! On Windows you can use a program such
as https://launchpad.net/win32-image-writer[Image Writer for Windows].

Once the image is written, remove and re-insert the USB stick, which should now
contain the live-miner files. Once you edit `live/live-miner.conf`, you can
boot from the USB stick and your computer should begin mining.

CD/DVD
~~~~~~

When you boot from the CD, you'll be presented with a menu. Press the Tab key
and then append boot parameters to the line that appears. Press Enter to boot.

If you will be rebooting often, or have several computers to configure, you
should remaster the CD with an edited `live/live-miner.conf` file to save
yourself from having to type out the parameters manually; or you can boot from
the network.

Network
~~~~~~~

The netboot archive contains two directories: `debian-live`, the contents of
which should be shared over NFS; and `tftpboot`, the contents of which should
be available via TFTP. Setting this up required some co-ordination between your
DHCP, TFTP and NFS servers. I use the same machine running Debian for all
three, on `10.0.0.1`. My setup is something like the following:

Install `isc-dhcp-server` and put the following in `/etc/dhcp/dhcpd.conf`:

----
subnet 10.0.0.0 netmask 255.255.0.0 {
    range 10.0.1.1 10.0.1.254;
    option routers 10.0.0.1;
    option domain-name-servers 10.0.0.1;
    filename "pxelinux.0";
    next-server 10.0.0.1;
}
----

Install `tftpd-hdpa` and move the contents of `tftpboot` to `/srv/tftp`. Modify
`/srv/tftp/live.cfg` to look like this:

----
label live-miner
menu label ^live-miner
kernel /live/vmlinuz
append initrd=/live/initrd.img boot=live config quiet netboot=nfs nfsroot=10.0.0.1:/srv/live-miner
----

Move the contents of `debian-live` to `/srv/live-miner`. Edit
`/srv/live-miner/live/live-miner.conf` to configure your server URLs and miner
options. Install `nfs-kernel-server` and export that directory via NFS by
adding the following to `/etc/exports`:

----
/srv/live-miner 10.0.0.0/16(ro,async,no_root_squash,no_subtree_check)
----

Run `exportfs -r` after editing `/etc/exports`. Finally, configure your
machines for network booting in their BIOS, and reboot them!

Building your own image
-----------------------

Most of the heavy lifting is done by the excellent tools provided by the
http://live.debian.net/[Debian Live project]. I'm building the images on a
Debian system, but any reasonably modern Linux system with
http://live.debian.net/manual-3.x/html/live-manual/installation.en.html#121[live-build]
installed should work.

After installing `live-build`, `make`, 'asciidoc' and 'git':

----
$ git clone https://github.com/live-miner/live-miner.git
$ cd live-miner
$ git submodule init
$ git submodule update
$ make
----

This will create `binary.hybrid.iso` which can be burned to a CD or written to
a USB stick. To create the netboot image instead, run:

----
$ make BINARY_IMAGES=netboot
----

*Important legal stuff*: If you are going to distribute the images you build,
you should add `SOURCE=true` to your `make` command line. The resulting
`source.debian-live.tar.xz` and `source.debian.tar.xz` files should be
distributed along with your binary images. This is necessary in order to comply
with the components of live-miner that are licensed under the GPL (and similar
licenses).

TODO
----

Automatically run one instance of poclbm for each ATI graphics card in the
system.

Switch distribution to wheezy (`fglrx` has not migrated yet).

Use `aticonfig` to detect whether the Xorg driver should be forced to `fglrx`.

Acknowledgements
----------------

The http://live.debian.net/[Debian Live project], for making it incredibly easy
to build a custom Debian Live CD.

The Debian project, for being Debian!

m0mchil, for https://github.com/m0mchil/poclbm[poclbm].

Mark Visser, for https://github.com/mjmvisser/adl3[adl3].

Obligatory legal mumbo-jumbo
----------------------------

Permission to use, copy, modify, and/or distribute live-miner for any purpose
is hereby granted. Note that live-miner includes many different programs. Their
exact terms of use are described in the individual files in
/usr/share/doc/*/copyright.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
