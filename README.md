<p align="center">
	<img width="256" height="256" src="demo/assets/deeplink-android.png">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<img width="256" height="256" src="demo/assets/deeplink-ios.png">
</p>

---

# <img src="addon/icon.png" width="24"> Godot Deeplink Plugin

Deeplink plugin provides a unified GDScript interface for processing of App Links on the Android platform and Universal Links on the iOS platform in order to enable direct navigation to specific app content.

**Features:**
- Enable web links to directly access app content.
- Provide support for custom schemes.
- Check if a domain is associated with app.
- Forward users to related app settings on platform.

---

## <img src="addon/icon.png" width="20"> Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Signals](#signals)
- [Export](#export)
- [Platform-Specific Notes](#platform-specific-notes)
- [Links](#links)
- [All Plugins](#all-plugins)
- [Credits](#credits)
- [Contributing](#contributing)

---

<a name="installation">

## <img src="addon/icon.png" width="20"> Installation

**Uninstall previous versions** before installing.
If using both Android & iOS, ensure **same addon interface version**.

**Options:**
1. **AssetLib**
	- Search for `Deeplink`
	- Click `Download` → `Install`
	- Install to project root, `Ignore asset root` checked
	- Enable via **Project → Project Settings → Plugins**
	- Ignore file conflict warnings when installing both versions
2. **Manual**
	- Download release from GitHub
	- Unzip to project root
	- Enable via **Plugins** tab

---

<a name="usage">

## <img src="addon/icon.png" width="20"> Usage
- Add `Deeplink` nodes to your scene per URL association and follow the following steps:
	- set the required field on each `Deeplink` node
		- `scheme`
		- `host`
		- `path prefix`
	- note that `scheme`, `host`, and `path prefix` must all match for a URI to be processed by the app
		- leave `path prefix` empty to process all paths in `host`
- register a listener for the `deeplink_received` signal
	- process `url`, `scheme`, `host`, and `path` data from the signal
- invoke the `initialize()` method at startup
- alternatively, use the following methods to get most recent deeplink data:
	- `get_link_url()` -> full URL for the deeplink
	- `get_link_scheme()` -> scheme for the deeplink (ie. 'https')
	- `get_link_host()` -> host for the deeplink (ie. 'www.example.com')
	- `get_link_path()` -> path for the deeplink (the part that comes after host)
- additional methods:
	- `is_domain_associated(a_domain: String)` -> returns true if your application is correctly associated with the given domain on the tested device
	- `navigate_to_open_by_default_settings()` -> navigates to the Android OS' `Open by Default` settings screen for your application
	
	---

<a name="signals">

## <img src="addon/icon.png" width="20"> Signals

- `deeplink_received(url: DeeplinkUrl)`: Emitted when app content is requested via deeplink.

---

<a name="export">

## <img src="addon/icon.png" width="20"> Export

Three options:

- Add `Deeplink` node to main scene
- Open scene with `Deeplink` nodes in the editor before export
- Use file-based export

1. **File-based Export Configuration**
In order to enable file-based export configuration, an `export.cfg` file should be placed in the `addons/DeeplinkPlugin` directory. The `export.cfg` configuration file may contain multiple deeplink configurations. The `scheme` and `host` properties are mandatory for each deeplink configuration.

The following is a sample `export.cfg` file:

```
[Deeplink1]
scheme = "https"
host = "www.example.com"

[Deeplink2]
scheme = "https"
host = "www.example2.com"
```

Example `export.cfg` file with Android-specific properties:

```
[Deeplink3]
label = "deeplink1"
is_auto_verify = true
is_default = true
is_browsable = true
scheme = "https"
host = "www.example.com"
path_prefix = "/my_data"
```

2. **Node-based Export Configuration**
If `export.cfg` file is not found or file-based configuration fails, then the plugin will attempt to load node-based configuration.

During iOS export, the plugin searches for `Deeplink` nodes in the scene that is open in the Godot Editor. If none found, then the plugin searches for `Deeplink` nodes in the project's main scene. Therefore; 
- Make sure that the scene that contains the `Deeplink` node(s) is selected in the Godot Editor when building and exporting for Android, or
- Make sure that your Godot project's main scene contains an `Deeplink` node(s).

---

<a name="platform-specific-notes">

## <img src="addon/icon.png" width="20"> Platform-Specific Notes

### Android
- **Build:** [Create custom Android gradle build](https://docs.godotengine.org/en/stable/tutorials/export/android_gradle_build.html).
- **Domain Association:** [Associate Godot app with a domain](https://developer.android.com/studio/write/app-link-indexing#associatesite).
- **Testing:**
  1. Use `adb shell` as follows:
	- `$> adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "https://www.example.com/mydata/path"`
- **Troubleshooting:**
  - Logs: `adb logcat | grep 'godot'` (Linux), `adb.exe logcat | select-string "godot"` (Windows)

### iOS
- **Domain Association:** [Associate Godot app with a domain](https://developer.apple.com/documentation/xcode/supporting-associated-domains).
- **Troubleshooting:**
	- View XCode logs while running the game for troubleshooting.
	- See [Godot iOS Export Troubleshooting](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html#troubleshooting).

---

<a name="links">

# <img src="addon/icon.png" width="20"> Links

- [AssetLib Entry Android](https://godotengine.org/asset-library/asset/2534)
- [AssetLib Entry iOS](https://godotengine.org/asset-library/asset/3191)

---

<a name="all-plugins">

# <img src="addon/icon.png" width="24"> All Plugins

| Plugin | Android | iOS |
| :---: | :--- | :--- |
| [Notification Scheduler](https://github.com/godot-sdk-integrations/godot-notification-scheduler) | ✅ | ✅ |
| [Admob](https://github.com/godot-sdk-integrations/godot-admob) | ✅ | ✅ |
| [Deeplink](https://github.com/godot-sdk-integrations/godot-deeplink) | ✅ | ✅ |
| [Share](https://github.com/godot-sdk-integrations/godot-share) | ✅ | ✅ |
| [In-App Review](https://github.com/godot-sdk-integrations/godot-inapp-review) | ✅ | ✅ |

---

<a name="credits">

# <img src="addon/icon.png" width="24"> Credits

Developed by [Cengiz](https://github.com/cengiz-pz)

iOS part is based on: [Godot iOS Plugin Template](https://github.com/cengiz-pz/godot-ios-plugin-template)

Original repository: [Godot Deeplink Plugin](https://github.com/godot-sdk-integrations/godot-deeplink)

---

<a name="contributing">

# <img src="addon/icon.png" width="24"> Contributing

This section provides information on how to build the plugin for contributors.

---

## <img src="addon/icon.png" width="20"> iOS

### Prerequisites

- [Install SCons](https://scons.org/doc/production/HTML/scons-user/ch01s02.html)
- [Install CocoaPods](https://guides.cocoapods.org/using/getting-started.html)

---

### Build

- Run `./script/build.sh -A <godot version>` initially to run a full build
- Run `./script/build.sh -cgA <godot version>` to clean, redownload Godot, and rebuild
- Run `./script/build.sh -ca` to clean and build without redownloading Godot
- Run `./script/build.sh -cb -z4.0` to clean and build plugin without redownloading Godot and package in a zip archive as version 4.0
- Run `./script/build.sh -h` for more information on the build script

___

## <img src="addon/icon.png" width="20"> Install Script

- Run `./script/install.sh -t <target directory> -z <path to zip file>` install plugin to a Godot project.
- Example `./script/install.sh -t demo -z build/release/DeeplinkPlugin-v4.0.zip` to install to demo app.

___

## <img src="addon/icon.png" width="20"> Libraries

Library archives will be created in the `build/release` directory.

---

## <img src="addon/icon.png" width="20"> Android

### Build

**Options:**
1. Use [Android Studio](https://developer.android.com/studio) to build via **Build->Assemble Project** menu
	- Switch **Active Build Variant** to **release** and repeat
	- Run **packageDistribution** task to create release archive
2. Use project-root-level **build.sh** script
	- `./script/build.sh -ca` - clean existing build, do a debug build for Android
	- `./script/build.sh -carz` - clean existing build, do a release build for Android, and create archive
