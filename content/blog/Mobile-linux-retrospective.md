---
title: Throwing in the towel on mobile Linux
date: 2023-06-16
---

I have been tinkering with mobile Linux -- a phrase I will use here to describe
any Linux distribution other than Android running on a mobile device -- as my
daily driver since about 2019, when I first picked up the PinePhone. For about 3
years I have run mobile Linux as my daily driver on my phone, and as of a few
weeks ago, I've thrown in the towel and switched to Android.

The distribution I ran for the most time is [postmarketOS], which I was mostly
quite happy with, running at times sxmo and Phosh. I switched to [UBports] a
couple of months ago. I have tried a variety of hardware platforms to support
these efforts, namely:

[postmarketOS]: https://postmarketos.org/
[UBports]: https://ubports.com/en/

* Pinephone (pmOS)
* Pinephone Pro (pmOS)
* Xiaomi Poco F1 (pmOS)
* Fairphone 4 (UBports)

I have returned to LineageOS as my daily driver and closed the book on mobile
Linux for the time being. What put the final nails in the coffin was what I have
been calling out as my main concern throughout my experience: reliability,
particularly of the telephony components.

<table>
  <thead>
    <tr>
      <th>Use-case</th>
      <th>Importance</th>
      <th>postmarketOS</th>
      <th>UBports</th>
      <th>LineageOS</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Basic system reliability</td>
      <td class="blue">5</td>
      <td class="red">2</td>
      <td class="blue">4</td>
      <td class="blue">5</td>
    </tr>
    <tr>
      <td>Mobile telephony</td>
      <td class="blue">5</td>
      <td class="yellow">3</td>
      <td class="yellow">3</td>
      <td class="blue">5</td>
    </tr>
    <tr>
      <td>Hotspot</td>
      <td class="blue">4</td>
      <td class="blue">5</td>
      <td class="yellow">3</td>
      <td class="blue">5</td>
    </tr>
    <tr>
      <td>2FA</td>
      <td class="blue">4</td>
      <td class="blue">4</td>
      <td class="red">1</td>
      <td class="blue">5</td>
    </tr>
    <tr>
      <td>Web browsing</td>
      <td class="blue">4</td>
      <td class="blue">5</td>
      <td class="red">2</td>
      <td class="blue">4</td>
    </tr>
    <tr>
      <td>Mobile banking</td>
      <td class="blue">4</td>
      <td class="red">1</td>
      <td class="red">1</td>
      <td class="blue">5</td>
    </tr>
    <tr>
      <td>Bluetooth audio</td>
      <td class="yellow">3</td>
      <td class="blue">4</td>
      <td class="red">2</td>
      <td class="blue">4</td>
    </tr>
    <tr>
      <td>Music player</td>
      <td class="yellow">3</td>
      <td class="blue">4</td>
      <td class="red">1</td>
      <td class="yellow">3</td>
    </tr>
    <tr>
      <td>Reading email</td>
      <td class="yellow">3</td>
      <td class="red">1</td>
      <td class="yellow">3</td>
      <td class="blue">4</td>
    </tr>
    <tr>
      <td>Navigation aid</td>
      <td class="yellow">3</td>
      <td class="red">2</td>
      <td class="red">1</td>
      <td class="blue">5</td>
    </tr>
    <tr>
      <td>Camera</td>
      <td class="yellow">3</td>
      <td class="yellow">3</td>
      <td class="yellow">3</td>
      <td class="blue">5</td>
    </tr>
    <tr>
      <td>Password manager</td>
      <td class="yellow">3</td>
      <td class="blue">5</td>
      <td class="red">1</td>
      <td class="red">1</td>
    </tr>
    <tr>
      <td>sysadmin</td>
      <td class="yellow">3</td>
      <td class="blue">5</td>
      <td class="red">2</td>
      <td class="yellow">3</td>
    </tr>
  </tbody>
</table>

<details style="margin-top: 1rem">
  <summary>More on these use-cases and my experiences</summary>

  **Mobile banking**: only available through a proprietary vendor-provided
  Android app. Tried to get it working on Waydroid; did not work on pmOS and
  almost worked on UBports, but Waydroid is *very* unreliable. Kind of shit but
  I don't have any choice because my bank requires it for 2FA.

  **Web browsing**: I can just run Firefox upstream on postmarketOS. Amazing!
  UBports cannot do this, and the available web browsers are not nearly as
  pleasant to use. I run Fennic on Android and it's fine.

  **Music player**: the music player on UBports is *extremely* unreliable.

  **Reading email**: This is not entirely pmOS's fault; I could have used my
  main client, aerc, which is a testament to pmOS's general utility, but it is a
  TUI that is uncomfortable to use on a touchscreen-only device.

  **Password manager**: pmOS gets 5/5 because I could use the password manager I
  wrote myself, [himitsu](https://himitsustore.org), out of the box.
  Non-critical use-case because I could just type passwords in manually on the
  rare occasion I need to use one.

  **sysadmin**: stuff like being able to SSH into my production boxes from
  anywhere to troubleshoot stuff.
</details>

Among these use-cases, there is one that absolutely cannot be budged on: mobile
telephony. My phone is a critical communication device and I need to be able to
depend on calls and SMS at all times, therefore the first two rows need to score
4 or 5 before the platform is suitable for my use. I remember struggling with
postmarketOS while I was sick with a terrible throat infection -- and I could
not call my doctor. Not cool.

I really like these projects and I love the work that's going into them.
postmarketOS in particular: being able to run the same environment I run
everywhere else, Alpine Linux, on my phone, is fucking amazing. The experience
is impressively complete in many respects, all kinds of things, including things
I didn't expect to work well, work great. In the mobile Linux space I think it's
the most compelling option right now.

But pmOS really suffers from reliability issues -- both on edge and on stable it
seemed like every update broke some things and fixed others, so only a subset of
these cool features was working well at any given moment. The breakage would
often be minor nuisances, such as the media controls on my bluetooth headphones
breaking in one update and being fixed in the next, or major showstoppers such
as broken phone calls, SMS, or, in one case, all of my icons disappearing from
the UI (with no fallback in most cases, leaving me navigating the UI blind).

So I tried UBports instead, and despite the general lack of good auxiliary
features compared to pmOS, the core telephony was more reliable -- for a while.
But once issues started to appear, particularly around SMS, I could not tolerate
it for long in view of the general uselessness of the OS for anything else. I
finally gave it up and installed LineageOS.

Mobile Linux is very cool and the community has made tremendous, unprecedented
progress towards realizing its potential, and the forward momentum is still
strong. I'm excited to see it continue to improve. But I think that before
anyone can be expected to use this as a daily driver, the community really needs
to batten down the hatches and focus on one thing and one thing only: always,
*always* being usable as a phone. I'll be back once more reliability is in
place.
