---
title: In praise of Plan 9
date: 2022-11-12
---

[Plan 9][0] is an operating system designed by Bell Labs. It's the OS they wrote
*after* Unix, with the benefit of hindsight. It is the most interesting
operating system that you've never heard of, and, in my opinion, the best
operating system design to date. Even if you haven't heard of Plan 9, the
designers of whatever OS you *do* use have heard of it, and have incorporated
some of its ideas into your OS.

[0]: https://en.wikipedia.org/wiki/Plan_9_from_Bell_Labs

Plan 9 is a research operating system, and exists to answer questions about
ideas in OS design. As such, the Plan 9 experience is in essence an exploration
of the interesting ideas it puts forth. Most of the ideas are small. Many of
them found a foothold in the broader ecosystem &mdash; UTF-8, goroutines, /proc,
containers, union filesystems, these all have their roots in Plan 9 &mdash; but
many of its ideas, even the good ones, remain unexplored outside of Plan 9. As a
consequence, Plan 9 exists at the center of a fervor of research achievements
which forms a unique and profoundly interesting operating system.

One example I often raise to illustrate the design ideals of Plan 9 is to
compare its approach to network programming with that of the Unix standard,
Berkeley sockets. BSD sockets fly in the face of Unix sensibilities and are
quite alien on the system, though by now everyone has developed stockholm
syndrome with respect to them so they don't notice. When everything is supposed
to be a file on Unix, why is it that the networking API is entirely implemented
with special-purpose syscalls and ioctls? On Unix, creating a TCP connection
involves calling the "socket" syscall to create a magic file descriptor, then
the "connect" syscall to establish a connection. Plan 9 is much more Unix in its
approach: you open /net/tcp/clone to reserve a connection, and read the
connection ID from it. Then you open /net/tcp/n/ctl and write "connect
127.0.0.1!80" to it, where "n" is that connection ID. Now you can open
/net/tcp/n/data and that file is a full-duplex stream. No magic syscalls, and
you can trivially implement it in a shell script.

This composes elegantly with another idea from Plan 9: the 9P protocol. All file
I/O on the entire system uses the 9P protocol, which defines operations like
read and write. This protocol is network transparent, and you can mount remote
servers into your filesystem namespace and access their files over 9P. You can
do something similar on Unix, but on Plan 9 you get much more mileage from the
idea because everything is *actually* a file, and there are no magic syscalls or
ioctls. For instance, your Ethernet interface is at /net/ether0, and everything
in there is just a file. Say you want to establish a VPN: you simply mount a
remote server's /net/ether0 at /net/ether1, and now you have a VPN. That's *it*.

The mountpoints are interesting as well, because they exist within a per-process
filesystem namespace. Mounting filesystems does not require special permissions
like on Unix, because these mounts only exist within the process tree that
creates them, rather than modifying global state. The filesystems can also be
implemented in userspace rather trivially via the 9P protocol, similar to FUSE
but much more straightforward. Many programs provide a programmable/scriptable
interface via a special filesystem such as this.

Userspace programs can also provide filesystems compatible with those normally
implemented by kernel drivers, like /net/ether0, and provide these to processes
in their namespace. For example, /dev/draw is analogous to a framebuffer device:
you open it to write pixels to the screen. The window manager, Rio, implements
a /dev/draw-like interface in userspace, then mounts it in the filesystem
namespace of its children. All GUI programs can thus be run both on a
framebuffer or in a window, without any awareness of which it's using. The same
is also true over the network: to implement VNC-like functionality, just mount
your local /dev/draw and /dev/kbd on a remote server. Add /dev/audio if you
like.

These ideas can also be built upon to form something resembling a container
runtime, pre-dating even early concepts like BSD jails by several years, and
implementing them much more effectively. Recall that everything *really is* just
a file on Plan 9, unlike Unix. Access to the hardware is provided through normal
files, and per-process namespaces do not require special permissions to modify
mountpoints. Making a container is thus trivial: just unmount all of the
hardware you don't want the sandboxed program to have access to. Done. You don't
even have to be root. Want to forward a TCP port? Write an implementation of
/net/tcp which is limited to whatever ports you need &mdash; perhaps with just a
hundred lines of shell scripting &mdash; and mount it into the namespace.

The shell, rc, is also wonderful. The debugger is terribly interesting, and its
ideas didn't seem to catch on with the likes of gdb. The editors, acme and sam,
are also interesting and present a unique user interface that you can't find
anywhere else. The plumber is cool, it's like "what if xdg-open was good
actually". The kernel is concise and a pleasure to read. The entire operating
system, kernel *and* userspace, can be built from source code on my 12 year old
laptop in about 5 minutes. The network database, ndb, is brilliant. The entire
OS is stuffed to the brim with interesting ideas, all of them implemented with
elegance, conciseness, and simplicity.

Plan 9 failed, in a sense, because Unix was simply too big and too entrenched by
the time Plan 9 came around. It was doomed by its predecessor. Nevertheless, its
design ideas and implementation resonate deeply with me, and have provided an
endless supply of inspiration for my own work. I think that everyone owes it to
themselves to spend a few weeks messing around with and learning about Plan 9.
The dream is kept alive by [9front][1], which is the most actively maintained
fork of Plan 9 available today. Install it on your ThinkPad and mess around.

[1]: http://9front.org/

I will offer a caveat, however: leave your expectations at the door. Plan 9 is
not Unix, it is not Unix-compatible, and it is certainly not yet another Linux
distribution. Everything you're comfortable and familiar with in your normal
Unix setup will not translate to Plan 9. Come to Plan 9 empty handed, and let it
fill those hands with its ideas. You will come away from the experience as a
better programmer.
