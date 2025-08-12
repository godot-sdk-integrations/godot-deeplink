<p align="center">
	<img width="256" height="256" src="../demo/assets/deeplink-ios.png">
</p>

---
# <img src="addon/icon.png" width="24"> Deeplink Plugin

Deeplink plugin allows processing of iOS application links that enable direct navigation to requested app content.

_For Android version, visit https://github.com/cengiz-pz/godot-android-deeplink-plugin ._

## <img src="addon/icon.png" width="20"> Prerequisites
Follow instructions on the following page to prepare for iOS export:
- [Exporting for iOS](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html)

Follow instructions on the following page to associate your Godot app with your web domain:
- [Associate your Godot app with your domain](https://developer.apple.com/documentation/xcode/supporting-associated-domains)

## <img src="addon/icon.png" width="20"> iOS Export
- Make sure that the scene that contains your Deeplink nodes is selected in the Godot Editor when building and exporting for iOS
	- Close other scenes to make sure
	- _Deeplink nodes will be searched in the scene that is currently open in the Godot Editor_
Android export requires several configuration settings.

## <img src="addon/icon.png" width="20"> Running demo
- After exporting demo application to an Xcode project, Xcode will require an account to be added.
	- Add an account via Xcode->Settings...->Accounts

## <img src="addon/icon.png" width="20"> Troubleshooting

### Unhandled Deeplinks
If your game is not handling your deeplinks, then make sure to revisit the [Prerequisites](#prerequisites) section.

### XCode logs
XCode logs are one of the best tools for troubleshooting unexpected behavior. View XCode logs while running your game to troubleshoot any issues.


### Troubleshooting guide
Refer to Godot's [Troubleshooting Guide](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html#troubleshooting).

<br/><br/>

___

# <img src="addon/icon.png" width="24"> Contribution

This section provides information on how to build the plugin for contributors.

<br/>

___

## <img src="addon/icon.png" width="20"> Prerequisites

- [Install SCons](https://scons.org/doc/production/HTML/scons-user/ch01s02.html)
- [Install CocoaPods](https://guides.cocoapods.org/using/getting-started.html)

<br/>

___

## <img src="addon/icon.png" width="20"> Build

- Run `./script/build.sh -A <godot version>` initially to run a full build
- Run `./script/build.sh -cgA <godot version>` to clean, redownload Godot, and rebuild
- Run `./script/build.sh -ca` to clean and build without redownloading Godot
- Run `./script/build.sh -cb -z4.0` to clean and build plugin without redownloading Godot and package in a zip archive as version 4.0
- Run `./script/build.sh -h` for more information on the build script

<br/>

___

## <img src="addon/icon.png" width="20"> Install Script

- Run `./script/install.sh -t <target directory> -z <path to zip file>` install plugin to a Godot project.
- Example `./script/install.sh -t demo -z bin/release/DeeplinkPlugin-v4.0.zip` to install to demo app.

___

## <img src="addon/icon.png" width="20"> Libraries

Library archives will be created in the `bin/release` directory.
