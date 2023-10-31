# flutter_base_null_safe

## Android Build:
```

// run dev
flutter run -t lib/main.dart --dart-define=DEFINE_APP_DISPLAY_NAME="[DEV]Flag Up!" --dart-define=DEFINE_APP_ID="com.whiteflag.dev" --dart-define=DEFINE_ENV="dev"

// run prod
flutter run -t lib/main.dart --dart-define=DEFINE_APP_DISPLAY_NAME="Flag Up!" --dart-define=DEFINE_APP_ID="com.flagup.app" --dart-define=DEFINE_ENV="prod"

## iOS Build:
```
// run dev
flutter run -t lib/main.dart --dart-define=DEFINE_APP_DISPLAY_NAME="[DEV]Flag Up!" --dart-define=DEFINE_APP_ID="com.whiteflag.dev" --dart-define=DEFINE_ENV="dev" --dart-define=DEFINE_DEVELOPMENT_TEAM=PL8V64WTV8

// run prod
flutter run -t lib/main.dart --dart-define=DEFINE_APP_DISPLAY_NAME="Flag Up!" --dart-define=DEFINE_APP_ID="com.flagup.app" --dart-define=DEFINE_ENV="prod" --dart-define=DEFINE_DEVELOPMENT_TEAM=HHVYK53SQG

## Configurations
### Using dart define for iOS
1. Create AppDefine.xcconfig file under ios/Flutter.
2. Create AppDefine-defaults.xcconfig file under ios/Flutter.

``````
DEFINE_APP_DISPLAY_NAME=
DEFINE_APP_ID=
DEFINE_ENV=
DEFINE_DEVELOPMENT_TEAM=
``````

3. Include AppDefine.xcconfig and AppDefine-defaults.xcconfig in Debug.xcconfig and Release.xcconfig.
4. Change CFBundleName value to DEFINE_APP_DISPLAY_NAME in Info.plist.
5. Change DEVELOPMENT_TEAM value to DEFINE_DEVELOPMENT_TEAM, PRODUCT_BUNDLE_IDENTIFIER to DEFINE_APP_ID in project.pbxproj. (debug, profile, release)
6. Add pre action in scheme. (build, run) *Choose Provide build settings from Runner*

``````
# Type a script or drag a script file from your workspace to insert its path.

function entry_decode() { echo "${*}" | base64 --decode; }

IFS=',' read -r -a define_items <<< "$DART_DEFINES"


for index in "${!define_items[@]}"
do
    define_items[$index]=$(entry_decode "${define_items[$index]}");
done

printf "%s\n" "${define_items[@]}"|grep '^DEFINE_' > ${SRCROOT}/Flutter/AppDefine.xcconfig
``````
