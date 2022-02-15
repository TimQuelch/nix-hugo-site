---
title: Status update, February 2022
date: 2022-02-15
#outputs: [html, gemtext]
---

Hello once again! Another month of free software development goes by with lots
of progress in all respects.

I will open with some news about [godocs.io]: version 1.0 of [our fork of gddo]
has been released! Big thanks to Adnan Maolood for his work on this. I'm very
pleased that, following our fork, we were not only able to provide continuity
for godoc.org, but also to simplify, refactor, and improve the underlying
software considerably. Check out [Adnan's blog post] for more details.

[godocs.io]: https://godocs.io
[our fork of gddo]: https://sr.ht/~sircmpwn/godocs.io
[Adnan's blog post]: https://adnano.co/2022/02/10/godocs.io-one-year-later/

In programming language news, we have had substantial progress in many respects.
One interesting project I've started is a Redis protocol implementation:

```hare
const conn = redis::connect()!;
defer redis::close(&conn);

fmt::println("=> SET foo bar EX 10")!;
redis::set(&conn, "foo", "bar", 10: redis::ex)!;
```

Another contributor has been working on expanding our graphics support,
including developing a backend for [glad] to generate OpenGL bindings, and a
linear algebra library ala [glm] for stuff like vector and matrix manipulation.
Other new modules include a [MIME database] and encoding::base32. Cryptography
progress continued with the introduction of XTS mode for AES, which is useful
for full disk encryption implementations, but has slowed while we develop bigint
support for future algorithms like RSA. I have also been rewriting the language
introduction tutorial with a greater emphasis on practical usage.

[glad]: https://github.com/Dav1dde/glad
[glm]: https://glm.g-truc.net/
[mime database]: https://drewdevault.com/2022/01/28/Implementing-mime-in-xxxx.html

Before we move on from the language project: I need your help! I am looking for
someone to help develop terminal support. This is fairly straightforward, though
laborsome: it involves developing libraries in our language which provide the
equivalents of something like ncurses (or, better, [libtickit]), as well as the
other end like [libvterm] offers. Please [email me] if you want to help.

[libtickit]: http://www.leonerd.org.uk/code/libtickit/
[libvterm]: http://www.leonerd.org.uk/code/libvterm/
[email me]: mailto:sir@cmpwn.com

In SourceHut news, we have [hired] our third full-time engineer: Conrad
Hoffmann! Check out the blog post for details. The first major effort from
Adnan's NLnet-sponsored SourceHut work also landed yesterday, introducing
GraphQL-native webhooks to git.sr.ht alongside a slew of other improvements.
pages.sr.ht also saw some improvements that allow users to configure their
site's behavior more closely. Check out the "What's cooking" post later today
for all of the SourceHut news.

[hired]: https://sourcehut.org/blog/2022-02-02-welcome-conrad/

That's all for today, thanks for reading!
