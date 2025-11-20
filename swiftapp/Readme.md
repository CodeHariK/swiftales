pod deintegrate && pod install

xcodebuild -list

xcrun simctl list devices
xcrun simctl list devicetypes
xcrun simctl shutdown "iPhone_17_Pro"
xcrun simctl erase "iPhone_17_Pro"
xcrun simctl delete DEVICE_ID

xcrun simctl create "iPhone_17_Pro" "iPhone 17 Pro"
xcrun simctl boot "iPhone_17_Pro"

xcodebuild -scheme swiftales -destination 'platform=iOS Simulator,name=iPhone_17_Pro' build

xcrun simctl install "iPhone_17_Pro" "/Users/a24/Library/Developer/Xcode/DerivedData/swiftales-dcvvwukzlumlclapgofwwstfbkjz/Build/Products/Debug-iphonesimulator/swiftales.app"

xcrun simctl launch "iPhone_17_Pro" run.shark.swiftales
