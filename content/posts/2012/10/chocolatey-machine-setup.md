---
title: Chocolatey machine setup
date: 2012-10-19 22:42:00
tags:
- automation
- dev-setup
---

How well automated is your machine setup process? After watching Zach Holman's
excellent video [Unsucking Your Teams Development Environment](http://zachholman.com/talk/unsucking-your-teams-development-environment)
I got to thinking about the setup process we have at Extend Health (who is
hiring, come work with us!). While we've always talked about smoothing out the process of setting
up a new machine, we've never actually gotten around to it. That is, until now.

For GitHub, they use what they call [The Setup](https://speakerdeck.com/u/wfarr/p/the-setup-managing-an-army-of-laptops-with-puppet)
which is a Ruby script that uses Puppet to manage all their machines. When I had
first looked at Puppet a couple years ago, Windows support was not an option. It
appears that this has changed. While we investigate using Puppet, my friend Kyle
and I have begun setting up a system that uses [Chocolatey](http://chocolatey.org) and
straight PowerShell to set up our Windows boxes.

So what exactly is Chocolatey? Chocolatey is a package manager designed for
Windows and is modeled somewhat like apt-get for Linux. Essentially it uses the
NuGet infrastructure to deliver software such as Vim or Skype. This makes
Chocolatey an attractive option because like NuGet, you can host your own feed
of software that can be installed on your machine.

Once we decided we'd go with Chocolatey we needed to set up a test base. So we
got ourselves set up with a vanilla Windows 7 VM. This works great since we can
play around with setting up a brand new Windows install and then restore when we
want to try it again. This also helped expose one of our first problems in
setting up a new machine. Chocolatey requires .NET 4.0 to be installed before it
will work.

While I'm admittedly not the biggest fan of PowerShell, when it comes to
scripting Windows to do what you want, it can definitely come in handy. [Kyle](http://kyzog.wordpress.com/)
came across a very handy PowerShell module called [PSWindowsUpdate](http://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc).
Once we got that script working and how to continue our script using elevated
permissions we were off. Here's the line we got directly from the PSWindows
update example.

```powershell
Get-WUInstall -ServiceID 9482f4b4-e343-43b6-b170-9a65bc822c77 -Title ".NET Framework 4" -AcceptAll
```
The last thing we were able to do this Friday was get PSWindows update to
install .NET 4.0 and Chocolatey! Exciting news for us because now we should be
able to take a brand new machine and install everything we need to write code at
Work.

So where do we take it from here? We've got many plans for our own setup script
but the first step is to make the initial setup from a new machine to getting
the right software installed. We've gotten .NET 4.0 out of the way but now we
need to see what other snags we may run into. We also need to see how we can get
Visual Studio 2010 and SQL Server 2012 installed. From there we'd also like to
start making profiles so QA and our DB teams can also plug into what we're
building.

Longer term, we'd also like to keep investigating what Puppet may be able to
provide and start trying out options there, but for now this is a great step
forward in automating the suck out of our setup process.
