---
date: 2018-08-08
layout: post
title: I don't trust Signal
tags: [privacy]
---

Occasionally when Signal is in the press and getting a lot of favorable
discussion, I feel the need to step into various forums, IRC channels, and so
on, and explain why I don't trust Signal. Let's do a blog post instead.

Off the bat, let me explain that I expect a tool which claims to be secure to
actually be secure. I don't view "but that makes it harder for the average
person" as an acceptable excuse. If Edward Snowden and Bruce Schneier are going
to spout the virtues of the app, I expect it to *actually* be secure when it
matters - when vulnerable people using it to encrypt sensitive communications
are targeted by smart and powerful adversaries.

Making promises about security without explaining the tradeoffs you made in
order to appeal to the average user is unethical. Tradeoffs are necessary - but
self-serving tradeoffs are not, and it's your responsibility to clearly explain
the drawbacks and advantages of the tradeoffs you make. If you make broad and
inaccurate statements about your communications product being "secure", then
when the political prisoners who believed you are being tortured and hanged,
it's on you. The stakes are serious. Let me explain why I don't think Signal
takes them seriously.

## Google Play

Why do I make a big deal out of Google Play and Google Play Services? Well, some
people might trust Google, the company. But up against nation states, it's no
contest - Google has ties to the NSA, has been served secret subpoenas, and is
literally the world's largest machine designed for harvesting and analyzing
private information about their users. Here's what Google Play Services
*actually* is: **a rootkit**. Google Play Services lets Google do silent
background updates on apps on your phone and give them any permission they want.
Having Google Play Services on your phone means your phone is not secure.[^1]

[^1]: "But how is AOSP any better?" This is a common strawman counter-argument. Fact: There is empirical evidence which shows that Google Play Services does silent updates and can obtain any permission on your phone: a rootkit. There is no empirical evidence to suggest AOSP has similar functionality.

For the longest time, Signal wouldn't work without Google Play Services, but
Moxie (the founder of Open Whisper Systems and maintainer of Signal) finally
fixed this in 2017. There was also a long time when Signal was only available on
the Google Play Store. Today, you can [download the APK directly from
signal.org](https://signal.org/android/apk/), but... well, we'll
get to that in a minute.

## F-Droid

There's an alternative to the Play Store for Android.
[F-Droid](https://f-droid.org) is an open source app "store" (repository would
be a better term here) which only includes open source apps (which Signal
thankfully is).  By no means does Signal have to *only* be distributed through
F-Droid - it's certainly a compelling alternative. This has been proposed, and
Moxie has [definitively shut the discussion
down](https://github.com/signalapp/Signal-Android/issues/127). Admittedly this
is from 2013, but his points and the arguments against them haven't changed. Let
me quote some of his positions and my rebuttals:

>No upgrade channel. Timely and automatic updates are perhaps the most
>effective security feature we could ask for, and not having them would be a
>real blow for the project.

F-Droid supports updates. If you're concerned about moving your updates quickly
through the (minimal) bureaucracy of F-Droid, you can always run your own
repository. Maybe this is a lot of work?[^2] I wonder how the workload compares
to [animated gif search][gif-shit], a very important feature for security
concious users. I bet that [50 million dollar donation][big-bucks] could help,
given how many people operate F-Droid repositories on a budget of $0.

[^2]: No, it's not.

[gif-shit]: https://signal.org/blog/signal-and-giphy-update/
[big-bucks]: https://signal.org/blog/signal-foundation/

>No app scanning. The nice thing about market is the server-side APK scanning
>and signature validation they do. If you start distributing APKs around the
>internet, it's a reversion back to the PC security model and all of the
>malware problems that came with it.

Try searching the Google Play Store for "flashlight" and look at the permissions
of the top 5 apps that come up. All of them are harvesting and selling the
personal information of their users to advertisers. Is this some kind of joke?
F-Droid is a curated repository, like Linux distributions. Google Play is a
malware distributor.  Packages on F-Droid are reviewed by a human being and are
[cryptographically signed](https://f-droid.org/en/docs/Signing_Process/). If you
run your own F-Droid repo this is even less of a concern.

I'm not going to address all of Moxie's points here, because there's a deeper
problem to consider. I'll get into more detail shortly. You can read the
6-year-old threads tearing Moxie's arguments apart over and over again until
GitHub added the feature to lock threads, if you want to see a more in-depth
rebuttal.

## The APK direct download

Last year Moxie added an official APK download to signal.org. He said this was
up for "[harm reduction][harm-reduction]", to avoid people using unofficial
builds they find around the net. The download page is covered in warnings
telling you that it's for advanced users only, it's insecure, would you please
go to the Google Play store you stupid user. I wonder, has Moxie considered
communicating to people the risks of using the Google Play version?[^3]

[^3]: Probably not, because that wouldn't be self-serving. But I'm getting ahead of myself.

[harm-reduction]: https://github.com/signalapp/Signal-Android/issues/127#issuecomment-286223680

The APK direct download doesn't even accomplish the stated goal of "harm
reduction". The user has to manually verify the checksum, and figure out how to
do it on a phone, no less. A checksum isn't a signature, by the way - if your
government- or workplace- or abusive-spouse-installed certificate authority gets
in the way they can replace the APK *and* its checksum with whatever they want.
The app has to update itself, using a similarly insecure mechanism. F-Droid
handles updates and actually signs their packages. This is a no brainer, Moxie,
why haven't you put Signal on F-Droid yet?

## Why is Signal like this?

So if you don't like all of this, if you don't like how Moxie approaches these
issues, if you want to use something else, what do you do?

Moxie knows about everything I've said in this article. He's a very smart guy
and I am under no illusions that he doesn't understand everything I've put
forth. I don't think that Moxie makes these choices because he thinks they're
the right thing to do. He makes arguments which don't hold up, derails threads,
leans on logical fallacies, and loops back around to long-debunked positions
when he runs out of ideas. I think this is deliberate. An open source software
team reads this article as a list of things they can improve on and gets
started. Moxie reads this and prepares for war. Moxie can't come out and
say it openly, but he's made the decisions he has made because they serve his
own interests.

Lots of organizations which are pretending they don't make self-serving decisions at
their customer's expense rely on argumentative strategies like Moxie does. If
you can put together an argument which on the surface appears reasonable, but
requires in-depth discussion to debunk, passerby will be reassured that your
position is correct, and that the dissenters are just trolls. They won't have
time to read the lengthy discussion which demonstrates that your conclusions
are wrong, especially if you draw the discussion out like Moxie does. It can be
hard to distinguish these from genuine positions held by the person you're
talking to, but when it conveniently allows them to make self-serving plays,
it's a big red flag.

This is a strong accusation, I know. The thing which convinced me of its truth
is Signal's centralized design and hostile attitude towards forks. In open
source, when a project is making decisions and running things in a way you don't
like, you can always fork the project. This is one of the fundamental rights
granted to you by open source. It has a side effect Moxie doesn't want, however.
It reduces his power over the project. Moxie has a clever solution to this:
centralized servers and trademarks.

## Trust, federation, and peer-to-peer chat

Truly secure systems do not require you to trust the service provider. This is
the point of end-to-end encryption. But we have to trust that Moxie is running
the server software he says he is. We have to trust that he isn't writing down a
list of people we've talked to, when, and how often. We have to trust not only
that Moxie is trustworthy, but given that Open Whisper Systems is based in San
Francisco we have to trust that he hasn't received a national security letter,
too (by the way, Signal doesn't have a warrant canary). Moxie can *tell* us he
doesn't store these things, but he could. **Truly secure systems don't require
trust**.

There are a couple of ways to solve this problem, which can be used in tandem.
We can stop Signal from knowing when we're talking to each other by using
peer-to-peer chats. This has some significant drawbacks, namely that both users
have to be online at the same time for their messages to be delivered to each
other. You can still fall back to peer-to-server-to-peer when one peer is
offline, however. But this isn't the most important of the two solutions.

The most important change is federation. Federated services are like email, in
that Alice can send an email from gmail.com to Bob's yahoo.com address. I should
be able to stand up a Signal server, on my own hardware where I am in control of
the logs, and communicate freely with other Signal servers, including Open
Whisper's servers. This distributes the security risks across hundreds of
operators in many countries with various data extradition laws. This turns what
would today be easy for the United States government to break and makes it much,
much more difficult. Federation would also open the possibility for bridging the
gap with several other open source secure chat platforms to all talk on the same
federated network - which would spurn competition and be a great move for users
of all chat platforms.

Moxie forbids you from distributing branded builds of the Signal app, and if you
rebrand he forbids you from using the official Open Whisper servers. Because his
servers don't federate, that means that users of Signal forks *cannot talk to
Signal users*. This is a truly genius move. No fork of Signal[^4] to date has
ever gained any traction, and never will, because you can't talk to any Signal
users with them. In fact, there are no third-party applications which can
interact with Signal users in any way. Moxie can write as many blog posts which
appeal to wispy ideals and "moving ecosystems" as he wants[^5], but those are
all *really* convenient excuses for an argument which allows him to design
systems which serve his own interests.

[^4]: See [LibreSignal](https://github.com/LibreSignal/LibreSignal) and [Silence](https://github.com/SilenceIM/Silence#silence-), particularly [this thread](https://github.com/LibreSignal/LibreSignal/issues/37#issuecomment-217211165).
[^5]: See [Reflections: The ecosystem is moving](https://signal.org/blog/the-ecosystem-is-moving/). Yes, that's the unedited title.

No doubt these are non-trivial problems to solve. But I have *personally* been
involved in open source projects which have collectively solved similarly
difficult problems a thousand times over with a combined budget on the order of
tens of thousands of dollars.

What were you going to do with that 50 million dollars again?
