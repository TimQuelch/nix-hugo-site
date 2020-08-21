---
date: 2018-10-08
layout: post
title: Go 1.11 got me to stop ignoring Go
tags: ["go"]
---

I took a few looks at Go over the years, starting who knows when. My first
serious attempt to sit down and learn some damn Go was in 2014, when I set a new
personal best at almost 200 lines of code before I got sick of it. I kept
returning to Go because I could see how much potential it had, but every time I
was turned off for the same reason: `GOPATH`.

You see, `GOPATH` crossed a line. Go is opinionated, which is fine, but with
`GOPATH` its opinions extended beyond my Go work and into the rest of my system.
As a naive new Go user, I was prepared to accept their opinions on faith - but
only within their domain. I already have opinions about how to use my computer.
I knew Go was cool, but it could be the second coming of Christ, and so long as
it was annoying to use and didn't integrate with my workflow, I (rightfully)
wouldn't care.

Thankfully Go 1.11 solves this problem, and solves it delightfully well. I can
now keep Go's influence contained to the Go projects I work with, and in that
environment I'm much more forgiving of anything it wants to do. And when
considered in the vacuum of Go, what it wants to do is really compelling. Go
modules are *great*, and probably the single best module system I've used in any
programming language. Go 1.11 took my biggest complaint and turned it into one
of my biggest compliments. Now that the One Big Problem is gone, I've really
started to appreciate Go. Let me tell you about it.

The most important feature of Go is its simplicity. The language is small and
it grows a small number of features in each release, which rarely touch the
language itself. Some people see this as stagnation, but I see it as stability
and I know that very little Go code in the wild, no matter how old, is going to
be unidiomatic or fail to compile. Even setting aside stability, the
conservative design of the language makes Go code in the wild remarkably
consistent. Almost all third-party Go libraries are high quality stuff. Gofmt
helps with this as well[^1]. The limitations of the language and the way the
stdlib gently nudges you into good patterns make it easy to write good Go code.
Most of the "bad" Go libraries I've found are trying to work around Go's
limitations instead of embracing them.

[^1]: I have *minor* gripes with gofmt, but the benefits make up for it beautifully. On the other hand, I have *major* gripes with PEP-8, and if you ever see me using it I want you to shoot me in the face.

There's more. The concurrency model is superb. It should come as no surprise
that a language built by the alumni of Plan 9 would earn high marks in this
regard, and consequently you can scale your Go program up to be as concurrent as
you want without even thinking about it. The standard library is also excellent -
designed consistently and designed well, and I can count on one hand (or even
one finger) the number of stdlib modules I've encountered that feel crusty. The
type system is great, too. It's the perfect balance of complexity and simplicity
that often effortlessly grants these traits to the abstractions you make with
it.

I'm not even slightly bothered by the lack of generics - years as a C programmer
taught me not to need them, and I think most of the cases where they're useful
are to serve designs which are too complicated to use anyway. I do have some
complaints, though. The concurrency model is great, but a bit too magical and
implicit.  Error handling is annoying, especially because finding the origin of
the error is unforgivably difficult, but I don't know how to improve it. The log
module leaves a lot to be desired and can't be changed because of legacy
support.  `interface{}` is annoying when you have to deal with it, like when
dealing with JSON you can't unmarshall into a struct.

My hope for the future of Go is that it will continue to embrace simplicity in
the face of cries for complexity. I consider Go modules a runaway success
compared to dep, and I hope to see this story repeated[^2] before hastily adding
generics, better error handling, etc. Go doesn't need to compete with anyone
like Rust, and trying to will probably ruin what makes Go great. My one request
of the Go team: don't make changes in Go 2.0 which make the APIs of existing
libraries unidiomatic.

[^2]: Though hopefully with less drama.

Though I am growing very fond of it, by no means am I turning into a Go zealot.
I still use C, Python, and more all the time and have no intention of stopping.
A programming language which tries to fill all niches is a failed programming
language. But, to those who were once like me: Go is good now! In fact, it's
great! Try it!
