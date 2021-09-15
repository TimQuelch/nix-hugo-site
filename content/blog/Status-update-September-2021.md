---
title: Status update, September 2021
date: 2021-09-15
outputs: [html, gemtext]
---

It's a quiet, foggy morning here in Amsterdam, and here with my fresh mug of
coffee and a cuddly cat in my lap, I'd like to share the latest news on my FOSS
efforts with you. Grab yourself a warm drink and a cat of your own and let's get
started.

First, a new project: [visurf][0]. I [announced this][1] a few days ago, but the
short of it is that I am building a minimal Wayland-only frontend for the
[NetSurf][2] web browser which uses vi-inspired keybindings. Since the
announcement there has been some good progress: touch support, nsvirc, tabs, key
repeat, and so on. Some notable medium-to-large efforts ahead of us include a
context menu on right click, command completion and history, kinetic scrolling
via touch, pinch-to-zoom, clipboard support, and a readability mode. Please
help! It's pretty easy to get involved: join the IRC channel at \#netsurf on
libera.chat and ask for something to do.

[0]: https://sr.ht/~sircmpwn/visurf
[1]: https://drewdevault.com/2021/09/11/visurf-announcement.html
[2]: http://www.netsurf-browser.org

The programming language is also doing well. Following the codegen rewrite we
have completed some long-pending refactoring to parts of the language design,
which we intend to keep working on with further refinements in the coming weeks
and months. We also developed a new frontend for reading the documentation in
your terminal:

<script id="asciicast-q53ZaG138sp89gKYqo1fui9Qj" src="https://asciinema.org/a/q53ZaG138sp89gKYqo1fui9Qj.js" async></script>

Other improvements include the addition of parametric format modifiers
(`fmt::printfln("{%}", 10, &fmt::modifiers { base = strconv::base::HEX, ...  })`),
fnmatch, and (WIP) design improvements to file I/O, the latter relying on new
struct subtyping semantics. I'm hoping that we'll have improvements to the
grammar and semantics of match expressions and tagged unions in the near future,
and we are also looking into some experiments with reflection.

Many improvements have landed for SourceHut. lists.sr.ht now has a writable
GraphQL API, along with the first implementation of [GraphQL-native
webhooks][3]. Thanks to a few contributors, you can also now apply custom sorts
to your search results on todo.sr.ht, and builds.sr.ht has grown Rocky Linux
support. More details to follow in the "What's cooking" post for the SourceHut
blog.

[3]: https://sourcehut.org/blog/2021-08-25-graphql-native-webhooks/

That's all for today! Thanks for tuning in for this update, and thanks for
continuing to support our efforts. Have a great day!
