# <img src="https://raw.githubusercontent.com/godot-sdk-integrations/godot-deeplink/main/addon/icon.png" width="24"> Contributing

This section provides information on how to build the plugin for contributors.

---

## <img src="https://raw.githubusercontent.com/godot-sdk-integrations/godot-deeplink/main/addon/icon.png" width="20"> Common Configuration

The `common/config.properties` file allows for the configuration of:

- The name of the main plugin node in Godot
- Plugin version
- Version of Godot that the plugin depends on
- Release type of the Godot version to download (ie. stable, dev6, or beta3)

---

## <img src="https://raw.githubusercontent.com/godot-sdk-integrations/godot-deeplink/main/addon/icon.png" width="20"> iOS

### Prerequisites

- [Install SCons](https://scons.org/doc/production/HTML/scons-user/ch01s02.html)
- [Install CocoaPods](https://guides.cocoapods.org/using/getting-started.html)

---

### iOS Configuration

Among other settings, the `ios/config/config.properties` file allows for the configuration of:

- The target iOS platform version
- Valid/compatible Godot versions

---

### Build

#### Build All and Create Release Archives for Both Platforms

- Run `./script/build.sh -R` -- creates all 3 archives in the `./release` directory

#### iOS Builds
iOS build script can be run directly as shown in the examples below.

- Run `./ios/script/build.sh -A` initially to run a full build
- Run `./ios/script/build.sh -cgA` to clean, redownload Godot, and rebuild
- Run `./ios/script/build.sh -ca` to clean and build without redownloading Godot
- Run `./ios/script/build.sh -cbz` to clean and build plugin without redownloading Godot and package in a zip archive
- Run `./ios/script/build.sh -h` for more information on the build script

Alternatively, iOS build script can be run through the root-level build script as follows

- Run `./script/build.sh -i -- -cbz` to clean and build plugin without redownloading Godot and package in a zip archive
- Run `./script/build.sh -i -- -h` for more information on the build script

___

## <img src="https://raw.githubusercontent.com/godot-sdk-integrations/godot-deeplink/main/addon/icon.png" width="20"> Install Script

- Run `./ios/script/install.sh -t <target directory> -z <path to zip file>` install plugin to a Godot project.
- Example `./ios/script/install.sh -t demo -z build/release/ThisPlugin-v4.0.zip` to install to demo app.

___

## <img src="https://raw.githubusercontent.com/godot-sdk-integrations/godot-deeplink/main/addon/icon.png" width="20"> Libraries

Library archives will be created in the `build/release` directory.

---

## <img src="https://raw.githubusercontent.com/godot-sdk-integrations/godot-deeplink/main/addon/icon.png" width="20"> Android

---

### Android Configuration

The `android/gradle/lib.versions.toml` contains:

- Gradle plugins and their versions
- Library dependencies and their versions

### Build

**Options:**
1. Use [Android Studio](https://developer.android.com/studio) to build via **Build->Assemble Project** menu
    - Switch **Active Build Variant** to **release** and repeat
    - Run **packageDistribution** task to create release archive
2. Use project-root-level **build.sh** script
    - `./script/build.sh -ca` - clean existing build, do a debug build for Android
    - `./script/build.sh -carz` - clean existing build, do a release build for Android, and create release archive in the `android/<plugin-name>/build/dist` directory
