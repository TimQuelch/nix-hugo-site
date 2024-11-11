---
title: GitHub stale bot considered harmful
date: 2021-10-26
---

Disclaimer: I work for a GitHub competitor.

One of GitHub's "recommended" marketplace features is the "stale" bot. The
purpose of this bot is to automatically close GitHub issues after a period of
inactivity, 60 days by default. You have probably encountered it yourself in the
course of your work.

This is a terrible, horrible, no good, very bad idea.

![A screenshot of an interaction with this bot](https://redacted.moe/f/e2f0d39c.png)

I'm not sure what motivates maintainers to install this on their repository,
other than the fact that GitHub recommends it to them. Perhaps it's motivated by
a feeling of shame for having a lot of unanswered issues? If so, this might stem
from a misunderstanding of the responsibilities a maintainer has to their
project. You are not obligated to respond to every issue, implement every
feature request, or fix every bug, or even acknowledge them in any way.

Let me offer you a different way of thinking about issues: a place for motivated
users to collaborate on narrowing down the problem and planning a potential fix.
A space for the community to work, rather than an action item for you to deal
with personally. It gives people a place to record additional information, and,
ultimately, put together a pull request for you to review. It does not matter if
this process takes days or weeks or years to complete. Over time, the issue will
accumulate details and workarounds to help users identify and diagnose the
problem, and to provide information for the person that might eventually write a
patch/pull request.

It's entirely valid to just ignore your bug tracker entirely and leave it up to
users to deal with themselves. There is no shame in having a lot of open issues
&mdash; if anything, it signals popularity. Don't deny your users access to an
important mutual support resource, and a crucial funnel to bring new
contributors into your project.

This is the approach I would recommend on GitHub, but for illustrative purposes
I'll also explain a slightly modified approach I encourage for SourceHut users.
sr.ht provides mailing lists (and, soon, IRC chat rooms), which are recommended
for first-line support and discussion about your project, including bug reports,
troubleshooting, and feature requests, instead of filing a ticket (our name for
issues). The mailing list gives you a space to refine the bug report, solicit
extra details or point out an existing ticket, or clarifying and narrowing down
feature requests. This significantly improves the quality of bug reports,
eliminates duplicates, and better leverages the community for support, resulting
in every single ticket representing a unique, actionable item.

I will eventually ask the user to file a ticket when the bug or feature request
is confirmed. This does not imply that I will follow up with a fix or
implementation on any particular time frame. It just provides this space I
discussed before: somewhere to collect more details, workarounds, and additional
information for users who experience a bug or want a feature, and to plan for
its eventual implementation at an undefined point in the future, either from a
SourceHut maintainer or from the community.
