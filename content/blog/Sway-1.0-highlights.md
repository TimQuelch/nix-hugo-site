---
date: 2018-10-20
layout: post
title: Sway 1.0-beta.1 release highlights
tags: ["announcement", "wayland", "sway"]
---

1,173 days ago, I wrote sway's [initial commit][commit], and 8,269 commits
followed[^1], written by hundreds of contributors. What started as a side
project became the most fully featured and stable Wayland desktop available, and
drove the development of what has become the dominant solution for building
Wayland compositors - [wlroots](https://github.com/swaywm/wlroots), now the
basis of 10 Wayland compositors.

[commit]: https://github.com/swaywm/sway/commit/6a33e1e3cddac31b762e4376e29c03ccf8f92107
[^1]: 5,044 sway commits and 3,225 wlroots commits at the time of writing.

Sway 1.0-beta.1 was just released and is 100% compatible with the [i3 X11 window
manager](https://i3wm.org/). It's faster, prettier, sips your battery, and
supports [Wayland](https://wayland.freedesktop.org/) clients. When we started, I
honestly didn't think we'd get here. When I decided we'd rewrite our internals
and build wlroots over a year ago, I didn't think we'd get here. It's only
thanks to an amazing team of talented contributors that we did. So what can
users expect from this release? The difference between sway 0.15 and sway 1.0 is
like night and day. The annoying bugs which plauged sway 0.15 are gone, and in
their place is a rock solid Wayland compositor with loads of features you've
been asking after for years. The [official release
notes](https://github.com/swaywm/sway/releases/tag/1.0-beta.1) are a bit thick,
so let me give you a guided tour.

## New output features

Outputs, or displays, grew a lot of cool features in sway 1.0. As a reminder,
you can get the names of your outputs for use in your config file by using
`swaymsg -t get_outputs`. What can you do with them?

To rotate your display 90 degrees, use:

    output DP-1 transform 90

To enable our improved HiDPI support[^2], use:

    output DP-1 scale 2

[^2]: Sway now has the best HiDPI support on Linux, period.

Or to enable fractional scaling (see man page for warnings about this):

    output DP-1 scale 1.5

You can also now run sway on multiple GPUs. It will pick a primary GPU
automatically, but you can override this by specifying a list of card names at
startup with `WLR_DRM_DEVICES=card0:card1:...`. The first one will do all of the
rendering and any displays connected to subsequent cards will have their buffers
copied over.

Other cool features include support for daisy-chained DisplayPort configurations
and improved Redshift support. Also, the long annoying single-output limitation
of wlc is behind us: you can now drag windows between outputs with the mouse.

See `man 5 sway-output` for more details on configuring these features.

## New input features

Input devices have also matured a lot. You can get a list of their identifiers
with `swaymsg -t get_inputs`. One oft requested feature was a better way of
configuring your keyboard layout, which you can now do in your config file:

```
input "9456:320:Metadot_-_Das_Keyboard_Das_Keyboard" {
    xkb_options caps:escape
    xkb_numlock enabled
}
```

We also now support drawing tablets, which you can bind to a specific output:

```
input "1386:827:Wacom_Intuos_S_2_Pen" {
    map_to_output DP-3
}
```

You can also now do crazy stuff like having multiple mice with multiple cursors,
and linking keyboards, mice, drawing tablets, and touchscreens to each other
arbitrarily. You can now have your dvorak keyboard for normal use and a second
qwerty keyboard for when your coworker comes over for a pair programming
session. You can even give your coworker the ability to focus and type into
*separate* windows from what you're working on.

## Third-party panels, lockscreens, and more

Our new layer-shell protcol is starting to take hold in the community, and
enables the use of even more third-party software on sway. One of our main
commitments to you for sway 1.0 and wlroots is to break the boundaries between
Wayland compositors and encourange standard interopable protocols - and we've
done so. Here are some interesting third-party layer-shell clients in the wild:

- [Waybar](https://github.com/Alexays/Waybar), a new panel
- [mako](https://github.com/emersion/mako), a notification daemon
- [virtboard](https://source.puri.sm/Librem5/virtboard), an on-screen keyboard
- [slurp](https://github.com/emersion/slurp), a tool to interactively select a
  region of the screen
- [Phosh](https://source.puri.sm/Librem5/phosh), the [Purism](https://puri.sm/)
  team's shell for their [Librem 5](https://puri.sm/shop/librem-5/) phone

We also added two new protocols for capturing your screen: screencopy and
dmabuf-export, respectively these are useful for screenshots and real-time
screen capture, for example to live stream on Twitch. Some third-party software
exists for these, too:

- [grim](https://github.com/emersion/grim), for taking screenshots
- [wlstream](https://github.com/atomnuker/wlstream), for recording video

## DPMS, auto-locking, and idle management

Our new `swayidle` tool adds support for all of these features, and even works
on other Wayland compositors. To configure it, start by running the daemon in
your sway config file:

```
exec swayidle \
    timeout 300 'swaylock -c 000000' \
    timeout 600 'swaymsg "output * dpms off"' \
       resume 'swaymsg "output * dpms on"' \
    before-sleep 'swaylock -c 000000'
```

This example will, after 300 seconds of inactivity, lock your screen. Then after
600 seconds, it will turn off all of your outputs (and turn them back on when
you wiggle the mouse). This configuration also locks your screen before your
system goes to sleep. None of this will happen if you're watching a video on a
supported media player (mpv, for example). For more details check out `man
swayidle`.

## Miscellaneous bits

There are a few other cool features I think are worth briefly mentioning:

- `bindsym --locked`
- swaylock has a config file now
- Drag and drop is supported
- Rich content (like images) is synced between the Wayland and X11 clipboards
- The layout is updated atomically, meaning that you'll never see an in-progress
  frame when resizing windows
- Primary selection is implemented and synced with X11
- Pretty much every long-standing bug has been fixed

For the full run-down see the [release
notes](https://github.com/swaywm/sway/releases/tag/1.0-beta.1). Give the beta a
try, and we're all looking forward to sway 1.0!
