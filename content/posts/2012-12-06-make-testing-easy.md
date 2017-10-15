---
layout: post
title: "Make Testing Easy"
date: 2012-12-06 23:26:00
comments: true
tags:
- testing
---

Testing. We all know that we should do it, and yet often times we find
ourselves struggling to stay consistent in testing our code. I know that I
personally find it difficult sometimes to really stick to and test my code,
and guess what happens when you don't test your code. It comes back to haunt
you.

I was discussing this with my coworker [Ryan](http://ryanhauert.com) about
this very problem, and it got me thinking I should write it down. (It also
helps he suggested it would be a possible blog post topic, so thanks Ryan).

# When I Test

At Extend Health, I've been working on a specific project for quite some time
now. I got the privilege to start out with a new greenfield project and have
watched it transform over the last year. When we first started out, we had to
keep our business process running by pretty much glue and duct tape to make it
through the Annual Enrollment Period. Those were rough times filled with
taking an existing Microsoft Access project and getting it to talk to SQL
server on the backend so the data was at least in one place.

It was rough, but interestingly we were determined to keep things tested.
Since basically all logic had to go into the DB at the time, we looked at SQL
testing frameworks. We stumbled on [tsqlt](http://tsqlt.org/) and found it
helped us quite a bit. But even with a testing framework we found it very
difficult to write tests.

On the next revision of our project, we got to start completely fresh and
built our system using CQRS and Event Sourcing. With a clean code base and
pretty good discipline, we were able to consistently keep our code tested and
often we wrote test first. Not always, but a good portion of the time anyway.

# Then Things Get Hard

After working on my last project, I got some time to add to a large project we
have based around WPF and [Caliburn](http://caliburn.codeplex.com/). This is
when I noticed I started to throw my testing habits out the window and just
cowboy code everything. But why would I knowingly throw testing out the
window?

Then I sat down and thought about it. What was the main thing that I was using
to justify my lack of tests, even though I know I should be doing them? It
really came down to one thing for me, testing the code base was *hard*. Boo
hoo, right? But it really comes down to friction making tests surpassing my
will to write the test.

# Well What Do We Do About This?

So what exactly do we do about this so we actually test our code? I'm going to
throw my favorite programmer answer at that one: it depends. I know, I know,
that is the lame answer but it really is true from what I can tell. Really it
just depends on if you're working with existing code or starting out fresh.
Since it isn't too common to just get a new, fresh codebase to start with lets
look at the existing code problem.

The way I see it, there really is only one way to go with an existing
solution. You can start by beefing up your test helpers to make setup as
painless as possible, and while you're doing that you get a bonus. It helps
you identify areas in your code that are very painful to test. Once you've got
your test helpers automating the suck away as much as possible, you can start
to identify the most problematic code to test.

Perhaps you have un-mockable or difficult to mock classes? God objects being
used everywhere? Either way, once you identify the problem areas you can pick
them apart one by one and write the new code using tests, of course. Obviously
it sucks to have to do this slowly but I don't really see another way to take
it besides griding down the painful pieces as you can.

# So The Moral Of The Story Is

You've got to make your code easy to test or you are going to find ways to
convince yourself you don't need to write them. Simple I know, but it helps to
stay disciplined when the code lends itself to testing. If you have a codebase
that is really difficult to test, then it is worth the investment to make it
as easy as possible. This means you can make helpers for the tests while you
chip away at the really hard parts of the code. In the end, you'll thank
yourself for doing it.
