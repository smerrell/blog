---
layout: post
title: "Automate project suckage away"
date: 2012-11-02 16:23:00
comments: true
tags:
- automation
- dev-setup
---

How much tedious work is involved in setting up and developing individual
projects at your work? In my [first post](/blog/2012/10/19/chocolatey-machine-setup)
I wrote about how much tedious work is involved in setting up a new machine, now
let's dig a little deeper to the project level.

Automation at the project level is very much in line with Zach Holman's talk on
automating machine setup. In his talk he mentions that each project has it's own
setup scripts to get things up and running quickly. While working on a project
at work, I've come to realize how important automation is inside of individual
projects as well. Automating processes inside a project can help in many ways.
First, it makes us developers happy. We no longer have to keep doing the same
boring thing over and over, and second it means the tedious task is done
consistently and without error instead of by an error-prone manual process.

**Windows Workflow Foundation...**

The project at work that my team and I have been working on is called the IVR.
It is the first thing a retiree interacts with when they call into our call
center. Unfortunately the project for the IVR uses Windows Workflow Foundation
which is... terrible to work with. Since it is a Microsoft product, the decision
was to make the configuration and designing of the workflow using a GUI.
Through that GUI the workflows are generated in a relatively unflattering XML
representation. These are the .xoml files and the xoml rules files.

To allow for dynamically changing how the call flow works, we've loaded the xoml
files and the grammars into the database. The xoml files control the overall
flow of someone calling in and the grammars are used to recognize phrases or
dial tones the person calling in says or dials (i.e. Say foo to go to bar or
press 1). This works well for us having these files loaded into the database
since we get a lot of flexibility in changing the IVR without redeploying.
Unfortunately for us, Windows Workflow Foundation's editor of the xoml files
screws them up if you open them. The problem is in declaring what assembly the
worfklows use. It adds a specific version of the assemblies for the xoml files
and doesn't fully declare the right namespace for the rules file.

This makes it extremely tedious to modify any of our workflows because you have
one of two options. Either you just don't use the editor and modify the xml
directly or you deal with the changes the editor makes and you go back and fix
it later. Either way really sucks since it involves so much tedious work.
Fortunately for us, my coworker [Bob](http://paceyourself.net) got tired of
fixing the files over and over by hand.

**Rake to the rescue**

What Bob did was to make a couple rake tasks that go through every xoml file and
rule file and uses a regex to remove the specific assembly versions, and add the
missing declarations from the rule files. This has saved us so much time and
headache from deploying the new changes and having it crash because it was
looking for a specific assembly version.

Not only that, but he added a rake task to add the new xoml and rule file
declarations into a sql script so we can easily run the script and insert it
into the database saving us even more time. The great thing about this is that
it has saved us a significant amount of time and greatly reduced our frustration
with the project.

**Automation FTW**

Even just these little bits of automation have significantly improved the ease
of working on the project. We've already talked about next steps on making
things even easier to use. The biggest improvement being a way to automatically
deploy the sql scripts we've generated and deploy the dlls to our dev server.
This experience has really shown me how much nicer development can be with
seemingly simple automation tasks to reduce the tedious, manual work that can be
involved with some projects.
