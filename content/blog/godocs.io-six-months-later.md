---
title: godocs.io six months later
date: 2021-05-07
---

We're six months on from [forking godoc.org][0] following its upstream
deprecation, and we've made a lot of great improvements since. For those
unaware, the original godoc.org was replaced with pkg.go.dev, and a redirect was
set up. The new website isn't right for many projects &mdash; one of the most
glaring issues is the narrow list of software licenses pkg.go.dev will display
documentation for. To continue serving the needs of projects which preferred the
old website, we forked the project and set up [godocs.io](https://godocs.io).

[0]: https://drewdevault.com/2020/12/18/godocs.io.html

Since then, we've made a lot of improvements, both for the hosted version and
for the [open source project][1]. Special thanks is due to Adnan Maolood, who
has taken charge of a lot of these improvements, and also to a few other
contributors who have helped in their own small ways. Since forking, we've:

[1]: https://sr.ht/~sircmpwn/godocs.io/

- Added Go modules support
- Implemented [Gemini access](gemini://godocs.io)
- Made most of the frontend JavaScript optional and simpler
- Rewritten the search backend to use PostgreSQL

We also substantially cleaned up the codebase, removing over 37,000 lines of
code &mdash; 64% of the lines from the original code base. The third-party
dependencies to Google infrastructure have been removed and it's much easier to
run the software locally or on your intranet, too.

What we have now is still the same GoDoc: the experience is very similar to the
original godocs.org. However, we have substantially improved it: streamlining
the codebase, making the UI more accessible, and adding a few important
features; thanks to the efforts of just a small number of volunteers. We're
happy to be supporting the Go community with this tool, and looking forward to
making more (conservative!) improvements in the future. Enjoy!
