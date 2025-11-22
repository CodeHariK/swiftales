# Android Development Tools Makefile
# Lists all installed Android development tools and emulators

ANDROID_HOME ?= /Users/Shared/Android/sdk
SDKMANAGER = sdkmanager --sdk_root=$(ANDROID_HOME)

.PHONY: help list-emulators list-sdk list-tools list-all check-env

help:
	@echo "Android Development Tools - Available Commands:"
	@echo ""
	@echo "Environment & Tools:"
	@echo "  make list-emulators  - List all Android emulators (AVDs)"
	@echo "  make list-sdk       - List installed Android SDK packages"
	@echo "  make list-tools     - List installed development tools"
	@echo "  make list-all       - List everything"
	@echo "  make check-env       - Check environment setup"
	@echo ""
	@echo "Build & Install:"
	@echo "  make build          - Build the project"
	@echo "  make clean          - Clean build artifacts"
	@echo "  make install        - Install debug APK on device"
	@echo "  make uninstall      - Uninstall app from device"
	@echo "  make apk            - Build APK file"
	@echo "  make run            - Launch the app"
	@echo "  make stop           - Stop the app"
	@echo "  make redeploy       - Uninstall, install, and run"
	@echo ""
	@echo "Devices & Emulators:"
	@echo "  make devices        - List connected devices"
	@echo "  make emulator-list  - List available AVDs"
	@echo "  make emulator-start AVD=<name> - Start emulator"
	@echo "  make emulator-stop  - Stop emulator"
	@echo "  make emulator-delete AVD=<name> - Delete emulator"
	@echo "  make sdk-uninstall PACKAGE=<name> - Uninstall SDK package"
	@echo ""
	@echo "Debugging:"
	@echo "  make logcat         - View app logs"
	@echo "  make logcat-clear   - Clear logcat buffer"
	@echo "  make shell          - Open ADB shell"
	@echo ""
	@echo "Testing:"
	@echo "  make test           - Run all tests"
	@echo "  make test-unit      - Run unit tests"
	@echo "  make test-instrumented - Run instrumented tests"
	@echo ""
	@echo "For detailed help: make help-all"
	@echo ""
	@echo "ANDROID_HOME: $(ANDROID_HOME)"

list-emulators:
	@echo "=== Android Emulators (AVDs) ==="
	@if [ -z "$$ANDROID_HOME" ]; then \
		ANDROID_HOME=$(ANDROID_HOME); \
	fi; \
	if [ -d "$$ANDROID_HOME/cmdline-tools/latest/bin" ]; then \
		$$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager list avd; \
	elif [ -d "$$ANDROID_HOME/tools/bin" ]; then \
		$$ANDROID_HOME/tools/bin/avdmanager list avd; \
	else \
		echo "avdmanager not found. ANDROID_HOME: $$ANDROID_HOME"; \
	fi

list-sdk:
	@echo "=== Installed Android SDK Packages ==="
	@if command -v sdkmanager >/dev/null 2>&1; then \
		$(SDKMANAGER) --list_installed 2>/dev/null | grep -E "^[a-z]|^  " || echo "No packages found or sdkmanager error"; \
	else \
		echo "sdkmanager not found in PATH"; \
	fi
	@echo ""

list-tools:
	@echo "=== Development Tools ==="
	@echo "Android Tools:"
	@printf "  adb:          "; which adb 2>/dev/null || echo "not found"
	@printf "  emulator:     "; which emulator 2>/dev/null || echo "not found"
	@printf "  sdkmanager:   "; which sdkmanager 2>/dev/null || echo "not found"
	@printf "  avdmanager:   "; which avdmanager 2>/dev/null || echo "not found"
	@echo ""
	@echo "Build Tools:"
	@printf "  gradle:       "; which gradle 2>/dev/null || echo "not found"
	@printf "  java:         "; if command -v java >/dev/null 2>&1; then java -version 2>&1 | head -1; else echo "not found"; fi
	@printf "  javac:        "; which javac 2>/dev/null || echo "not found"
	@printf "  kotlin:       "; which kotlin 2>/dev/null || echo "not found"
	@echo ""
	@echo "Cross-platform:"
	@printf "  flutter:      "; which flutter 2>/dev/null || echo "not found"
	@printf "  dart:         "; which dart 2>/dev/null || echo "not found"
	@echo ""
	@echo "Version Info:"
	@if command -v java >/dev/null 2>&1; then \
		printf "  Java:        "; java -version 2>&1 | head -1; \
	fi
	@if command -v kotlin >/dev/null 2>&1; then \
		printf "  Kotlin:      "; kotlin -version 2>&1 | head -1; \
	fi
	@if command -v gradle >/dev/null 2>&1; then \
		printf "  Gradle:      "; gradle -version 2>&1 | grep "Gradle" | head -1; \
	fi
	@if command -v flutter >/dev/null 2>&1; then \
		printf "  Flutter:     "; flutter --version 2>&1 | head -1; \
	fi
	@echo ""

list-all: list-emulators list-sdk list-tools

check-env:
	@echo "=== Environment Check ==="
	@echo -n "ANDROID_HOME: "
	@if [ -z "$$ANDROID_HOME" ]; then \
		echo "not set (using default: $(ANDROID_HOME))"; \
	else \
		echo "$$ANDROID_HOME"; \
	fi
	@echo -n "ANDROID_SDK_ROOT: "
	@if [ -z "$$ANDROID_SDK_ROOT" ]; then \
		echo "not set"; \
	else \
		echo "$$ANDROID_SDK_ROOT"; \
	fi
	@echo ""
	@echo "SDK Directories:"
	@echo -n "  platforms:   "; ls -d $(ANDROID_HOME)/platforms/* 2>/dev/null | wc -l | xargs echo "directories found" || echo "not found"
	@echo -n "  build-tools: "; ls -d $(ANDROID_HOME)/build-tools/* 2>/dev/null | wc -l | xargs echo "versions found" || echo "not found"
	@echo -n "  emulator:    "; [ -d "$(ANDROID_HOME)/emulator" ] && echo "found" || echo "not found"
	@echo -n "  platform-tools: "; [ -d "$(ANDROID_HOME)/platform-tools" ] && echo "found" || echo "not found"
	@echo ""

# Quick commands using the alias
sdkm:
	@echo "Using: sdkmanager --sdk_root=$(ANDROID_HOME)"
	@$(SDKMANAGER) $(ARGS)

# Android Build Commands
.PHONY: build clean install uninstall run stop logcat

build:
	@echo "=== Building Android App ==="
	@./gradlew build

clean:
	@echo "=== Cleaning Build ==="
	@./gradlew clean

install:
	@echo "=== Installing App on Device/Emulator ==="
	@./gradlew installDebug
	@echo "=== Launching App ==="
	@adb shell am start -n com.jettales/.MainActivity || echo "App installed but could not launch automatically"

uninstall:
	@echo "=== Uninstalling App ==="
	@adb uninstall com.jettales || echo "App not installed or device not connected"

run:
	@echo "=== Running App ==="
	@adb shell am start -n com.jettales/.MainActivity

stop:
	@echo "=== Stopping App ==="
	@adb shell am force-stop com.jettales

logcat:
	@echo "=== Viewing Logcat (Ctrl+C to stop) ==="
	@adb logcat | grep -E "Jettales|AndroidRuntime|FATAL"

logcat-clear:
	@echo "=== Clearing Logcat ==="
	@adb logcat -c

# Device Management
.PHONY: devices connect disconnect shell

devices:
	@echo "=== Connected Devices ==="
	@adb devices -l

connect:
	@echo "=== Connecting to Device ==="
	@adb connect $(DEVICE_IP) || echo "Usage: make connect DEVICE_IP=<ip_address>"

disconnect:
	@echo "=== Disconnecting from Device ==="
	@adb disconnect

shell:
	@echo "=== Opening ADB Shell ==="
	@adb shell

# Emulator Commands
.PHONY: emulator-start emulator-stop emulator-list emulator-kill

emulator-start:
	@echo "=== Starting Emulator ==="
	@if [ -z "$(AVD)" ]; then \
		echo "Usage: make emulator-start AVD=<emulator_name>"; \
		echo "Available AVDs:"; \
		$(ANDROID_HOME)/emulator/emulator -list-avds; \
	else \
		$(ANDROID_HOME)/emulator/emulator -avd $(AVD) &; \
		echo "Starting $(AVD)..."; \
	fi

emulator-stop:
	@echo "=== Stopping Emulator ==="
	@adb emu kill || echo "No emulator running"

emulator-delete:
	@if [ -z "$(AVD)" ]; then \
		echo "Error: AVD name required. Usage: make emulator-delete AVD=<name>"; \
		echo "Available AVDs:"; \
		$(ANDROID_HOME)/cmdline-tools/latest/bin/avdmanager list avd 2>/dev/null || echo "No AVDs found"; \
		exit 1; \
	fi
	@$(ANDROID_HOME)/cmdline-tools/latest/bin/avdmanager delete avd -n "$(AVD)" || \
		(echo "Failed to delete emulator. Make sure the name is correct." && exit 1)

emulator-list:
	@$(ANDROID_HOME)/emulator/emulator -list-avds

emulator-kill:
	@echo "=== Killing All Emulators ==="
	@pkill -f emulator || echo "No emulators to kill"

# SDK Management
.PHONY: sdk-uninstall

sdk-uninstall:
	@if [ -z "$(PACKAGE)" ]; then \
		echo "Error: Package name required. Usage: make sdk-uninstall PACKAGE=<package_name>"; \
		echo "Example: make sdk-uninstall PACKAGE=system-images;android-34;google_apis_playstore;arm64-v8a"; \
		exit 1; \
	fi
	@echo "=== Uninstalling Package: $(PACKAGE) ==="
	@$(ANDROID_HOME)/cmdline-tools/latest/bin/sdkmanager --uninstall "$(PACKAGE)"

# APK Management
.PHONY: apk apk-install apk-path

apk:
	@echo "=== Building APK ==="
	@./gradlew assembleDebug
	@echo "APK location: app/build/outputs/apk/debug/app-debug.apk"

apk-install:
	@echo "=== Installing APK ==="
	@adb install -r app/build/outputs/apk/debug/app-debug.apk

apk-path:
	@echo "app/build/outputs/apk/debug/app-debug.apk"

# Testing
.PHONY: test test-unit test-instrumented

test:
	@echo "=== Running All Tests ==="
	@./gradlew test connectedAndroidTest

test-unit:
	@echo "=== Running Unit Tests ==="
	@./gradlew test

test-instrumented:
	@echo "=== Running Instrumented Tests ==="
	@./gradlew connectedAndroidTest

# Gradle Commands
.PHONY: gradle-version gradle-wrapper gradle-dependencies

gradle-version:
	@echo "=== Gradle Version ==="
	@./gradlew --version

gradle-wrapper:
	@echo "=== Updating Gradle Wrapper ==="
	@./gradlew wrapper --gradle-version=$(VERSION) || echo "Usage: make gradle-wrapper VERSION=<gradle_version>"

gradle-dependencies:
	@echo "=== Viewing Dependencies ==="
	@./gradlew app:dependencies

# Quick Development Workflow
.PHONY: dev rebuild redeploy

dev: clean build install run

rebuild: clean build

redeploy: uninstall install run

# Help with all commands
help-all:
	@echo "Android Development Commands:"
	@echo "  Build:"
	@echo "    make build          - Build the project"
	@echo "    make clean          - Clean build artifacts"
	@echo "    make rebuild        - Clean and build"
	@echo ""
	@echo "  Installation:"
	@echo "    make install        - Install debug APK on device"
	@echo "    make uninstall      - Uninstall app from device"
	@echo "    make apk            - Build APK file"
	@echo "    make apk-install    - Install APK file"
	@echo ""
	@echo "  Running:"
	@echo "    make run            - Launch the app"
	@echo "    make stop           - Stop the app"
	@echo "    make redeploy       - Uninstall, install, and run"
	@echo ""
	@echo "  Logging:"
	@echo "    make logcat         - View app logs"
	@echo "    make logcat-clear   - Clear logcat buffer"
	@echo ""
	@echo "  Devices:"
	@echo "    make devices        - List connected devices"
	@echo "    make shell          - Open ADB shell"
	@echo ""
	@echo "  Emulator:"
	@echo "    make emulator-list  - List available AVDs"
	@echo "    make emulator-start AVD=<name> - Start emulator"
	@echo "    make emulator-stop  - Stop emulator"
	@echo ""
	@echo "  Testing:"
	@echo "    make test           - Run all tests"
	@echo "    make test-unit      - Run unit tests"
	@echo "    make test-instrumented - Run instrumented tests"
	@echo ""
	@echo "  Gradle:"
	@echo "    make gradle-version - Show Gradle version"
	@echo "    make gradle-dependencies - Show dependency tree"

