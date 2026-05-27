#Setting up expo locally
sudo apt install -y build-essential git unzip zip curl wget ca-certificates openjdk-17-jdk

#install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

source ~/.nvm/nvm.sh

#Install node using nvm
nvm install 20.19.4
#SEt default
nvm alias default 20.19.4

export ANDROID_HOME=$HOME/Android/Sdk

#Download tools
wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O cmdtools.zip

unzip -q cmdtools.zip -d $ANDROID_HOME/cmdline-tools

mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/tools

export PATH=$ANDROID_HOME/cmdline-tools/tools/bin:$ANDROID_HOME/platform-tools:$PATH

sdkmanager --licenses

sdkmanager "platform-tools" "platforms;android-35" "build-tools;35.0.0" "ndk;27.1.12297006"

export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/27.1.12297006

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

export GRADLE_OPTS='-Dorg.gradle.jvmargs="-XX:MaxMetaspaceSize=1g -Xmx4g" -Dfile.encoding=UTF-8 -Dorg.gradle.parallel=true -Dorg.gradle.daemon=false'

npm install -g expo-cli eas-cli

eas login

eas build --platform android --local
