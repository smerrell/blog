---
title: "Getting to Know Swift"
description: Native iOS and macOS development
date: 2017-11-04T16:32:53-06:00
tags: [ "Swift" ]
categories:
    - "Development"
    - "Swift"
---
{{< figure src="/images/posts/app-development-with-swift.jpg" class="figure--right" >}}For the last several years I've primarily been a backend developer using C# and
occasionally doing work on the frontend with JavaScript. I've dabbled in
learning [Rust](https://www.rust-lang.org/en-US/) as well but I wanted to try my
hand at writing native iOS and macOS applications for a change.

After doing some research on where to begin, I started reading the book [App Development with Swift](https://itunes.apple.com/us/book/app-development-with-swift/id1219117996?mt=11)
by Apple. This book has been a great guide for learning Swift through developing
iOS applications. The book is broken up into distinct sections where they teach
you features of Swift and then show you how to use them when writing many iOS
applications. Apple wrote this book to be used in classrooms but I've been
following along on my own time during the evenings.

The book has you do bunches of small projects in XCode which has been extremely
helpful in learning XCode. Since I'm a Vim person I've found it extremely
difficult -- but worth it -- to learn the native keyboard shortcuts on the Mac
as well as in XCode itself. Having to do so many different projects has already
gotten me much more comfortable using XCode and Interface builder.

## What about Xamarin

Xamarin looks like a great option for C# developers who want to keep using C# or
share code with Android and iOS applications. This is not the problem I am
trying to solve. I enjoy learning new things and since I use C# daily at work, I
wanted to give native app development a chance. The concepts I learn writing iOS
and macOS applications in Swift will help me if my company ever needs a native
app written. Even though they'd likely use Xamarin (we are a C# heavy office
after all) I will learn a great deal about the underlying platform. That
knowledge will be useful whether or not I am writing code in Swift or C#.

## What do I like about Swift right now

So far Swift has been a lot of fun to learn. I'm getting to try out a new
language as well as two different native paradigms of iOS and macOS development.
I found Objective-C's syntax to be hard to follow and I was always a bit afraid
of managing my own memory. So far this is what I have liked about Swift as well
as what I've found confusing.

### Optionals

Handling optionals in Swift is pretty easy. this syntax is pretty similar to
what I learned from Rust. It is something that I'd love to see C# take a cue
from.

```swift
let someOptional: OptionalType?
if let someOptional = someOptional {
    // use the now unwrapped someOptional
} else {
    // some optional was nil
}
```

### Guard statements

Guard statements have been awesome, they combine a lot of what I like about how
swift handles optionals and lets me invert the check so my code doesn't get to
be an arrowhead. I also like that you can do additional checks and have your
function return.

```swift
func someFunction(some nullableParameter: SomeParameter) {
    guard let parameter = nullableParameter else { return }

    // use parameter here
}
```

One thing I'll eventually want to figure out with guard statements, is what the general suggestions for formatting a guard statement are. I'm writing them like this for now:

```swift
guard let symbol = aDecoder.decodeObject(forKey: PropertyKey.symbol) as? String,
      let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String,
      let detailDescription = aDecoder.decodeObject(forKey: PropertyKey.detailDescription) as? String,
      let usage = aDecoder.decodeObject(forKey: PropertyKey.usage) as? String
else { return nil }
```

### Generics

I haven't gotten too far into using Generics in Swift yet but they feel pretty similar to what I've gotten used to in C# and Rust.

## What confuses me about Swift so far

I've run into a few things in Swift that I've found confusing. Either from
suggestions on how you should organize your code using Extensions or more
historical aspects of iOS and macOS.

### Extensions

I'm used to C# where extension methods currently are static methods that operate
on a type. In Swift, that doesn't seem to be the case, you can extend most
classes it looks like including adding interface implementations or mutating
functions. It also seems like some style guides prefer you to break up a class
or struct by having interface implementations go into extensions. I'll have to
dig into extensions a little more to understand them.

### iOS and macOS differences

This isn't really specifically about Swift but more the platforms I'm using
swift on. Either way, it is confusing that it looks like iOS and macOS have
similar APIs in Swift but there seems to be a version of the same objects across
the platforms. On macOS everything is `NSSomething` where in iOS it looks like
there is always a `UISomething`. It hasn't been extremely confusing but I have
had to do some translating when trying to write code for the Mac when the
examples I've been looking at have been for iOS.

## What about Objective-C

As I've tried to learn about writing apps for macOS, I've noticed that a large
number of examples are written in Objective-C. This isn't a bad thing but I
avoided learning iOS and macOS development for a long time because of
Objective-C. So what about Objective-C now? Ultimately, it isn't that bad and
I've been able to understand most API examples even if they are written in
Objective-C.

The release of Swift 4 has made large strides in the API surface area it also
seems. Many of the APIs had a decidedly C or Objective-C feel to them but there
seems to be a big effort by Apple to make more APIs feel natural in Swift.

Ultimately, I'll teach myself at least *some* Objective-C. If I want to do
anything significant in Swift I likely am going to have to deal with some
Objective-C code for a long time to come. For now though, I'll try to stick to
just Swift.

## Goals learning Swift

I decided to learn Swift because I wanted to learn a new programming paradigm I've never used before. At my job right now, I do almost exclusively backed web development using C#. I don't get much time to work on UIs or native app development. To that end, I thought I'd give macOS development a try and have been working on a simple Pomodoro timer for the Mac.

I want to eventually have enough skills with Swift (and probably a little
Objective-C) that I could be a passable native iOS or macOS developer. I don't
know what the job opportunities look like there but it doesn't really matter
that much. Perhaps I'll try to release an app or two on the App Store, either
way, I'll have learned a new skill that I would enjoy.
