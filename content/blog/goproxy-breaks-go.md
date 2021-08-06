---
title: A lot of Go packages are silently broken because of GOPROXY
date: 2021-08-06
---

GOPROXY (or [proxy.golang.org][0]) is a service through which all "go get"
commands (and other module downloads) are routed. It may speed up some
operations by providing a cache, and it publishes checksums and an "index" of
all Go packages; but this is done at the cost of sending details of all of your
module downloads to Google and imposing extra steps when using Go packages from
an intranet.

[0]: https://proxy.golang.org

This cache never expires, which can cause some problems: you can keep fetching a
module from proxy.golang.org long after the upstream version has disappeared.
The upstream author probably had a good reason for removing a version! Because I
set `GOPROXY=direct` in my environment,[^1] which bypasses the proxy, I've been
made aware of a great number of Go packages which have broken dependencies and
are none the wiser. They generally can't reproduce the problem without
`GOPROXY=direct`, which can make it a challenge to rouse up the enthusiasm for
upstream to actually fix the issue. Caching modules forever can encourage
bitrot.

[^1]: Mainly for practical reasons, since it busts the cache when I need to fetch the latest version of a recently-updated module.

Packages which have these issues cannot be built unless Google keeps the cache
valid forever and can be trusted to treat the personal data associated with the
request with respect. Furthermore, as soon as a debugging session finds its way
to an absent module, you could be surprised to find that upstream is gone and
that fetching or patching the code may be a challenge. This has created ticking
time bombs throughout the Go ecosystem, which go undetected because GOPROXY
hides the problem from developers.

If you want to check if your packages are affected by this, just set
`GOPROXY=direct` in your environment, blow away your local cache, and build your
packages again. You might uncover an unpleasant surprise.

It may be worth noting that I already have a poor opinion of the Go module
mirror &mdash; it's been DDoS'ing my servers since February.[^2] [Since I
reported this][2], the Go team has been very opaque and non-communicative, and
none of their mitigations have had a meaningful improvement. Most of the traffic
is redundant &mdash; many modules are downloaded over and over again in short
time intervals. I have the option of blocking their traffic, of course, but that
would also block all Go programmers from fetching modules from my service. I
hope they adopt my recommendation of allowing admins to configure the crawl
parameters via robots.txt.

[2]: https://github.com/golang/go/issues/44577
[^2]: I SSH'd into git.sr.ht just now and found 50 git clones from the Go module mirror in the last 30 seconds, which is about ⅓ of all of our git traffic.

But, to be honest, the Go module mirror might not need to exist at all.

<details>
  <summary>P.S. Do you have feedback on this post?</summary>
  <p>
  I said, in
  <a
    href="https://drewdevault.com/2021/04/26/Cryptocurrency-is-a-disaster.html"
  >Cryptocurrency is an abject disaster</a>, that I wanted to make my blog
  more constructive. As it necessarily required a critical tone, this post might
  have broken this promise. Taking extra care to avoid this, I made an effort to
  use measured, reasonable language, to address specific problems rather than
  making generalizations, and to avoid flamebait, and I sought second opinions
  on the article before publishing.
  <p>
  I would welcome your feedback on the results. Was this post constructive?
  Should I instead refrain from this kind of criticism in general? Do you have
  any other thoughts to share? Please <a
    href="mailto:sir@cmpwn.com"
  >email me</a> if so.
</details>
