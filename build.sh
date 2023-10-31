#!/bin/bash
filename=ios/Flutter/Generated.xcconfig
build_targer_directory="lib/main.dart"
echo "replace build target: "${build_targer_directory//\//\\/}

read -p "Enter the build flavor (dev, prod, default prod): " build_flavor
if [ -z "$build_flavor" ]; then
  build_flavor="prod"
fi

if [[ $build_flavor == "dev" ]]; then
  app_name="[DEV]X10 Legends"
  app_id="com.xtl.dev"
elif [[ $build_flavor == "prod" ]]; then
  app_name="X10 Legends"
  app_id="com.x10legends.app"
fi

echo $build_flavor
echo "app name: "$app_name
echo "app id: "$app_id

read -p "Enter the build name (default: 1.0.0): " build_name
if [[ $build_name == "" ]]; then
  build_name="1.0.0"
fi
echo  "build name: "$build_name

read -p "Enter the build number (default: 1): " build_number
if [[ $build_number == "" ]]; then
  build_number="1"
fi
echo "build number: "$build_number

build_device=0
read -p "Enter the build device (1: iOS, 2: Android, default: all): " build_device

if [[ $build_device -eq 0 || $build_device -eq 1 ]]; then
  if [[ $build_flavor == "dev" || $build_flavor == "stg" ]]; then
    export_option="ExportOptions-dev.plist"
  elif [[ $build_flavor == "prod" ]]; then
    export_option="ExportOptions-prod.plist"
  fi

  team_id=$(/usr/libexec/PlistBuddy -c "Print :teamID" ios/scripts/$export_option)
  if [ -z "$team_id" ]
  then
    exit 1
  fi

  echo "team id: "$team_id

  if [[ $build_flavor == "dev" ]]; then
    flutter build ios -t $build_targer_directory --no-sound-null-safety --dart-define=DEFINE_APP_DISPLAY_NAME='[DEV]X10 Legends' --dart-define=DEFINE_APP_ID=$app_id --dart-define=DEFINE_ENV=$build_flavor --dart-define=DEFINE_DEVELOPMENT_TEAM=$team_id
  elif [[ $build_flavor == "prod" ]]; then
    flutter build ios -t $build_targer_directory --no-sound-null-safety --dart-define=DEFINE_APP_DISPLAY_NAME='X10 Legends' --dart-define=DEFINE_APP_ID=$app_id --dart-define=DEFINE_ENV=$build_flavor --dart-define=DEFINE_DEVELOPMENT_TEAM=$team_id
  fi
  sed -i "" -e "s|^FLUTTER_TARGET.*|FLUTTER_TARGET=${build_targer_directory//\//\\/}|g" $filename
  sed -i "" -e "s|^FLUTTER_BUILD_NAME.*|FLUTTER_BUILD_NAME=$build_name|g" $filename
  sed -i "" -e "s|^FLUTTER_BUILD_NUMBER.*|FLUTTER_BUILD_NUMBER=$build_number|g" $filename

  xcodebuild -workspace ios/Runner.xcworkspace -scheme Runner archive -archivePath build/ios/Runner.xcarchive -destination generic/platform=iOS
  #Check if build succeeded
  if [ $? != 0 ]
  then
    exit 1
  fi
  xcodebuild -exportArchive -archivePath build/ios/Runner.xcarchive -exportOptionsPlist ios/scripts/$export_option -exportPath build/ios/iphone -allowProvisioningUpdates
  rm -fr build/ios/Runner.xcarchive
fi

if [[ $build_device -eq 0 || $build_device -eq 2 ]]; then
  if [[ $build_flavor == "dev" ]]; then
    flutter build apk -t $build_targer_directory --no-sound-null-safety --build-name=$build_name --build-number=$build_number --dart-define=DEFINE_APP_DISPLAY_NAME='[DEV]X10 Legends' --dart-define=DEFINE_APP_ID=$app_id --dart-define=DEFINE_ENV=$build_flavor
  elif [[ $build_flavor == "prod" ]]; then
    read -p "Enter the bundle type (apk, aab, default aab): " bundle_type
    if [[ $bundle_type == "" ]]; then
      bundle_type="aab"
    fi

    if [[ $bundle_type == "apk" ]]; then
      flutter build apk -t $build_targer_directory --no-sound-null-safety --build-name=$build_name --build-number=$build_number --dart-define=DEFINE_APP_DISPLAY_NAME='X10 Legends' --dart-define=DEFINE_APP_ID=$app_id --dart-define=DEFINE_ENV=$build_flavor
    elif [[ $bundle_type == "aab" ]]; then
      flutter build appbundle -t $build_targer_directory --no-sound-null-safety --build-name=$build_name --build-number=$build_number --dart-define=DEFINE_APP_DISPLAY_NAME='X10 Legends' --dart-define=DEFINE_APP_ID=$app_id --dart-define=DEFINE_ENV=$build_flavor
    fi
  fi
fi
