---
date: 2019-03-11
layout: post
title: Announcing the release of sway 1.0
tags: ["wayland", "sway", "announcement"]
---

1,315 days after I started the [sway](https://swaywm.org) project, it's finally
time for [sway 1.0](https://github.com/swaywm/sway/releases/tag/1.0)! I had no
idea at the time how much work I was in for, or how many talented people would
join and support the project with me. In order to complete this project, we have
had to rewrite the entire Linux desktop nearly from scratch. Nearly 300 people
worked together, together writing over 9,000 commits and almost 100,000 lines of
code, to bring you this release.

<small class="text-muted">Sway is an i3-compatible Wayland desktop for Linux and FreeBSD</small>

1.0 is the first stable release of sway and represents a consistent, flexible,
and powerful desktop environment for Linux and FreeBSD. We hope you'll enjoy it!
If the last sway release you used was 0.15 or earlier, you're in for a shock.
0.15 was a buggy, frustrating desktop to use, but sway 1.0 has been completely
overhauled and represents a much more capable desktop. It's almost impossible to
summarize all of the changes which makes 1.0 great. Sway 1.0 adds a huge variety
of features which were sorely missed on 0.x, improves performance in every
respect, offers a more faithful implementation of Wayland, and exists as a
positive political force in the Wayland ecosystem pushing for standardization
and cooperation among Wayland projects.

When planning the future of sway, we realized that the Wayland ecosystem was
sorely in need of a stable & flexible common base library to encapsulate all of
the difficult and complex facets of building a desktop. To this end, I decided
we would build [wlroots](https://github.com/swaywm/wlroots). It's been a
smashing success. This project has become very important to the Linux desktop
ecosystem, and the benefits we reap from it have been shared with the community
at large. [Dozens of projects][project-list] are using it today, and soon you'll
find it underneath most Linux desktops, on your phone, in your VR environment,
and more. Its influence extends beyond its borders as well, as we develop and
push for standards throughout Wayland.

[project-list]: https://github.com/swaywm/wlroots/wiki/Projects-which-use-wlroots

Through this work we have also helped to build a broader ecosystem of tools
built on interoperable standards which you may find useful in your new sway 1.0
desktop. Here are a few of my favorites - each of which is compatible with many
Wayland compositors:

- [swayidle](https://github.com/swaywm/swayidle): idle management daemon
- [swaylock](https://github.com/swaywm/swaylock): lock screen
- [mako](https://github.com/emersion/mako): notification daemon
- [grim](https://github.com/emersion/grim): screenshot tool
- [slurp](https://github.com/emersion/slurp): interactive region selection
- [wf-recorder](https://github.com/ammen99/wf-recorder): video capture tool
- [waybar](https://github.com/Alexays/Waybar): alternative panel
- [virtboard](https://source.puri.sm/Librem5/virtboard): on-screen keyboard
- [wl-clipboard](https://github.com/bugaevc/wl-clipboard): xclip replacement
- [wallutils](https://github.com/xyproto/wallutils): fancy wallpaper manager

---

None of this would be possible without the support of sway's and wlroots'
talented contributors. Hundreds of people worked together on this. I'd like to
give special thanks to our core contributors: Brian Ashworth, Ian Fan, Ryan
Dwyer, Scott Anderson, and Simon Ser. Thanks are also in order for those who
have helped wlroots fit into the broader ecosystem - thanks to Purism for their
help on wlroots, KDE & Canonical for their help on protocol standardization. I
also owe thanks to all of the other projects which use wlroots, particularly
including Way Cooler, Wayfire, and Waymonad, who all have made substantial
contributions to wlroots in their pursit of the best Wayland desktop.

I'd also of course like to thank all of the users who have donated to support
my work, which I now do full-time, which has had and I hope will continue to
have a positive impact on the project and those around it. Please consider
[donating](https://drewdevault.com/donate) to support the future of sway &
wlroots if you haven't yet.

Though sway today is already stable and powerful, we're not done yet. We plan to
continue improving performance & stability, adding useful desktop features,
taking advantage of better hardware, and bringing sway to more users. Here's
some of what we have planned for future releases:

- Better Wayland-native tools for internationalized input methods like CJK
- Better accessibility tools including improved screen reader support,
  high-contrast mode, a magnifying glass tool, and so on
- Integration with xdg-portal & pipewire for interoperable screen capture
- Improved touch screen support for use on the [Librem
  5](https://puri.sm/products/librem-5/) and on
  [postmarketOS](https://postmarketos.org/)
- Better support for drawing tablets and additional hardware
- Sandboxing and security features

As with all sway features, we intend to have the best-in-class implementations
of these features and set the bar as high as we can for everyone else. We're
looking forward to your continued support!
