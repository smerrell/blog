---
title: Swift 4 Drawing
date: 2017-10-14 22:02:39
description: "Learning the Quartz / Core Graphics API"
tags: [ "Swift", "Quartz" ]
categories:
    - "Development"
    - "Swift"
draft: true
---

Learning how to use Swift 4 and Quartz / Core Graphics. Much of the information
found online only go to Swift 3, but Swift 4 APIs have changed to be more
Swift-like. This is good, but makes it hard to find documentation online that
works.

## What is Quartz 2D / Core Graphics

## Making Your Own View

1. You need to subclass `NSView`

```swift
class CircleView: NSView {
    override func draw(_ dirtyRect: NSRect) {

    }
}
```

## Adding your custom view to the storyboard

1. Use `Custom View`
1. On the `Identity Inspector` tab, make sure to set the Class, to your view's
   class.
1. You can make your view show up in interface builder by prefixing the class
   with `@IBDesignable`

## Questions

### How does the Graphics context play in this?

#### The right way now

```swift
let context = NSGraphicsContext.current?.cgContext
```

#### The old way looks like this:

```swift
let context = NSGraphicsContext.current?.graphicsPort
```

That method is deprecated.

### Filling `CGRect`s

There look to be two ways to fill a `CGRect`. Either you can call `.fill()` on
an instance of a `CGRect` or you can call the `.fill(rect: CGRect)` or
`.fill(rects: [CGRect])`. Is one preferred over the other? I could see how the
fill multiple rects would be useful but how does the single fill compare to the
one on the `CGRect` itself?

## Notes

### `NSRect` vs `CGRect`

They look like they are the same thing. I'm assuming you should use `CGRect`
instead of the `NSRect` since I think `CGRect` is also used on iOS.

### `NSRectFill` -> `NSRect.fill()`

The global of `NSRectFill` is replaced by instance functions, so you can call
fill on `rect` instances it looks like. Most examples use the globals though.

* https://twitter.com/jnadeau/status/873015119113969664?lang=en
    * NSRectFill → rect.fill(), NSRectClip → rect.clip(), NSBeep →
        NSSound.beep()

### Order matters.

think of it like a painting as you add layers on, that is what gets rendered and
you eventually see on the screen

### Creating `CGRect`s

Most examples use this:

```swift
let cgrect = CGRectMake(0, 0, 200, 100)
```

But the swift way is to use an initializer on CGRect now:

```swift
let gcrect = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 200.0)
```

### Resources

* http://www.knowstack.com/drawing-in-swift-cocoa/
