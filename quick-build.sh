#!/bin/bash

# Quick build and run script for Swift app
echo "Building Swift app..."
xcodebuild -scheme swiftales -destination 'platform=iOS Simulator,arch=arm64,id=3907C358-736E-4636-943B-C3F0BBC38399' build

if [ $? -eq 0 ]; then
    echo "Build successful! Installing and launching..."
    xcrun simctl install "3907C358-736E-4636-943B-C3F0BBC38399" "/Users/a24/Library/Developer/Xcode/DerivedData/swiftales-dcvvwukzlumlclapgofwwstfbkjz/Build/Products/Debug-iphonesimulator/swiftales.app"
    xcrun simctl launch "3907C358-736E-4636-943B-C3F0BBC38399" run.shark.swiftales
    echo "App launched successfully!"
else
    echo "Build failed!"
fi
