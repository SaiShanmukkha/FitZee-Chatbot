# Flutter Installation and Setup Guide

This guide will walk you through the steps to install Flutter, set up Android Studio, download API 33 Android emulator, configure the Flutter toolchain, and run a Flutter application. Additionally, it includes instructions to build an Android APK.

---

## Prerequisites

Before starting, ensure you have the following:
- A computer running macOS, Windows, or Linux.
- Administrator access to install software.
- At least 2GB of free disk space.

---

## Step 1: Install Flutter SDK

1. **Download Flutter SDK:**
   - Visit the [Flutter Download Page](https://flutter.dev/docs/get-started/install).
   - Choose the appropriate version for your operating system.

2. **Extract Flutter:**
   - Extract the downloaded zip file to a location of your choice (e.g., `C:\src\flutter` for Windows).

3. **Add Flutter to PATH:**
   - Update your system's environment variables:
     - On **Windows**: Add `flutter/bin` to the PATH variable.
     - On **macOS/Linux**: Add the following line to your `.bashrc` or `.zshrc` file:
       bash
       export PATH="$PATH:[PATH_TO_FLUTTER_DIRECTORY]/flutter/bin"
       

4. **Verify Installation:**
   - Run the following command in a terminal:
     bash
     flutter doctor
     
   - This will display a summary of your Flutter installation and indicate any missing dependencies.

---

## Step 2: Install Android Studio

1. **Download and Install:**
   - Download Android Studio from the [official website](https://developer.android.com/studio).
   - Follow the installation instructions for your operating system.

2. **Set Up Android SDK:**
   - Install Flutter plugin in andriod studio.
   - Open Android Studio and go to **File > Settings > Appearance & Behavior > System Settings > Android SDK**.
   - Ensure that the following components are installed:
     - **Android SDK Platform-Tools**
     - **Android SDK Build-Tools**
     - **API 33 (Android 13)**

4. **Create an Android Emulator:**
   - Go to **Tools > Device Manager** and create a new virtual device.
   - Select a hardware profile (e.g., Pixel 8).
   - Choose **API 33** as the system image.
   - Finish the setup and launch the emulator.

---

## Step 3: Set Up Flutter Toolchain

1. Run the following command to accept the Android licenses:
   ```bash
   flutter doctor --android-licenses
   ```
   
2. Verify the Flutter setup:
   ```bash
   flutter doctor
   ```
   - Ensure there are no errors, and all checks are marked as `✓`.

---

## Step 4: Create and Run a Flutter App

1. **Create a New Flutter Project:**
   - Run the following command:
     bash
     flutter create my_app
     
   - Replace `my_app` with your desired project name.

2. **Navigate to the Project Directory:**
   ```bash
   cd my_app
   ```

3. **Run the App:**
   - Launch your Android emulator.
   - Run the following command to start the app:
     ```bash
     flutter run
     ```

---

## Step 5: Build an Android APK

1. **Prepare Your Project for Release:**
   - Open `android/app/build.gradle` and set the `minSdkVersion` to at least `21`.

2. **Generate the APK:**
   - Run the following command to build the release APK:
     bash
     flutter build apk --release
     
   - The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`.

3. **Install APK on Device:**
   - Transfer the APK to your Android device and install it.

---

## Common Issues and Fixes

1. **Flutter Not Recognized:**
   - Ensure Flutter is added to your system PATH correctly.

2. **Emulator Not Detected:**
   - Verify the emulator is running and that Android Studio SDK paths are configured.

3. **Build Fails:**
   - Run the following command to clean the build directory:
     bash
     flutter clean
     
   - Then rebuild:
     bash
     flutter build apk --release
     

---

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Android Studio Setup](https://developer.android.com/studio/intro)
- [Flutter Community](https://flutter.dev/community)

---

Enjoy developing with Flutter! 🚀
