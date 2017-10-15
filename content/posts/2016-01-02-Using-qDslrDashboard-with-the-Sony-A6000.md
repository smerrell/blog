---
title: Using qDslrDashboard with the Sony a6000
tags:
  - photography
  - sony-a6000
date: 2016-01-02 12:11:15
---


Most of my posts are going to be something technology related but I _do_ happen
to have other interests. For a while now, I've had a Sony a6000 that I've been
very happy with. I'm very much an amateur at photography but I find it fun and I
like the images I get of my family more than the ones I can get from my iPhone.
So I've been slowly trying to level up my photography skills. I'm definitely not
over 9000 yet, but maybe one day I'll get there.

This Christmas, I finally got a tripod and it has gotten me interested in trying
to do some time lapse photography. Sony has a time lapse app but I wanted to see
what other options were out there. After a bit of Googling, I came across
[DslrDashboard](http://dslrdashboard.info). Confusingly, the apps have been
renamed to qDslrDashboard, but there is an app for just about every platform.

Since I own two iDevices, I went ahead and threw down the $10 it cost for the
iOS app. At first, I was hoping to find a free option to do time lapse, but I
definitely feel better giving a developer my ten dollars instead of just throwing
it at Sony. Since I didn't have my iPad right on hand, I started trying things
out with my iPhone. It took me a while to figure out how to get the app to work
with my phone, and honestly, I'm still not 100% sure how to get the thing to
work consistently every time. Here's what it took me to get my camera and my
iPhone running the qDslrDashboard app running.

* Go to https://www.playmemoriescameraapps.com/portal/
* Create an account (PlayStation Network account, ugh.)
* Go to `Menu -> Applications`
{{< figure src="/images/photography/application-list.jpg" title="Application list on the a6000" >}}
* Select `PlayMemories Camera Apps`
{{< figure src="/images/photography/playmemories-camera-apps.jpg" title="Application select PlayMemories Camera Apps on the a6000" >}}
* Find Smart Remote Control app
* Install it

I still feel pretty gross about having to create a PlayStation Network account,
but there you go, all the steps to get the Smart Remote Control updated.

## Getting qDslrDashboard and the a6000 working together

To get the a6000 to be controlled remotely, you have to open the Smart Remote
Control application. This is as simple as going from `Meny -> Applications ->
Application List -> Smart Remote Control`. Once you open the Smart Remote
Control app, the a6000 will create a WiFi network. Simply connect your device to
that network using the SSID and Password from the screen and the camera will
start in remote control mode.

This is where it gets a little odd with the qDslrDashboard app.

{{< figure src="/images/photography/sony-wireless-connection.jpg" title="Tap the button until it works" >}}

The first tap of the Sony Wireless button has not worked for me, I often have to
press multiple times until it works. A little weird, but it does eventually
work!

Once you've tapped the Sony wireless connection button enough times, you'll be
greeted with this screen of buttons. I don't know for sure if qDslrDashboard
defaults to using a live view, but if it does you'll see what the camera is
seeing as well. Otherwise you can tap the little `Lv` button in the top left
corner.

To get to the time lapse portion, you need to tap the time lapse button on the
right.

{{< figure src="/images/photography/time-lapse.jpg" title="The time lapse button" >}}

The time lapse screen has a whole bunch of options to choose from. In the image
below, I captured a sample, it then displays a bunch of information about the
image you took to help you figure out what settings you'll need to make the time
lapse. I don't know what much of that means, but one day I will!

{{< figure src="/images/photography/time-lapse-screen.jpg" title="The time lapse screen" >}}

At the most basic level, you really just need to scroll down and click the
stopwatch icon. The stopwatch icon will let you configure the interval timer
which is the heart of doing the time lapse.

{{< figure src="/images/photography/interval-timer.jpg" title="The time lapse interval timer screen" >}}

Setting the interval timer is pretty simple, but you do have to think a little
bit about it. When I first set it up, I wasn't really reading what the screen
was trying to tell me. I set a frame count and then set the interval to 20
minutes. In my mind it was going to take pictures until the 20 minutes ran out.
When nothing happened for a minute or two, I realized my mistake.

{{< figure src="/images/photography/interval-timer-setup.jpg" title="The time lapse interval timer setup" >}}

If you want to have a time lapse go for a specific amount of time, you need to
factor in two things. The interval, which is how long to wait between shots, and
the frame count. The frame count is exactly what it sounds like, the number of
frames to capture. So, if I wanted to shoot for an hour and I was taking a frame
every second, I need to work backwards to get the number of frames.

If I have an interval of 5 seconds, it is going to look something like this:

> (60 seconds / a frame every 5 seconds) * 60 minutes = 720 frames

So to capture an hour of time at 1 frame every 5 seconds, I need 720 frames
total. This will capture an hours worth of time, I do wish qDslrDashboard had a
way to say how long to capture as well, but it isn't too difficult to figure out
on my own.

After that you simply press start and the camera will start taking pictures at
the interval. Easy! So how about after you've taken the pictures? Well, after
some Googling and playing around I've found two different ways to use the
time lapse. One is by making a gif and the other making a movie.

## Resizing the images

Since the a6000 takes 24 megapixel (roughly 6000x4000), I resize the images
first. This is where ImageMagick comes in handy. The script below will find all
the images and use ImageMagick's `mogrify` command to resize the images in
place.


```bash
for file in *.jpg do;
  mogrify -resize 3840x2160^ -gravity center -crop 3840x2160+0+0 +repage $file
done
```

[I got this from this great post.](http://dlo.me/archives/2015/07/26/making-a-time-lapse-using-ffmpeg-and-imagemagick/)

**Note:** This script resizes images in place, I do this because I export the
pictures from Apple Photos. If you don't want to resize the actual image, you
can add `-write resized/$file` before the last `$file`. This will write out all
the images to a `resized` folder.

Depending on how you want the images cropped, you might want to play with the
`-gravity` setting. This script will crop all the images directly in the center
of the image. The `3840x2160^` resizes the image to a 4k resolution but will
preserve the smaller of the width or height.

I've played around with resizing images with ImageMagick before, but the credit
for this script goes to Dan Loewenherz's great blog post [Making a time-lapse on
the command line using FFmpeg and
ImageMagick](http://dlo.me/archives/2015/07/26/making-a-time-lapse-using-ffmpeg-and-imagemagick/).
There are many great tips from his post, so you should go read it.

## Turning the images into a gif

If your time lapse is pretty short, you can convert to an animated gif quite
easily using ImageMagick. The command looks something like:

```bash
convert *.jpg -set delay 1 my-time-lapse.gif
```

This is the most basic way to create an animated gif from a series of images.
This only works if the Jpeg files are ordered. You can play around with the
`-delay` time and see how it turns out. ImageMagick also has a million other
things you can do so take a look at the
[docs](http://www.imagemagick.org/script/command-line-options.php).

## Turning the images into a movie

Once you have the images resized how you want them, converting to a movie using
ffmpeg is pretty simple.

```bash
ffmpeg -framerate <some number> -start_number 1 -i image%04d.jpg -c:v libx264 -pix_fmt yuv420p <filename>.mp4
```

This command will take the series of images and put them together into an MP4
video file. The `-c:v libx264` command tells ffmpeg to encode the video using
the `libx264` codec. This will encode it as an h264 video. The `-pix_fmt` option
sets the pixel format of the video. This is the color format of the video, video
players will use it to know how to display the video properly.

And with that, you will have the final product! Ffmpeg has a ton of option and
is a very powerful tool, I'm certain I will have more to write about using
ffmpeg to convert or create videos.

## End Result

**Edit: Feburary 6, 2016:**

Here is a sample video I made of a sunset. {{< youtube vsy5eJAsOgc >}}
