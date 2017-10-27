---
title: Agile is Hard
date: 2012-12-14 16:00:00
comments: true
tags:
- agile
- scrum
- kanban
- retrospective
---

Agile. Such a broad topic with so much to discuss and so much already discussed.
It really is one of those topics you can go on about forever. So how am I going
to put my spin on things? Well, I'm not I'm just going to talk about what I've
learned so far in over a year of really trying to do agile the right way and
hopefully I'll have learned something as well as you, the reader.

# Scrum Time

A little over a year ago we decided at work that the way we were doing things
could really use some improvement. We were using Agile Zen and its online Kanban
board but instead of embracing Kanban and continuous flow we basically were
working in a waterfall manner.

Fortunately for me, I got pulled onto a new team that was working on a new
product to support our call center's onboarding of agents. Since we were on a
new team we also were tasked with really digging in and giving scrum a go. We
gathered our new team of joint QA and Dev, read a couple books, got a scrum
consultant, set up our white board and we were off estimating our stories and
slapping them up on the board.

# Two weeks

It really was great starting out. It was the first time for me to really get
more interaction with the business and learn a ton about the domain. We also had
decided to give one week iterations a try and deliver what we could within that
time frame. I was really onboard with the one week iteration idea since about a
year before that I had read Kent Beck's [Extreme Programming
Explained](http://www.amazon.com/Extreme-Programming-Explained-Embrace-Edition/dp/0321278658/ref=dp_ob_title_bk)
and really felt it would help keep us on track.

Unfortunately for us one week iterations just felt like too much so that lasted
only a couple weeks until we decided to change our sprints to two weeks and have
more breathing room. We also had the typical growing pains of trying to figure
out how to actually estimate stories and become better with our estimations. We
also worked on keeping our discipline of writing tests first and really being
TDD focused.

Over the last year we feel like we've gotten pretty good at most of these
things, but over time I've noticed a few bad habits creep in and as a whole I've
noticed some questioning of the methods we've been using.

# Things don't seem quite right

I began to notice that things with our development process didn't seem quite
right. We had begun to fall into a trend of consistently going over our two week
iterations by a few days. We were beginning to leave QA behind and move forward
when we were "dev complete". As I started to feel like we were doing it wrong
Jeremy Miller wrote a post about (not the book, mind you) "[Code Complete is
polite
fiction](http://jeremydmiller.com/2012/12/13/code-complete-is-a-polite-fiction-done-done-done-is-the-hard-truth/)".

Since Jeremy's post better explains how I was feeling, please read that.
Basically we had fallen into the quagmire of "trailer-hitched QA" as Uncle Bob
Martin called it. Instead of staying focused and being done-done-done we were
slipping into the bad habit of saying we were done earlier in the sprint that we
really were.

# Round two

So recently we have decided to try and give Kanban a real try after learning so
much with our time using Scrum. One nice thing about Kanban is that it isn't
really prescriptive. I've always found scrum a bit grating that way just because
you start out with a rigid set of rules you're supposed to follow until you are
comfortable. From there, you can decide what is or isn't working, the hardest
part there though, is uprooting all your processes to implement Scrum.

Moving forward I think the next couple steps we'll be taking is to really reduce
the work in progress to a manageable level. One of the worst symptoms I see of
trailer-hitched QA is that you have a dozen or more features or bug fixes all
being worked on at a time. It gets very confusing to keep track of everything in
flight and make sure it gets out the door in good shape.

From just reducing our work in progress I imagine we'll begin to see more
clearly where our processes are causing bottlenecks and work towards fixing
them. Instead of uprooting everything and starting over, we continually improve
to make the processes we have now better and more effective. Most importantly
the long term effect is we developers are happier, QA is happier, and our
business is happier with the work we're doing. And for me, that is an all around
win.
