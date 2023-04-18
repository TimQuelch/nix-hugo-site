---
title: "rc: a new shell for Unix"
date: 2023-04-18
---

[rc] is a Unix shell I've been working on over the past couple of weeks, though
it's been in the design stages for a while longer than that. It's not done or
ready for general use yet, but it is interesting, so let's talk about it.

[rc]: https://git.sr.ht/~sircmpwn/rc

As the name (which is subject to change) implies, rc is inspired by the Plan 9
[rc][plan9] shell. It's not an implementation of Plan 9 rc, however: it departs
in many notable ways. I'll assume most readers are more familiar with POSIX
shell or Bash and skip many of the direct comparisons to Plan 9. Also, though
most of the features work as described, the shell is a work-in-progress and some
of the design I'm going over today has not been implemented yet.

[plan9]: http://man.9front.org/1/rc

Let's start with the basics. Simple usage works much as you'd expect:

```
name=ddevault
echo Hello $name
```

But there's already something important that might catch your eye here: the lack
of quotes around $name. One substantial improvement rc makes over POSIX shells
and Bash right off the bat is fixing our global shell quoting nightmare. There's
no need to quote variables!

```
# POSIX shell
x="hello world"
printf '%s\n' $x
# hello
# world

# rc
x="hello world"
printf '%s\n' $x
# hello world
```

Of course, the POSIX behavior is actually useful sometimes. rc provides for this
by acknowledging that shells have not just one fundamental type (strings), but
two: strings and *lists* of strings, i.e. argument vectors.

```
x=(one two three)
echo $x(1)  # prints first item ("one")
echo $x     # expands to arguments (echo "one" "two" "three")
echo $#x    # length operator: prints 3

x="echo hello world"
$x
# echo hello world: command not found

x=(echo hello world)
$x
# hello world

# expands to a string, list values separated with space:
$"x
# echo hello world: command not found
```

You can also slice up lists and get a subset of items:

```
x=(one two three four five)
echo $x(-4) # one two three four
echo $x(2-) # two three four five
echo $x(2-4) # two three four
```

A departure from Plan 9 rc is that the list operators can be used with strings
for string operations as well:

```
x="hello world"
echo $#x     # 11
echo $x(2)   # e
echo $x(1-5) # hello
```

rc also supports loops. The simple case is iterating over the command line
arguments:

```
% cat test.rc 
for (arg) {
	echo $arg
}
% rc test.rc one two three 
one
two
three
```

{ } is a command like any other; this can be simplified to for (arg) echo
$arg. You can also enumerate any list with in:

```
list=(one two three)
for (item in $list) {
	echo $item
}
```

We also have while loops and if:

```
while (true) {
	if (test $x -eq 10) {
		echo ten
	} else {
		echo $x
	}
}
```

Functions are defined like so:

```
fn greet {
	echo Hello $1
}

greet ddevault
```

Again, any command can be used, so this can be simplified to fn greet echo $1.
You can also add named parameters:

```
fn greet(user time) {
	echo Hello $user
	echo It is $time
}

greet ddevault `{date}
```

Note the use of `{script...} instead of $() for command expansion. Additional
arguments are still placed in $*, allowing for the user to combine
variadic-style functions with named arguments.

Here's a more complex script that I run to perform sanity checks before applying
patches:

```
#!/bin/rc
fn check_branch(branch) {
	if (test `{git rev-parse --abbrev-ref HEAD} != $branch) {
		echo "Error: not on master branch"
		exit 1
	}
}

fn check_uncommitted {
	if (test `{git status -suno | wc -l} -ne 0) {
		echo "Error: you have uncommitted changes"
		exit 1
	}
}

fn check_behind {
	if (test `{git rev-list "@{u}.." | wc -l} -ne 0) {
		echo "Error: your branch is behind upstream"
		exit 1
	}
}

check_branch master
check_uncommitted
check_behind
exec git pull
```

That's a brief introduction to rc! Presently it clocks in at about 2500 lines of
Hare. It's not done yet, so don't get too excited, but much of what's described
here is already working. Some other stuff which works but I didn't mention
include:

- Boolean compound commands (x && y, x || y)
- Pipelines, which can pipe arbitrary file descriptors ("x |[2] y")
- Redirects, also including arbitrary fds ("x >[2=1] file")

It also has a [formal context-free grammar][grammar], which is a
work-in-progress but speaks to our desire to have a robust description of the
shell available for users and other implementations. We use Ember Sawady's
excellent [madeline][made] for our interactive mode, which supports command line
editing, history, ^r, and fish-style forward completion OOTB.

[grammar]: https://git.sr.ht/~sircmpwn/rc/tree/master/item/doc/grammar.txt
[made]: https://git.d2evs.net/~ecs/madeline/

Future plans include:

- Simple arithmetic expansion
- Named pipe expansions
- Sub-shells
- switch statements
- Port to [ares](https://ares-os.org)
- Find a new name, perhaps

It needs a small amount of polish, cleanup, and bugs fixed as well.

I hope you find it interesting! I will let you know when it's done. Feel free
to [play with it][rc] in the meanwhile, and maybe send some patches?
