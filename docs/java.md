# Java Reference

## Install Java (Ubuntu)

### Install OpenJDK 17
```bash
sudo apt install openjdk-17-jdk
```

### Install OpenJDK 21
```bash
sudo apt install openjdk-21-jdk
```

### Install multiple versions side by side
```bash
sudo apt install openjdk-17-jdk openjdk-21-jdk
```

---

## Switch Between Java Versions

```bash
sudo update-alternatives --config java
```

This will show a numbered list of installed versions — enter the number to switch.

---

## Check Current Java Version

```bash
java -version
javac -version
```

---

## Find Java Installation Path

```bash
which java
update-alternatives --list java
readlink -f $(which java)
```

---

## Set JAVA_HOME Environment Variable

```bash
# Add to ~/.bashrc or ~/.zshrc
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
source ~/.bashrc
```

### Verify
```bash
echo $JAVA_HOME
```

---

## SDKMAN (Recommended for Managing Multiple Versions)

### Install SDKMAN
```bash
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
```

### Install and switch Java with SDKMAN
```bash
sdk list java                            # list available versions
sdk install java 17.0.9-tem              # install a version
sdk use java 17.0.9-tem                  # use in current shell
sdk default java 17.0.9-tem             # set as default
sdk current java                         # show current version
sdk uninstall java 17.0.9-tem            # uninstall a version
```

---

## Maven Commands

```bash
mvn --version                            # check Maven version
mvn clean install                        # build and install to local repo
mvn clean package                        # build and package (jar/war)
mvn clean test                           # run tests
mvn spring-boot:run                      # run Spring Boot app
mvn dependency:tree                      # show dependency tree
mvn dependency:resolve                   # download all dependencies
```

---

## Gradle Commands

```bash
./gradlew --version                      # check Gradle version
./gradlew build                          # build project
./gradlew clean build                    # clean then build
./gradlew test                           # run tests
./gradlew run                            # run application
./gradlew tasks                          # list all available tasks
./gradlew dependencies                   # show dependency tree
```

---

## Set Gradle JVM Arguments (for large builds)

```bash
export GRADLE_OPTS='-Dorg.gradle.jvmargs="-XX:MaxMetaspaceSize=1g -Xmx4g" -Dfile.encoding=UTF-8 -Dorg.gradle.parallel=true -Dorg.gradle.daemon=false'
```
