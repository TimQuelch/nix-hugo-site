---
date: 2020-07-14
title: March 2nd, 1943
layout: post
tags: [time]
---

It's March 2nd, 1943. The user asks your software to schedule a meeting with
Acmecorp at "9 AM on the first Monday of next month".

<pre>
<code>
[6:17:45] homura ~ $ cal -3 2 March 1943
    February 1943          March 1943            April 1943
Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6      1 <span style="background: black; color: white"> 2</span> 3  4  5  6               1  2  3
 7  8  9 10 11 12 13   7  8  9 10 11 12 13   4 <span style="background: #666; color: white"> 5</span>  6  7  8  9 10
14 15 16 17 18 19 20  14 15 16 17 18 19 20  11 12 13 14 15 16 17
21 22 23 24 25 26 27  21 22 23 24 25 26 27  18 19 20 21 22 23 24
28                    28 29 30 31           25 26 27 28 29 30
</code>
</pre>

Right now, California is on Pacific Standard Time (PST) and Arizona is on
Mountain Standard Time (MST). On March 8th, California will transition to
Pacific Daylight Time (PDT), one hour ahead. Arizona does not observe DST, so
they'll stay behind.

At least until April 1st &mdash; when the governor will sign an emergency order
moving the state to MDT, effective immediately.

Back on March 2nd, you send an email to each participant telling them about the
meeting. One of them has their locale set to en_GB, so some of the participants
need to be sent "04/05/43" and some "05/04/43".

A moment later, the user asks you to tell it the number of hours betweeen now
and the meeting they just scheduled. The subject of the meeting is purchasing
fuel for a machine that the user is now filling with enough fuel to last until
then.

On the day of the meeting, the user drives to the Navajo reservation to conduct
some unrelated business, and has to attend the meeting by phone. The reservation
has been on daylight savings time since March 8th, by the way, they never stayed
behind with the rest of Arizona. The user expects the software to warn them 1
hour prior to the meeting start. The border of the reservation is defined by a
river, which is slowly moving East.[^1]

[^1]: Okay, that last bit isn't true. But imagine if it was!

[The changelog for the IANA zoneinfo database](https://mm.icann.org/pipermail/tz-announce/)
is great, by the way, you should read it.
[Or subscribe](https://mm.icann.org/mailman/listinfo/tz-announce) to get it
periodically[^2] material delivered to your inbox!

[^2]: But with what period? 😉
