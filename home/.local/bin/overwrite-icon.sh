#!/bin/bash

PATH=/usr/bin

set -e

app_name="$1"

if [ -z "$app_name" ]; then
    echo "Usage: $0 <app_name>"
    exit 1
fi

case $app_name in
    "1password")
        BASE_DIR="/opt/1Password"
		ICONS=~/Dropbox/misc/app-icons/1password/tray_unlocked.png
		TARGET_DIR=app_src/images
        ;;
    "clickup")
        BASE_DIR="/opt/clickup"
		ICONS=~/Dropbox/misc/app-icons/clickup/tray-icon-production-Template*
		TARGET_DIR=app_src
        ;;
    *)
        echo "Invalid app name: $app_name"
		exit 1
		;;
esac

CURRENT_DIR=$(pwd)

TEMP_DIR=$(mktemp -d)

cd $TEMP_DIR

cp $BASE_DIR/resources/app.asar app.asar
cp -r $BASE_DIR/resources/app.asar.unpacked app.asar.unpacked
npx asar extract app.asar app_src
rm app.asar
for icon in $ICONS; do
    cp $icon $TARGET_DIR
done
npx asar pack app_src app.asar
sudo cp app.asar $BASE_DIR/resources/app.asar

cd $CURRENT_DIR
rm -rf $TEMP_DIR
