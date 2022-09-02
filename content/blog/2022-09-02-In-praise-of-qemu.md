---
title: In praise of qemu
date: 2022-09-02
---

[qemu][0] is another in a long line of great software started by [Fabrice
Bellard][1]. It provides virtual machines for a wide variety of software
architectures. Combined with KVM, it forms the foundation of nearly all cloud
services, and it runs SourceHut in our self-hosted datacenters. Much like
Bellard's ffmpeg revolutionized the multimedia software industry, qemu
revolutionized virtualisation.

[0]: https://www.qemu.org/
[1]: https://bellard.org/

[2]: https://www.kernel.org/doc/html/latest/admin-guide/binfmt-misc.html
[3]: https://harelang.org/

qemu comes with a large variety of studiously implemented virtual devices, from
standard real-world hardware like e1000 network interfaces to accelerated
virtual hardware like virtio drives. One can, with the right combination of
command line arguments, produce a virtual machine of essentially any
configuration, either for testing novel configurations or for running
production-ready virtual machines. Network adapters, mouse & keyboard, IDE or
SCSI or SATA drives, sound cards, graphics cards, serial ports&nbsp;&mdash; the
works. Lower level, often arch-specific features, such as AHCI devices, SMP,
NUMA, and so on, are also available and invaluable for testing any conceivable
system configurations. And these configurations *work*, and work reliably.

I have relied on this testing quite a bit when working on kernels, particularly
on [my own Helios kernel][4]. With a little bit of command line magic, I can run
a fully virtualised system with a serial driver connected to the parent
terminal, with a hardware configuration appropriate to whatever I happen to be
testing, in a manner such that running and testing my kernel is no different
from running any other program. With -gdb I can set up gdb remote debugging and
even debug my kernel as if it were a typical program. Anyone who remembers osdev
in the Bochs days &mdash; or even earlier &mdash; understands the unprecedented
luxury of such a development environment. Should I ever find myself working on a
hardware configuration which is unsupported by qemu, my very first step will be
patching qemu to support it. In my reckoning, qemu support is nearly as
important for bringing up a new system as a C compiler is.

[4]: https://drewdevault.com/2022/06/13/helios.html

And qemu's implementation in C is simple, robust, and comprehensive. On the
several occasions when I've had to read the code, it has been a pleasure.
Furthermore, the comprehensive approach allows you to build out a virtualisation
environment tuned precisely to your needs, whatever they may be, and it is
accommodating of many needs. Sure, it's low level &mdash; running a qemu command
line is certainly more intimidating than, say, VirtualBox &mdash; but the
trade-off in power afforded to the user opens up innumerable use-cases that are
simply not available on any other virtualisation platform.

One of my favorite, lesser-known features of qemu is qemu-user, which allows you
to register a [binfmt][2] handler to run executables compiled for an arbitrary
architecture on Linux. Combined with a little chroot, this has made cross-arch
development easier than it has ever been before, something I frequently rely on
when working on [Hare][3]. If you do cross-architecture work and you haven't set
up qemu-user yet, you're missing out.

```
$ uname -a
Linux taiga 5.15.63-0-lts #1-Alpine SMP Fri, 26 Aug 2022 07:02:59 +0000 x86_64 GNU/Linux
$ doas chroot roots/alpine-riscv64/ /bin/sh
# uname -a
Linux taiga 5.15.63-0-lts #1-Alpine SMP Fri, 26 Aug 2022 07:02:59 +0000 riscv64 Linux
```

<!-- Inline styles because lazy -->
<small style="
  text-align: center;
  display: block;
  color: #555;
">This is amazing.</small>

qemu also holds a special place in my heart as one of the first projects I
contributed to over email 🙂 And they still use email today, and even [recommend
SourceHut][5] to make the process easier for novices.

[5]: https://qemu.readthedocs.io/en/v6.2.0/devel/submitting-a-patch.html#if-you-cannot-send-patch-emails

So, to Fabrice, and the thousands of other contributors to qemu, I offer my
thanks. qemu is one of my favorite pieces of software.
