---
layout: post
title: "Giving Sublime Text 2 A Try"
date: 2012-11-18 20:10:00
comments: true
tags:
- sublimetext
- editors
---

Looks like [Rob Conery](http://wekeroad.com/) got back in the blogging mood and
picked a rather interesting subject. His topic? The holy war prone land of text
editors Though I will say, his title for the post [Code Editor
Thunderdome](http://wekeroad.com/2012/11/18/code-editor-thunderdome). is
awesome. Acutally, the blog itself is really a pretty good read with lots of
good information for several editors that are worth checking out.

So why exactly am I writing a post about Sublime Text 2? Well because I thought
it would be something interesting. That and since I'm pretty solidly a Vim user,
I thought it might be time to at least try some other Editors. Well, that and
my boss [Corey](http://coreykaylor.com/) has been pretty excited about Sublime
for a while now. Excited enough that as a team for our morning learning we
watched a whole bunch of the [NetTuts Sublime Text
Videos](http://net.tutsplus.com/articles/news/perfect-workflow-in-sublime-text-free-course/).

With that, I'm going to try and put down my "Meh, unimpressed Vim user is
unimpressed" initial attitude and really give Sublime a try.

## The Good

Sublime definitely is really fast. Startup is super quick, I definitely like
how Sublime starts back up with what I was working on last as well. Even going
so far as having the cursor on the last line that I left off at is pretty nice.
It definitely makes thing easy when you want to close Sublime and start back up
where you left off.

Another feature I've come to really like from Sublime is the Cmd-P file
searching being built right in. With Vim I use the ctrl-p plugin which is
great, but it is not something that comes out of the box. It also requires some
fine tuning to use well. Sublime, on the other hand, has surprisingly fast
searching for files. It also has another great feature I haven't setup for Vim
yet. If you do Cmd-R you can search for methods inside of a project. This is a
really handy feature and comes with support for most of the files I use
regularly. So CSS, Ruby, JavaScript all work as I tested them.

That function there is enough to convince me to give it a try for my JavaScript
heavy projects since I don't have this feature set up for Vim. Even for the little bit of Ruby I do seems like it will be easier to work with in Sublime.

## The Bad

One thing I've found from using Sublime the last couple days annoying though is
how working the configuration into my current
[dotfiles](https://github.com/smerrell/dotfiles) setup is going to be
difficult.  Since I've spent the last several years working on my dotfiles, I
feel very inclined to add settings for my text editor. Granted, this is a bit
of a minor complaint and it isn't even something that is impossible, just more
annoying to set up than anything.

Along the lines of me wanting to store Sublime's configuration in my dotfiles
repo, I also would like to automate as much of that setup for Sublime as
possible. Since I've been a bit obsessed with automation lately, I'd love to
have a way to run a script and have sublime configured just the way I like it.
Unfortunately, I've run into a stubmling block. [Package
Control](http://wbond.net/sublime_packages/package_control), Sublime's awesome
package manager has to be installed from inside Sublime's command window.

## The Wat?

So far, Sublime has shown itself as a pretty capable editor that I've been
enjoing using lately. I've shown some good and bad impressions I got from using
it but there is one thing that feels just like a plain
[wat](https://www.destroyallsoftware.com/talks/wat) moment for me.

The first thing I decided to set up with Sublime after I got Package Control
installed was syntax highlighting for Markdown. Since I'm writing this blog
post using Sublime, I figured it would be useful. When I first installed the
Markdown Syntax highlighting I started Sublime back up using my favorite color
scheme [Solarized](http://ethanschoonover.com/solarized). Happily for me
Sublime comes with Solarized already built in, but then I started noticing
something strange.

Using the Solarized scheme, I got very little syntax highlighting when using
Solarized. To figure out what the heck was going on with this, I decided to
flip through every one of the built in color schemes. That was then i realized
each color scheme did the syntax highlighting for Markdown very differently.
Some supported very little things, others had pretty rich syntax highlighting.

To me, that just felt really strange that some color schemes would support
Markdown better than others. I'm sure there is a reasonable explanation for
this, but the first reaction I had to it was WAT?

## But Seriously

I've only been using Sublime for about a week and it does seem like a pretty
good editor. There are a lot of things that I like when compared to Vim. The
built in snippets and code completion features are pretty nice, as well as its
overall speed. Since I've only been using it for about a week I haven't even had
much time to really dig into Sublime and most of its features. When I first
started with Vim it took me months before I felt like I was really being
productive with it.

So the big question, am I going to start using Sublime as my primary text
editor? I really don't know. To me, putting my Vim setup together just right
felt a lot like a Jedi building their own lightsaber (nerdy, I know) so I have
to admit I have a strong emotional attachment to Vim. Still though, it doesn't
mean that other editors don't have a lot of value to offer so I think I'm going
to try and make more of a conscious effort to get to know Sublime more and see
where things go.
