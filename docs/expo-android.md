# Expo / React Native Local Build Reference

## Full Local Setup for Expo Android Builds

### 1. Install System Dependencies

```bash
sudo apt install -y build-essential git unzip zip curl wget ca-certificates openjdk-17-jdk
```

### 2. Install NVM and Node.js

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 20.19.4
nvm alias default 20.19.4
```

### 3. Set ANDROID_HOME and Download Android Command Line Tools

```bash
export ANDROID_HOME=$HOME/Android/Sdk
mkdir -p $ANDROID_HOME/cmdline-tools

wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdtools.zip
unzip -q cmdtools.zip -d $ANDROID_HOME/cmdline-tools
mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/tools
```

### 4. Add to PATH

```bash
export PATH=$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools:$PATH
```

> Add these exports to your `~/.bashrc` or `~/.zshrc` to make them permanent.

### 5. Accept SDK Licenses and Install SDK Packages

```bash
sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0" "ndk;27.1.12297006"
```

### 6. Set Android NDK and Java Paths

```bash
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/27.1.12297006
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
```

### 7. Set Gradle Options (prevents memory issues on large builds)

```bash
export GRADLE_OPTS='-Dorg.gradle.jvmargs="-XX:MaxMetaspaceSize=1g -Xmx4g" -Dfile.encoding=UTF-8 -Dorg.gradle.parallel=true -Dorg.gradle.daemon=false'
```

### 8. Install Expo and EAS CLI

```bash
npm install -g expo-cli eas-cli
```

### 9. Login to EAS and Build

```bash
eas login

# Build APK (preview profile)
eas build --platform android --local --profile preview

# Build AAB (production profile, for Play Store)
eas build --platform android --local --profile production
```

---

## Persistent Environment Variables

Add these lines to your `~/.bashrc` or `~/.zshrc` so they survive reboots:

```bash
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/27.1.12297006
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools:$PATH
export GRADLE_OPTS='-Dorg.gradle.jvmargs="-XX:MaxMetaspaceSize=1g -Xmx4g" -Dfile.encoding=UTF-8 -Dorg.gradle.parallel=true -Dorg.gradle.daemon=false'
```

---

## EAS Build Profiles (eas.json)

```json
{
  "build": {
    "preview": {
      "android": {
        "buildType": "apk"
      }
    },
    "production": {
      "android": {
        "buildType": "app-bundle"
      }
    }
  }
}
```

---

## Common Expo Commands

```bash
npx expo start                           # start the dev server
npx expo start --clear                   # clear cache and start
npx expo start --android                 # start and open on Android
npx expo install                         # install deps compatible with your SDK version
npx expo doctor                          # diagnose issues
npx expo prebuild                        # generate native android/ios folders
npx expo run:android                     # build and run on connected device/emulator
eas update                               # push OTA update
eas build:list                           # list recent EAS builds
eas submit                               # submit to app store
```
