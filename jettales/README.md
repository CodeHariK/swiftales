# Jettales - Android Jetpack Compose App

A native Android application built with Jetpack Compose.

## Prerequisites

- Android SDK (API level 24 or higher)
- JDK 19 or higher
- Gradle 8.2 or higher

## Building the Project

### Using Gradle Wrapper (Recommended)

1. **Make sure you have the Android SDK installed and set ANDROID_HOME:**
   ```bash
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
   ```

2. **Build the project:**
   ```bash
   ./gradlew build
   ```

3. **Install on a connected device or emulator:**
   ```bash
   ./gradlew installDebug
   ```

4. **Run tests:**
   ```bash
   ./gradlew test
   ```

5. **Clean build:**
   ```bash
   ./gradlew clean
   ```

### Using Command Line Tools

If you have the Android SDK command-line tools installed:

1. **Set up environment variables:**
   ```bash
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
   ```

2. **Create an AVD (Android Virtual Device) if you don't have one:**
   ```bash
   $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "system-images;android-34;google_apis;x86_64"
   $ANDROID_HOME/cmdline-tools/latest/bin/avdmanager create avd -n jettales_avd -k "system-images;android-34;google_apis;x86_64"
   ```

3. **Start the emulator:**
   ```bash
   $ANDROID_HOME/emulator/emulator -avd jettales_avd &
   ```

4. **Build and install:**
   ```bash
   ./gradlew installDebug
   ```

## Project Structure

```
jettales/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/jettales/
│   │   │   │   ├── MainActivity.kt
│   │   │   │   └── ui/theme/
│   │   │   ├── res/
│   │   │   └── AndroidManifest.xml
│   │   ├── test/
│   │   └── androidTest/
│   └── build.gradle.kts
├── gradle/
│   └── wrapper/
├── build.gradle.kts
├── settings.gradle.kts
└── gradle.properties
```

## Features

- Jetpack Compose UI
- Material Design 3
- Dark theme support
- Dynamic colors (Android 12+)

## Development

The main entry point is `MainActivity.kt` which uses Jetpack Compose to render the UI.

## License

This project is part of the Swiftales workspace.

