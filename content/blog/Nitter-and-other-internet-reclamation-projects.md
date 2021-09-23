---
title: Nitter and other Internet reclamation projects
date: 2021-09-23
---

The world wide web has become an annoying, ultra-commercialized space. Many
websites today are prioritizing the interests of the company behind the domain,
at the expense of the user's experience and well-being. This has been a
frustrating problem for several years, but lately there's been a heartwarming
trend of users fighting back against the corporate web and stepping up to help
and serve each other's needs in spite of them, through what I've come to think
of as Internet reclamation projects.

I think the first of these which appeared on my radar was [Invidious][inv],
which scrapes information off of a YouTube page and presents it in a more
pleasant, user-first interface&mdash; something which [NewPipe][np] also does
well for Android. These tools pry data out of YouTube's hands and present it on
a simple UI, designed for users first, with no ads or spyware, and with nice
features YouTube would never add, like download links, audio mode, and offline
viewing. It shows us what users want, but YouTube refuses to give.

[inv]: https://github.com/iv-org/invidious
[np]: https://drewdevault.com/2019/04/02/NewPipe-represents-the-best-of-FOSS.html
[nt]: https://github.com/zedeus/nitter

Another project which has been particularly successful recently is [Nitter][nt],
which does something similar for Twitter. Twitter's increasingly draconian
restrictions on who can access what data, and their attitude towards logged-out
users in particular, has been a great annoyance to anyone who does not have, and
does not want, a Twitter account, but who may still encounter Twitter links
around the web. Nitter has been quite helpful in de-crapifying Twitter for these
folks. I have set up an automatic redirect in my browser which takes me straight
to Nitter, and I never have to see the shitty, user-hostile Twitter interface
again.

[Bibliogram][bi] is another attempt which has done its best to fix Instagram,
but they have [encountered challenges][bi issues] with Instagram's strict rate
limits and anti-scraping measures. Another project, [Teddit][td], is attempting
to fix Reddit's increasingly anti-user interface, and [Libreddit][lr] has
similar ambitions.

[bi]: https://sr.ht/~cadence/bibliogram/
[bi issues]: https://git.sr.ht/~cadence/bibliogram-docs/tree/master/docs/Instagram%20rate%20limits.md#tldr-what-does-it-mean-if-an-instance-is-blocked
[lr]: https://github.com/spikecodes/libreddit
[td]: https://codeberg.org/teddit/teddit

All of these services are more useful, more accessible, and more inclusive than
their corporate counterparts. They work better on older browsers and low-end
devices. They have better performance. They aren't spying on you. In short,
they are rejecting the [domestication of their users][domesticate] that the
platforms they interact with have been trying to do. Their efforts are part of
an inspiring trend of internet activism which rejects the corporate shells and
walled gardens without giving up the useful data they have stolen away inside.

[domesticate]: https://seirdy.one/2021/01/27/whatsapp-and-the-domestication-of-users.html

Here are some more services full of user-hostile behavior I'd like to see
replaced with user-first, high performance, FOSS frontends:

- Facebook
- GitLab and GitHub
- Medium et al, via an open source [readability][0]-as-a-service platform

[0]: https://github.com/mozilla/readability

I would be happy to redirect myself away from any of these services for a
faster, lighter weight, more inclusive, user-first experience. Any others you'd
like to see?
