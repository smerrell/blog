---
layout: post
title: "Shell Scripting and Git Fun"
date: 2012-10-26 16:48:00
comments: true
tags:
- bash
- git
- shell-scripting
---

This afternoon I got the urge to whip up a quick script to help me when using
git and a GitHub hosted repository. Quite often I want to look at the GitHub
page of a project I'm working on when I'm sitting on the command line in the
repository. So I figured, how could I go about making it easier to open that URL
without having to find the link in Chrome or on GitHub's site. Shell scriping to
the rescue!

I realized with a little bit of text manipulation, I could get the `git remote
show` command to help me out. So I took the output

```bash
$ git remote show origin
* remote origin
  Fetch URL: git@github.com:smerrell/dotfiles.git
  Push  URL: git@github.com:smerrell/dotfiles.git
  HEAD branch: master
  Remote branches:
    gh-pages tracked
    master   tracked
  Local branch configured for 'git pull':
    master merges with remote master
  Local ref configured for 'git push':
```

And grepped it on Fetch URL leaving me with `Fetch URL:
git@github.com:smerrell/dotfiles.git`. From there I cut the first 14 characters
using `cut -c 14-` leaving me with just the git url I was looking for. With just
the URL left, I got working on crafting a Sed command to manipulate the URL to
what I needed, coming up with this:

```bash
sed -r -e 's/\w+@/http:\/\//' -e 's/\.git$//'
-e 's/\.com:/.com\//' -e's/git:/http:/'
```

This command just replaces the *git@* part with *http* instead, I then stripped
off the *.git* and *.com:* with *.com/*. producing the desired
`http://github.com/smerrell/dotfiles`. Awesome!

Once I had the URL I wanted, it became pretty simple to open up the url using my
default browser. I simply call `start` and gave it the url.

**OSX Support**

After getting this all working on my Windows box at work, I had to see if this
would work on OS X. Being confident in my skills I just copied the file over to
my Mac, dropped it in the bin and happily tried to run it... Until it blew up on
me.

First, I had to remember that on Windows you use `start` but on OS X you need to
use `open`. That was easy enough though, I just added a quick check to see if
I'm on OS X or Windows and set a variable `opencmd` to the right thing. But then
the painful part hit me.

This is when I learned the painful difference between Gnu-based tools and BSD
tools. Sed was very unhappy with the parameters I was trying to pass into it.
Specifically the -r parameter. The script above uses extended regex to get the
special characters of `\w` and `+`. Unfortunately BSD Sed uses the `-E` flag while Gnu
Sed uses the `-r` flag.

Fortunately this is pretty easy to work around as I store the extendedRegex flag
in my script and set it depending on the OS I'm on.

The most annoying difference between Gnu Sed and BSD sed though, is the support
of Regular Expression Metacharacters. In BSD sed, you do not get the
metacharacters, so `\w` must become `[[:space:]]`. So now I know a painful
difference between Gnu Sed regex extensions and BSD regex extensions. After I
replaced the metacharacters I was using with their full version, I ran the
script again and it worked! So I now have an easy way to open a GitHub repo from
the command line.

I still have many imrovements I could make to this script, but I'm pretty happy
with how it turned out after putting about a half hour of work into it. Below is
the file in its entirety and you can find it on
[GitHub](https://github.com/smerrell/dotfiles/blob/master/bin/view-remote) as
well. Feel free to borrow the script and use it if you find it useful. I'd love
to get some feedback on ways to improve what I have so far.
