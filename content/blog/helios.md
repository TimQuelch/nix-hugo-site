---
title: The Helios microkernel
date: 2022-06-13
---

I've been working on a cool project lately that I'd like to introduce you to:
[the Helios microkernel][Helios]. Helios is written in [Hare] and currently
targets x86\_64, and riscv64 and aarch64 are on the way. It's very much a
work-in-progress: don't expect to pick this up and start building anything with
it today.

[Helios]: https://sr.ht/~sircmpwn/helios
[Hare]: https://harelang.org
[seL4]: https://sel4.systems

![A picture of a ThinkPad running Helios, demonstrating userspace memory allocation](https://l.sr.ht/gnrA.jpg)

Again, drawing some inspiration from seL4, Helios uses a capability-based design
for isolation and security. The kernel offers primitives for allocating physical
pages, mapping them into address spaces, and managing tasks, plus features like
platform-specific I/O (e.g. reading and writing x86 ports). The entire system is
written in Hare, plus some necessary assembly for the platform bits (e.g.
configuring the GDT or IDT).

Things are still quite early, but I'm pretty excited about this project. I
haven't had this much fun hacking in some time :) We have several kernel
services working, including memory management and virtual address spaces, and
I've written a couple of simple drivers in userspace (serial and BIOS VGA
consoles). Next up is preemptive multi-tasking&nbsp;&mdash; we already have
interrupts working reliably, including the PIT, so all that's left for
multi-tasking is to actually implement the context switch. I'd like to aim for
an seL4-style single-stack system, though some finageling will be required
to make that work.

Much of the design comes from seL4, but unlike seL4, we intend to build upon
this kernel and develop a userspace as well. Each of the planned components is
named after celestial bodies, getting further from the sun as they get
higher-level:

- Helios: the kernel
- Mercury: low-level userspace services & service bus
- Venus: real-world driver collection
- Gaia: high-level programming environment
- Ares: a complete operating system; package management, GUI, etc

A few other components are planned &mdash; "Vulcan" is the userspace kernel
testing framework, named for the (now disproved) hypothetical planet between
Mercury and the Sun, and "Luna" is the planned POSIX compatibility layer. One of
the goals is to be practical for use on real-world hardware. I've been testing
it continuously on my ThinkPads to ensure real-world hardware support, and I
plan on writing drivers for its devices &mdash; Intel HD graphics, HD Audio, and
Intel Gigabit Ethernet at the least. A basic AMD graphics driver is also likely
to appear, and perhaps drivers for some SoC's, like Raspberry Pi's VideoCore. I
have some neat ideas for the higher-level components as well, but I'll save
those for later.

Why build a new operating system? Well, for a start, it's really fun. But I also
take most of my projects pretty seriously and aim for real-world usability,
though it remains to be seen if this will be achieved. This is a hugely
ambitious project, or, in other words, my favorite kind of project. Even if it's
not ultimately useful, it will drive the development of a lot of useful stuff.
We're planning to design a debugger that will be ported to Linux as well, and
we'll be developing DWARF support for Hare to facilitate this. The GUI toolkit
we want to build for Ares will also be generally applicable. And Helios and
Mercury together have a reasonably small scope and makes for an interesting and
useful platform in their own right, even if the rest of the stack never
completely materializes. If nothing else, it will probably be able to run DOOM
fairly soon.

The kernel *is* a microkernel, so it is fairly narrow in scope and will probably
be more-or-less complete in the foreseeable future. The next to-do items are
context switching, so we can set up multi-tasking, IPC, fault handling, and
userspace support for interrupts. We'll also need to parse the ACPI tables and
bring up PCI in the kernel before handing it off to userspace. Once these things
are in place, the kernel is essentially ready to be used to write most drivers,
and the focus will move to fleshing out Mercury and Venus, followed by a small
version of Gaia that can at least support an interactive shell. There are some
longer-term features which will be nice to have in the kernel at some point,
though, such as SMP, IOMMU, or VT-x support.

Feel free to pull down the code and check it out, though remember my warning
that it doesn't do too much yet. You can download the [latest ISO] from the CI,
if you want to reproduce the picture at the top of this post, and write it to a
flash drive to stick in the x86\_64 computer of your choice (boot via legacy
BIOS). If you want to mess with the code, you could play around with the Vulcan
system to get simple programs running in userspace. The kernel serial driver is
write-only, but a serial driver written in userspace could easily be made to
support interactive programs. If you're feeling extra adventureous, it probably
wouldn't be too difficult to get a framebuffer online and draw some pixels
&mdash; ping me in #helios on Libera Chat for a few words of guidance if you
want to try it.

[latest ISO]: https://builds.sr.ht/~sircmpwn/helios/commits/master
