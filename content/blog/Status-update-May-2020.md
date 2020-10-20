---
date: 2020-05-15
layout: post
title: Status update, May 2020
tags: ["status update"]
---

Hello, future readers! I am writing to you from one day in the past. I finished
my plans for today early and thought I'd get a head start on writing the status
updates for tomorrow, or rather, for today. From your reference frame, that is.

Let's start with Wayland. First, as you might have heard, [The Wayland
Protocol](https://wayland-book.com) is now free for anyone to read, and has been
relicensed as CC-BY-SA. Enjoy! It's still not quite done, but most of it's
there. In development news, wlroots continues to enjoy incremental improvements,
and is being refined further and further towards a perfect citizen of the
ecosystem in which it resides. Sway as well has seen many small bugfixes and
improvements. Both have been been stable for a while now: the only meaningful
changes will be, for the most part, a steady stream of bug fixes and performance
improvements.

Moving on from Wayland, then, there are some interesting developments in the
world of email as well. aerc has seen some minor changes to how it handles
templates and custom email headers, and a series of other small features and
improvements: drafts, a `:choose` meta-command, and fixes for OpenBSD and Go
1.15. Additionally, I've joined [Simon Ser](https://emersion.fr/) to work on
[Alps](https://sr.ht/~emersion/alps/) together, to put the finishing touches on
our lightweight & customizable webmail client before
[Migadu](https://www.migadu.com/en/index.html) puts it into production.

On the SourceHut front, lots of cool stuff came out this month. You might have
seen the [announcement this week][plan 9] that we've added Plan 9 support to the
CI &mdash; a world first :D I also just published the first bits of the new,
experimental GraphQL API for git.sr.ht, which you can [play with here][graphql].
And, of course, the long-awaited project hub was released this month! [Check it
out here](https://sr.ht) to get your projects listed. I'll post about all of
this in more detail on the sr.ht-announce mailing list later today.

[plan 9]: https://sourcehut.org/blog/2020-05-11-sourcehut-plus-plan-9/
[graphql]: https://git.sr.ht/graphql

That's all for today! I'll see you next month. Thank you once more for your
wonderful support.

<details>
  <summary>...</summary>
<pre>/* sys::write */
fn write(fd: int, buf: *void, count: size) size;

fn puts(s: str) size =
{
	let n = write(1, s: *char, len(s));
	n += write(1, "\n": *char, 1);
	n;
};

export fn main int =
{
	puts("Hello world!");
	0;
};
</pre>

<pre>
$ ./[redacted] < example.[redacted] | qbe > example.S
$ as -o example.o example.S
$ ld -o example lib/sys/[redacted]s.o example.o lib/sys/lib[redacted]rt.a
$ wc -c example
9640
$ ./example
Hello world!
</pre>
</details>
