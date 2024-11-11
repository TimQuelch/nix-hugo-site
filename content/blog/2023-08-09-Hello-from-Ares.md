---
title: Hello from Ares!
date: 2023-08-09
---

I am pleased to be writing today's blog post from a laptop running [Ares OS]. I
am writing into an ed(1) session, on a file on an ext4 filesystem on its hard
drive. That's pretty cool! It seems that a lot of interesting stuff has happened
since I gave that talk on Helios at [FOSDEM] in February.

[Ares OS]: https://ares-os.org
[FOSDEM]: https://spacepub.space/w/wpKXfhqqr7FajEAf4B2Vc2

![A picture of my ThinkPad while I was editing this blog post](https://redacted.moe/f/68a47ef3.jpg)

The talk I gave at FOSDEM was no doubt impressive, but it was a bit of a party
trick. The system was running on a Raspberry Pi with one process which included
both the slide deck as a series of raster images baked into the ELF file, as
well as the GPU driver and drawing code necessary to display them, all in one
package. This was quite necessary, as it turns out, given that the very idea of
"processes" was absent from the system at this stage.

Much has changed since that talk. The system I am writing to you from has
support for processes indeed, complete with fork and exec and auxiliary vectors
and threads and so on. If I run "ps" I get the following output:

```
mercury % ps
1 /sbin/usrinit dexec /sbin/drv/ext4 block0 childfs 0 fs 0
2 /etc/driver.d/00-pcibus
3 /etc/pci.d/class/01/06/ahci
4 /etc/driver.d/00-ps2kb
5 /etc/driver.d/99-serial
6 /etc/driver.d/99-vgacons
7 /sbin/drv/ext4 block0
15 ed blog.md
16 ps
```

Each of these processes is running in userspace, and some of them are drivers. A
number of drivers now exist for the system, including among the ones you see
here a general-purpose PCI driver, AHCI (SATA), PS/2 keyboard, PC serial, and a
VGA console, not to mention the ext4 driver, based on lwext4 (the first driver
not written in Hare, actually). Not shown here are additional drivers for the
CMOS real-time clock (so Ares knows what time it is, thanks to Stacy Harper), a
virtio9pfs driver (thanks also to Tom Leb for the initial work here), and a few
more besides.

As of this week, a small number of software ports exist. The ext4 driver is
based on lwext4, as I said earlier, which might be considered a port, though it
is designed to be portable. The [rc] shell I have been working on lately has
also been ported, albeit with many features disabled, to Mercury. And, of
course, I did say I was writing this blog post with ed(1) -- I have ported
Michael Forney's [ed implementation] from sbase, with [relatively few] features
disabled as a matter of fact (the "!" command and signals were removed).

[rc]: https://git.sr.ht/~sircmpwn/rc
[ed implementation]: http://git.suckless.org/sbase/file/ed.c.html
[relatively few]: https://git.sr.ht/~sircmpwn/sbase/commit/ee0336bc3b6f55839785427d6184e6f897055e31

This ed port, and lwext4, are based on our C library, designed with drivers and
normal userspace programs in mind, and derived largely from musl libc. This is
coming along rather well -- a few features (signals again come to mind) are not
going to be implemented, but it's been relatively straightforward to get a large
amount of the POSIX/C11 API surface area covered on Ares, and I was pleasantly
surprised at how easy it was to port ed(1).

There's still quite a lot to be done. In the near term, I expect to see the
following:

* A virtual filesystem
* Pipes and more shell features enabled, such as redirects
* More filesystem support (mkdir et al)
* A framebuffer console
* EFI support on x86\_64
* MBR and GPT partitions

This is more of the basics. As these basics unblock other tasks, a few of the
more ambitious projects we might look forward to include:

* Networking support (at least ICMP)
* Audio support
* ACPI support
* Basic USB support
* A service manager (*not* systemd...)
* An installer, perhaps a package manager
* Self-hosting builds
* Dare I say Wayland?

I should also probably do something about that whining fan I'm hearing in the
background right now. Of course, I will also have to do a fresh DOOM port once
the framebuffer situation is improved. There's also still plenty of kernel work
to be done and odds and ends all over the project, but it's in pretty good shape
and I'm having a blast working on it. I think that by now I have answered the
original question, "can an operating system be written in Hare", with a
resounding "yes". Now I'm just having fun with it. Stay tuned!

Now I just have to shut this laptop off. There's no poweroff command yet, so I
suppose I'll just hold down the power button until it stops making noise.
