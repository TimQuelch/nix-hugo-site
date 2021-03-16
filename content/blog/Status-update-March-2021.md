---
title: Status update, March 2021
date: 2021-03-15
outputs: [html, gemtext]
---

After the brief illusion of spring, this morning meets us with a cold apartment
indoors and fierce winds outdoors. Today concludes a productive month, mainly
for the secret project and for sourcehut, but also marked by progress in some
smaller projects as well. I'll start with those smaller projects.

I have written a feed reader for Gemini, which is (1) [free
software](https://sr.ht/~sircmpwn/gemreader), and (2) [available as a free
hosted service](gemini://feeds.drewdevault.com). Big thanks to adnano, the
author of the [go-gemini](https://sr.ht/~adnano/go-gemini) library, which has
been very helpful for many of my Gemini-related exploits, and who has been a
great collaborator. I also used it to provide Gemini support for the new
[pages.sr.ht](https://srht.site), which offers static web and gemini hosting for
sr.ht users. I also updated [gmni](https://sr.ht/~sircmpwn/gmni) to use BearSSL
instead of OpenSSL this month.

[godocs.io](https://godocs.io) has been enjoying continued improvements, mainly
thanks again to adnano. Heaps of obsolete interfaces and cruft have been
excised, not only making it lighter for godocs.io, but also making our [gddo
fork](https://git.sr.ht/~sircmpwn/gddo) much easier for you to run yourself.
Adnan hopes to have first-class support for Go modules working soon, which will
bring us up to feature parity with pkg.go.dev.

There's some sourcehut news as well, but I'll leave that for the "What's
cooking" later today. Until next time!

<details>
  <summary>...</summary>

  Progress on the secret project has been phenomenal. In the last month, the
  standard library has doubled in size, and this weekend, we finished the
  self-hosted build driver. We are about 1,000 lines of code shy of having more
  code written in <span style="background: black;">xxxx</span>
  than in C. Here's the build driver compiling and running itself several times:

<pre>
$ <span style="background: black;">    </span> run ./cmd/<span style="background: black;">    </span> run ./cmd/<span style="background: black;">    </span> run -h
run: compiles and runs <span style="background: black;">    </span> programs

Usage: run [-v]
	 [-D &lt;ident:type=value&gt;]
	 [-j &lt;jobs&gt;]
	 [-l &lt;name&gt;]
	 [-T &lt;tags...&gt;]
	 [-X &lt;tags...&gt;]
	 path args...

-v: print executed commands
-D &lt;ident:type=value&gt;: define a constant
-j &lt;jobs&gt;: set parallelism for build
-l &lt;name&gt;: link with a system library
-T &lt;tags...&gt;: set build tags
-X &lt;tags...&gt;: unset build tags</pre>

  The call for help last month was swiftly answered, and we have 7 or 8 new
  people working on the project now. We've completed enough work to unblock many
  workstreams, which will allow these new contributors to work in parallel on
  different areas of interest, which should substantially speed up progress.
</details>
