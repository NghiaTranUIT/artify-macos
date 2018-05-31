#!/bin/bash

BASE_DIR=..
BUILD_DIR=$BASE_DIR/build
APP_ARCHIVE=$BUILD_DIR/Artify.xcarchive
APP_PLIST=$BASE_DIR/Artify/Artify/Resources/Info/Info.plist
APP_BUILD=$BUILD_DIR/app

echo "Building Artify..."
echo $APP_PLIST

echo "Cleaning up old archive & app..."
rm -rf $APP_ARCHIVE $APP_BUILD

echo "Building archive..."
xcodebuild -workspace $BASE_DIR/ArtifyWorkspace.xcworkspace -config Release -scheme Artify -archivePath $APP_ARCHIVE archive

echo "Exporting archive..."
xcodebuild -exportArchive -archivePath $APP_ARCHIVE -exportPath $APP_BUILD -exportOptionsPlist $APP_PLIST

echo "Cleaning up archive..."
rm -rf $APP_ARCHIVE

echo "Done"
