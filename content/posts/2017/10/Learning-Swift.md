---
title: "Learning Swift"
description: "Digging in"
date: 2017-10-16T22:22:52-06:00
tags: [ "Swift" ]
categories:
    - "Development"
    - "Swift"
draft: true
---

## Introduction

Why do I want to learn Swift? For fun, I wanted to try writing a macOS app but
didn't really want to learn Objective-C

## What I'm Reading

App Development With Swift by Apple. Why? Because it was free and looked to be a
pretty good intro to Swift. It focuses on iOS but I figured I could probably
translate a lot of what I learn into macOS paradigms. That has mostly panned out
from what I've been doing.

## Notes

### Interface Builder

Looks to be pretty cool though I try to use the keyboard and that goes out the
window with Interface Builder. Oh well.

### Handling View Controllers

Still learning how to really tame the view controller. There seem to be a few
camps on how you might organize your code so you don't end up with massive view
controllers. The tiny bit of WPF experience with using MVVM hasn't translated
very well for me since I didn't really do it enough to get a good feel for
native UI work. I've mostly lived on the backend so this is different.

A lot of what I've seen uses Protocols to define a delegate and then you have
your view controller implement that delegate. Then you can set your view
controller as a delegate of a different class that does most of your logic.

Other approaches seem to try to avoid the View Controller as much as possible,
but feels like it takes a lot of glue to make that happen. Apple's description
of how to do things hasn't been clear to me yet.

## Daily Notes

**2017-10-16**

Application Lifecycle

- Not Running
- Foreground
    - Inactive
    - Active
- Background
- Suspended

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionKey: Any]?) -> Bool {
    return true
}
```

First function called when the application starts.

What are the launch options?

```swift
func applicationWillResignActive(_ application: UIApplication) {

}
```

Called when the app is about to leave the foreground state. Could be because the
app is closing or got interrupted by something like a phone call. Should use it
to save state.

```swift
func applicationDidEnterBackground(_ application: UIApplication) {

}
```

Called after `applicationWillResignActive`, like that function use it to save
state. If the func was called because of a user quitting the app, you have about
5 seconds to finish up before the app is completely shut down.

```swift
func applicationWillEnterForeground(_ application: UIApplication) {

}
```

```swift
func applicationDidBecomeActive(_ application: UIApplication) {

}
```

```swift
func applicationWillTerminate(_ application: UIApplication) {

}
```

**2017-10-18**
- - -

## Apple's View on MVC

### Views

Apple says view classes often have an `update` or `configure` method that take
in a model which the view then uses to display. Something like:

```swift
func update(_ player: Player) {

}
```

The view talks to the view controller to perform actions on a model. The view
usually is defined by Interface Builder so often it'll just be a Storyboard or
maybe a nib/xib.

### Controllers

Messenger between view and model, the view controller will have references to
the view itself (and its elements like labels, buttons, etc) and the model.

#### View Controllers

These are by far the most common type, but Apple defines other types of
controllers as well.

#### Model Controllers

These are controllers that sit in front of a model or collection of models and
control how you access / update the model.

Reasons you might want to do this?

* Multiple objects or scenes need access to the model data
* The logic for manipulating the objects is complex
* You want to keep the view controller code focused on managing the view

#### Helper Controllers

*note* Not a huge fan of the term helper, but...

These are useful when you want to consolidate related data or functionality so
it can be accessed by other objects in the app. An example might be a
`NetworkController` that handles all the network access.

#### Communicating

Controllers are free to communicate with other controllers. This makes sense in
the way apple describes controllers. You'll use them to coordinate actions such
as having a NetworkController notify a NoteController there are new notes. That
might then notify a NotesView controller to update the view with the new data.

**2017-10-19**
- - -

### Models

```swift
struct Athelete {
    var name: String
    var age: Int
    var league: String
    var team: String
}
```

### Controllers
Detail controller?
Athlete model controller?
    If I want to keep the view controller just focused on the view

#### Functions
Add new athlete
View current athlete
Save athlete

[Athlete]

**2017-10-20**
- - -

## Scroll Views

https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/UIScrollView_pg/Introduction/Introduction.html

`UIScrollView` for iOS, `NSScrollView` for macOS. The scroll view needs to know two things to function:

1. position and size of scroll view (`frame` property)
1. size of the content being displayed (`contentSize` property)

troubles with autolayout of the scroll view. A stack view makes sense but it
doesn't want to let me constrain it to the edges of the scroll view?

Looks like there is a little more to auto layout when nesting a stack view
inside a scroll view. The stack view needs to be constrained to the scroll view
size and then you need to constrain either the width (by setting it equal to the
scroll view, which can be done with right click / dragging) or the height
depending on how you want it to scroll.

I would assume that for images this isn't a problem because you want to scroll
both horizontally and vertically but you already have the image size.

### The Keyboard

By default, if the keyboard shows it just covers your view. To handle that, you
need to register when the keyboard is shown/hidden. You then adjust the padding
of your view to push everything up above the keyboard.

This must also be how other apps have added toolbars just above the keyboard.

```swift
  func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
  }

  @objc func keyboardDidShow(_ notification: NSNotification) {
    guard let info = notification.userInfo,
          let keyboardFrameValue = info[UIKeyboardFrameBeginUserInfoKey] as? NSValue
      else { return }

    let keyboardFrame = keyboardFrameValue.cgRectValue
    let keyboardSize = keyboardFrame.size

    let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
    scrollView.contentInset = contentInsets
    scrollView.scrollIndicatorInsets = contentInsets
  }

  @objc func keyboardWillHide(_ notification: NSNotification) {
    let contentInsets = UIEdgeInsets.zero
    scrollView.contentInset = contentInsets
    scrollView.scrollIndicatorInsets = contentInsets
  }
```

**2017-10-21**
- - -

## Scroll View with an Image

Pretty simple, but you need to use `UIScrollViewDelegate` on the view
controller. Then you return the view you want to zoom using the `viewForZooming`
function.

```swift
func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    // return the view you want here, for example an image could be:
    return imageView
}
```

use the `viewForZooming` func in the `viewDidLoad` like this:

```swift
scrollView.delegate = self
```

## UITableView

Table views present as a scrolling, single column list.

Two ways to use them:

1. Add a table view instance directly to a view controller's view. You manage
   auto layout and everything. You're responsible for the data source and
   delegate object as well.
1. Add to a storyboard. The table view would take up the entire view and gives
   you a table view controller which has extra advantages such as handling the
   view if the keyboard is visible.

### Styles

#### Plain

Rows can be separated into labeled sections with an optional index along the
right side. Each section immediately follows the previous section with no
spacing, creating an unbroken list.

#### Grouped

Rows are displayed in visually distinct groups, or sections, with spacing in
between and without an index. (settings type pages are an example of this style)

### Editing

Is a thing.

### Table View Cells

Come in two basic formats. Regular cell and editing mode.

Regular cell has two components. Cell Content, and Accessory View on the right

Table Cell View - `[[cell content goes here][accessory view]]`
Editing Table Cell View - `[[editing control][cell content goes here][accessory view]`

UITableViewCell has three properties for cell content

1. `textLabel` a `UILabel` for the title
1. `detailTextLabel` a `UILabel` for the subtitle (if there is additional detail)
1. `imageView` a `UIImageView` for an image

**2017-10-22**
- - -

Reuse of cells:

Since you should be thinking about memory usage, the UITableView gives you the
ability to reuse cells as you scroll. This comes from this method:

```swift
func dequeueReusableCell(withIdentifier for: )
```

## Data sources

A Dynamic table view must have a data source and optionally a delegate.

Often times, the data source is also the delegate. This isn't always true though
but something that does happen. The UITableView delegates responsibility for
configuring its own content.

### `UITableViewDataSource` protocol

Defines three methods

```swift
optional func numberOfSelections(in tableView: UITableView) -> Int
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
```

### Cell for row at index path

Most implementations of this protocol will look something like this:

1. Fetch the correct cell by dequeueing a cell
1. Fetch the model object to be displayed
1. Configure the cell's properties with the model object properties. i.e. set
   views (labels, image views, etc.) based on model object
1. Return the fully configured cell

**20172-7**
- - -

## Static Table Views

Useful when you know you want the layout regardless of the content inside the
view.
