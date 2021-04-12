---
title: The Developer Certificate of Origin is a great alternative to a CLA
date: 2021-04-12
outputs: [html, gemtext]
---

Today Amazon released their fork of ElasticSearch, [OpenSearch][0], and I want
to take a moment to draw your attention to one good decision in particular: its
use of the [Developer Certificate of Origin][1] (or "DCO").

[0]: https://github.com/opensearch-project/OpenSearch
[1]: https://github.com/opensearch-project/OpenSearch/blob/main/CONTRIBUTING.md#developer-certificate-of-origin

---

Previously:

- [ElasticSearch does not belong to Elastic](https://drewdevault.com/2021/01/19/Elasticsearch-does-not-belong-to-Elastic.html)
- [Open source means surrendering your monopoly over commercial exploitation](https://drewdevault.com/2021/01/20/FOSS-is-to-surrender-your-monopoly.html)
- [Don't sign a CLA](https://drewdevault.com/2018/10/05/Dont-sign-a-CLA.html)

---

Elastic betrayed its community when they changed to a proprietary license.  We
could have seen it coming because of a particular trait of their contribution
process: the use of a Contributor License Agreement, or CLA. In principle, a CLA
aims to address legitimate concerns of ownership and copyright, but in practice,
they are a promise that one day the stewards of the codebase will take your work
and relicense it under a nonfree license. And, ultimately, this is exactly what
Elastic did, and exactly what most other projects which ask you to sign a CLA
are *planning* to do. If you ask me, that's a crappy deal, and I refrain from
contributing to those projects as a result.

However, there are some legitimate questions of ownership which a project owner
might rightfully wish to address before accepting a contribution. As is often
the case, we can look to git itself for an answer to this problem. Git was
designed for the Linux kernel, and patch ownership is a problem they faced and
solved a long time ago. Their answer is the [Developer Certificate of
Origin](https://developercertificate.org/), or DCO, and tools for working with
it are already built into git.

git provides the -s flag for git commit, which adds the following text to your
commit message:

```
Signed-off-by: Drew DeVault <sir@cmpwn.com>
```

The specific meaning varies from project to project, but it is usually used to
indicate that you have read and agreed to the DCO, which reads as follows:

> By making a contribution to this project, I certify that:
> 
> 1. The contribution was created in whole or in part by me and I have the right
>    to submit it under the open source license indicated in the file; or
> 2. The contribution is based upon previous work that, to the best of my
>    knowledge, is covered under an appropriate open source license and I have
>    the right under that license to submit that work with modifications,
>    whether created in whole or in part by me, under the same open source
>    license (unless I am permitted to submit under a different license), as
>    indicated in the file; or
> 3. The contribution was provided directly to me by some other person who
>    certified (1), (2) or (3) and I have not modified it.
> 4. I understand and agree that this project and the contribution are public
>    and that a record of the contribution (including all personal information I
>    submit with it, including my sign-off) is maintained indefinitely and may
>    be redistributed consistent with this project or the open source license(s)
>    involved.

This neatly answers all concerns of copyright. You license your contribution
under the original license (Apache 2.0 in the case of OpenSearch), and attest
that you have sufficient ownership over your changes to do so. You retain your
copyright and you don't leave the door open for the maintainers to relicense
your work under some other terms in the future. This offers the maintainers the
same rights that they extended to the community themselves.

This is the strategy that Amazon choose for OpenSearch, and it's a good thing
they did, because it strongly signals to the community that it will not fall to
the same fate that ElasticSearch has. By doing this, they have imposed on
themselves a great deal of difficulty to any future attempt to change their
copyright obligations. I applaud Amazon for this move, and I'm optimistic about
the future of OpenSearch under their stewardship.

If you have a project of your own that is concerned about the copyright of
third-party contributions, then please consider adopting the DCO instead of a
CLA. And, as a contributor, if someone asks you to sign a CLA, consider
withholding your contribution: a CLA is a promise to the contributors that
someday their work will be taken from them and monetized to the exclusive
benefit of the project's lords. This affects my personal contributions, too
&mdash; for example, I avoid contributing to Golang as a result of their CLA
requirement. Your work is important, and the projects you offer it to should
respect that.
