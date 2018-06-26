
<p align="center">
  <img src="https://github.com/NghiaTranUIT/artify-macos/blob/master/images/logo.png" alt="Artify App Logo" width="600" height="auto"/>
</p>

<h2>
  Artify
  <a href="https://travis-ci.org/NghiaTranUIT/artify-macos">
    <img src="https://travis-ci.org/NghiaTranUIT/artify-macos.svg?branch=master" alt="Build Status">
  </a>
  <a href="https://github.com/NghiaTranUIT/artify-macos/releases/tag/0.5.1">
    <img src="https://img.shields.io/badge/version-0.5.1-green.svg" alt="0.5.1">
  </a>
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/license-GPL--3.0-blue.svg">
  </a>
</h2>

A macOS X application for bringing dedicatedly 18th century Arts to everyone 🌎.

<a href="#screenshots">Wallpaper</a> •
<a href="#features">Features</a> •
<a href="#downloads">Downloads</a> •
<a href="#technologies">Technologies</a> •
<a href="#3rd-libraries">3rd Libraries</a> •
<a href="#development">Development</a> •
<a href="#faq">FAQ</a> •

## Wallpaper

<div align="center">
    <img src="https://github.com/NghiaTranUIT/artify-macos/blob/master/images/red-vineyards-at-arles-1888.jpg" width="100%" />
    <div align="center">Red Vineyard At Arles</div>
    <img src="https://github.com/NghiaTranUIT/artify-macos/blob/master/images/the-starry-night.jpg" width="100%" />
    <div align="center">The Starry Night</div>
    <img src="https://github.com/NghiaTranUIT/artify-macos/blob/master/images/1440_900_the_wanderer_above_the_sea_of_fog.jpg" width="100%" />
    <div align="center">The Wanderer Above The Sea of Fog</div>
</div>

## Features
* 😍 Hand-picked 18th Arts.
* 👨‍💻 Generate beautiful wallpaper depend on your screen size.
* 👑 Automatically fetch feature art for every days.
* 🌎 On-demand art, You can pick your favorites art-style, artist (Coming soon 🙇🏻‍♂️)
* 🍉 Open-source project.
* 💯 Totally Free.

## Downloads
All downloads are available at [Release page](https://github.com/NghiaTranUIT/artify-macos/releases)

### macOS Requirement
The minimum version supported is macOS 10.11.

## Technologies
* [Swift 4.1](https://swift.org)
* [macOS Native](https://developer.apple.com/documentation/)
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [MVVM](https://www.objc.io/issues/13-architecture/mvvm/)

## 3rd Libraries
* [Moya/RxSwift](https://github.com/Moya/Moya)
* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa)
* [RxOptional](https://github.com/RxSwiftCommunity/RxOptional)
* [Action](https://github.com/RxSwiftCommunity/Action)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [Unbox](https://github.com/JohnSundell/Unbox)
* [RxNuke](https://github.com/kean/RxNuke)
* [Sparkle](https://sparkle-project.org)

## Development
Artify requires [Artify Core](https://github.com/NghiaTranUIT/artify-core) as a backend. Pls follow this [Instruction](https://github.com/NghiaTranUIT/artify-core/blob/master/README.md) in order to start the core successfully 😎

After starting the development server.
* Clone this project
* Run `$ pod install`
* Open `ArtifyWorkspace.xcworkspace`
* Happy coding 😍

## FAQ

* **Is it a original idea?**

> Nowadays, Almost idea is mixing. The original idea was inspired by a guy in HN-Show I've seen in a couple months ago. It's just a tool to generate a photo after dragging manually my original picture. It has lack of capability.
>
> I'm a lazy guy, I'd something could do it automatically every time. Ultimately, I came up with this idea.

* **Where is the Backend side?**

> I'm in charge of developing the [Artify Core](https://github.com/NghiaTranUIT/artify-core), as a Golang backend serverside. > Feel free to contribute cooperatively.

* **What is the current progress?**

> Here is [Open Ticket](https://github.com/NghiaTranUIT/artify-macos/issues?q=is%3Aopen+is%3Aissue) and [Close Ticket](https://github.com/NghiaTranUIT/artify-macos/issues?q=is%3Aissue+is%3Aclosed)

* **Why do you choose RxSwift + MVVM?**

> I have solid experience when working with RxSwift + MVVM for a couple projects on Production. I'm so happy when writing concise, elegant Observable, Driver,... rather than clumsy functions with tons of nested-callbacks.
>
> If something makes me happy, I will follow it. Simple enough 😂

* **Is this app built with Swift?**

> Yes, Artify is built on top of Swift 4.1 and macOS Native library.

* **Why is it an OSS?**

> The source code is a trash if keep it in your inventory forever. I'd contribute back to the dev community when I have an opportunity.
>
> The best way is publishing your source code 👨‍💻.

* **Why is 18th century art?**

> Every time I have a short trip to an overseas country, I often spent 1 or 2 days to visit all famous art museum. I could stand for an hour to look at the detail, the scrape from those old oil photo. Individual traits could represent the history, the effort, the dream from original authors.
>
> I realize I fall in love with the 18th art somehow 🤣
>
> Then I come up with the idea, why don't we bring it to everybody, who has the same passion as me.
>
> Let imagine, every day, when I open my laptop at 9 AM, I can see the best photo of this day, with detail information, history, and the author. That would be amazing 😱
>
> Without considering, I start to develop the macOS app as well as the [Artify-Core](https://github.com/NghiaTranUIT/artify-core), which is written by Golang.
>
> All of the art pictures will be hand-picked by me and my best girlfriend. Hope you enjoy it 😍

* **How does Artify generate the beautify wallpaper?**

> **[DR;TL]**
>
> 1. Determine the golden size, which relies on your current screen size. It makes sure every generated wallpaper is as nice as possible.
> 2. Draw this image with the desired size in the middle
> 3. Draw shadow
> 4. Scale the background with "aspect to fill" mode
> 5. Apply Gaussian algorithm
> 6. Combine everything and cached locally.
>
> **[Detail implementation]**
>
> Here is the [algorithm](https://github.com/NghiaTranUIT/artify-macos/blob/master/artify-core/artify-core/Algorithm/Gaussian/GaussianAlgorithm.swift)

* **Where does the Artify's resource come from?**

> Every art pictures are hand-picked from [WikiArt](https://www.wikiart.org).
>
> If you wonder how I collect the data. Here is my partner, [Spider Man](https://github.com/NghiaTranUIT/artify-core/blob/master/scripts/spider.ruby), which is a Ruby script.
>
> The conjunction of [Nokogiri](http://www.nokogiri.org) and [Watir](http://watir.com) are perfect for this scenario. Indeed,I'm a lazy man, I don't want to collect data like a manual labor 😅.

* **What are the tough problems, which you confronts when developing this project?**

> The Implementation of the [Artify Core](https://github.com/NghiaTranUIT/artify-core) by Golang with latest technologies and the Artify Gaussian algorithm are two things take me most the effort.

* **Can I become a contributor?**

> Defintely, I appreciate your effort to become a contributor. Clone the project and setup your workspace. Happy coding guys 🚢

* **Do you have personal blog?**

> Yes, I often write blog at [My lab](www.nghiatran.me) 👨‍🍳

* **How do I contact you?**

> Don't hesitate to open Issue on Github if you encounter any problems. Or give a welcome hug to me at vinhnghiatran@gmail.com.
