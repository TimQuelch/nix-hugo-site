---
date: 2018-11-15
layout: post
title: "sr.ht, the hacker's forge, now open for public alpha"
tags: ["sourcehut", "announcement"]
---

I'm happy to announce today that I'm opening [sr.ht](https://sr.ht) (pronounced
"sir hat", or any other way you want) to the general public for the remainder of
the alpha period. Though it's missing some of the features which will be
available when it's completed, sr.ht today represents a very capable software
forge which is already serving the needs of many projects in the free & open
source software community. If you're familiar with the project and ready to
register your account, you can head straight to [the sign up
page](https://sr.ht).

For those who are new, let me explain what makes sr.ht special. It provides many
of the trimmings you're used to from sites like GitHub, Gitlab, BitBucket, and
so on, including git repository hosting, bug tracking software, CI, wikis, and
so on. However, the sr.ht model is different from these projects - where many
forges attempt to replicate GitHub's success with a thinly veiled clone of the
GitHub UI and workflow, sr.ht is fundamentally different in its approach.

>The sr.ht platform excites me more than any project in recent memory. It’s a
>fresh concept, not a Github wannabe like Gitlab. I always thought that if
>something is going to replace Github it would have to be a paradigm change, and
>I think that’s what we’re seeing here. Drew’s project blends the wisdom of the
>kernel hackers with a tasteful web interface.

<div style="margin-top: -1rem; margin-bottom: 1rem"><small>&mdash;<a href="https://lobste.rs/s/h1udkf/git_is_already_federated_decentralized#c_smnkic">begriffs on lobste.rs</a></small></div>

The 500 foot view is that sr.ht is a [100% free and open
source](https://git.sr.ht/~sircmpwn/?search=sr.ht) software forge, with a hosted
version of the services running *at* [sr.ht](https://sr.ht) for your
convenience. Unlike GitHub, which is almost entirely closed source, and Gitlab,
which is mostly open source but with a proprietary premium offering, all of
sr.ht is completely open source, with a copyleft license[^bsd]. You're welcome
to install it on your own hardware, and [detailed
instructions](https://man.sr.ht/installation.md) are available for those who
want to do so. You can also send patches upstream, which are then integrated
into the hosted version.

[^bsd]: Some components use the 3-clause BSD license.

sr.ht is special because it's extremely modular and flexible, designed with
interoperability with the rest of the ecosystem in mind. On top of that, sr.ht
is one of the most lightweight websites on the internet, with the average page
weighing less than 10 KiB, with **no tracking** and **no JavaScript**. Each
component - git hosting, continuous integration, etc - is a standalone piece of
software that integrates deeply with the rest of sr.ht *and* with the rest of
the ecosystem outside of sr.ht. For example, you can use builds.sr.ht to compile
your GitHub pull requests, or you can keep your repos on git.sr.ht and host
everything in one place. Unlike GitHub, which favors its own in-house pull
request workflow[^github-prs], sr.ht embraces and improves upon the email-based
workflow favored by git itself, along with many of the more hacker-oriented
projects around the net. I've put a lot of work into making this powerful
workflow more [accessible and
comprehensible](https://man.sr.ht/git.sr.ht/send-email.md) to the average
hacker.

[^github-prs]: A model that many have replicated in their own GitHub alternatives.

The flagship product from sr.ht is its continuous integration platform,
builds.sr.ht, which is easily the most capable continuous integration system
available today. It's so powerful that I've been working with multiple Linux
distributions on bringing them onboard because it's the only platform which can
scale to the automation needs of an entire Linux distribution. It's so powerful
that I've been working with maintainers of *non-Linux* operating systems, from
BSD to even Hurd, because it's the only platform which can even consider
supporting their needs. Smaller users are loving it, too, many of whom are
jumping ship from Travis and Jenkins in favor of the simplicity and power of
builds.sr.ht.

On builds.sr.ht, simple YAML-based [build
manifests](https://man.sr.ht/builds.sr.ht/#build-manifests), similar to those
you see on other platforms, are used to describe your builds. You can submit
these through the web, the API, or various integrations.  Within seconds, a
virtual machine is booted with KVM, your build environment is sent to it, and
your scripts start running. A diverse set of base images are supported on a
variety of architectures, soon to include the first hardware-backed RISC-V
cycles available to the general public. builds.sr.ht is used to automate
everything from the deployment of this Jekyll-based blog, testing GitHub pull
requests for [sway](https://swaywm.org), building and testing packages for
[postmarketOS](https://postmarketos.org/), and deploying complex applications
like builds.sr.ht itself. Our base images [build, test, and deploy
themselves](https://builds.sr.ht/~sircmpwn/alpine/edge) every day.

The lists.sr.ht service is another important part of sr.ht, and a large part of
how sr.ht embraces the model used by major projects like Linux, Postgresql, git
itself, and many more. lists.sr.ht finally modernizes mailing lists, with a
powerful and elegant web interface for hacking on and talking about your
projects. Take a look at the [sr.ht-dev][sr.ht-dev] list to see patches
developed for sr.ht itself. Another good read is the [mrsh-dev][mrsh-dev] list,
used for development on the [mrsh][mrsh] project, or my own [public
inbox][public-inbox], where I take comments for this blog and grab-bag
discussions for my smaller projects.

[sr.ht-dev]: https://lists.sr.ht/~sircmpwn/sr.ht-dev
[mrsh-dev]: https://lists.sr.ht/~emersion/mrsh-dev
[mrsh]: https://git.sr.ht/~emersion/mrsh
[public-inbox]: https://lists.sr.ht/~sircmpwn/public-inbox

I've just scratched the surface, and there's much more for you to discover. You
could look at my [scdoc](https://git.sr.ht/~sircmpwn/scdoc) project to get an
idea of how the git browser looks and feels. You could [browse tickets on my
todo.sr.ht profile](https://todo.sr.ht/~sircmpwn) to get a feel for the bug
tracking software. Or you could check out the [detailed
manual](https://man.sr.ht) on sr.ht's git-powered wiki service. You could also
just [sign up for an account](https://sr.ht)!

sr.ht isn't complete, but it's maturing fast and I think you'll love it. Give it
a try, and I'm only [an email away](mailto:sir@cmpwn.com) to receive your
feedback.
