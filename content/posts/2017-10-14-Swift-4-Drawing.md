---
title: Swift 4 Drawing
date: 2017-10-14 22:02:39
description: "Learning the Quartz / Core Graphics API"
tags: [swift, quartz]
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

1. How does the Graphics context play in this?
    * Is this the right way now?
        ```swift
        let context = NSGraphicsContext.current?.cgContext
        ```
    * Maybe?

## Notes

* `NSRectFill` -> `NSRect.fill()`
    * The global of `NSRectFill` is replaced by instance functions, so you can
      call fill on `rect` instances it looks like. Most examples use the globals
      though.
    * https://twitter.com/jnadeau/status/873015119113969664?lang=en
        * NSRectFill → rect.fill(), NSRectClip → rect.clip(), NSBeep →
          NSSound.beep()
* Order matters. think of it like a painting as you add layers on, that is what
  gets rendered and you eventually see on the screen


### Resources

* http://www.knowstack.com/drawing-in-swift-cocoa/
