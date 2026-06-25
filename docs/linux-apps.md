# Linux App Installations Reference

## VS Code — Install via apt (Ubuntu)

```bash
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt update
sudo apt install code
```

---

## VS Code — Update to Latest (Manual tar.gz Method)

This script downloads the latest VS Code tarball, replaces the old install, and updates the desktop entry.

```bash
#!/bin/bash

VSCODE_URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"
INSTALL_DIR="/opt/VSCode"
TEMP_FILE="/tmp/vscode.tar.gz"
DESKTOP_ENTRY="$HOME/.local/share/applications/code.desktop"

echo "Downloading latest VS Code..."
wget -O "$TEMP_FILE" "$VSCODE_URL"

echo "Removing old VS Code installation..."
sudo rm -rf "$INSTALL_DIR"

echo "Extracting VS Code..."
sudo mkdir -p "$INSTALL_DIR"
sudo tar -xzf "$TEMP_FILE" --strip-components=1 -C "$INSTALL_DIR"

sudo ln -sf "$INSTALL_DIR/code" /usr/local/bin/code

echo "Creating desktop entry..."
cat <<EOF | tee "$DESKTOP_ENTRY" > /dev/null
[Desktop Entry]
Name=Visual Studio Code
Comment=Code Editing. Redefined.
Exec=$INSTALL_DIR/code --no-sandbox %F
Icon=$INSTALL_DIR/resources/app/resources/linux/code.png
Type=Application
Terminal=false
Categories=Development;IDE;
MimeType=text/plain;
StartupWMClass=Code
EOF

chmod +x "$DESKTOP_ENTRY"
sudo chmod -R 755 "$INSTALL_DIR"
update-desktop-database ~/.local/share/applications/

echo "VS Code updated successfully!"
```

---

## Spotify — Install (Method 1 — Newer GPG Key)

```bash
curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client
```

## Spotify — Install (Method 2 — Alternate GPG Key)

```bash
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client
```

---

## GitHub CLI (gh)

```bash
sudo apt install gh
gh auth login                            # authenticate with GitHub
gh repo clone owner/repo                 # clone a repo
gh pr list                               # list pull requests
gh pr create                             # create a pull request
gh issue list                            # list issues
gh issue create                          # create an issue
gh workflow run workflow-name.yml        # trigger a workflow
```

---

## Google Chrome

```bash
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt install google-chrome-stable
```

---

## Brave Browser

```bash
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser
```

---

## Flatpak (for apps not in apt)

```bash
sudo apt install flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo reboot
flatpak install flathub app.id           # install a Flatpak app
flatpak run app.id                       # run a Flatpak app
flatpak list                             # list installed Flatpak apps
flatpak update                           # update all Flatpak apps
flatpak remove app.id                    # remove a Flatpak app
```

---

## Snap

```bash
sudo apt install snapd
sudo snap install app-name               # install a snap
sudo snap install app-name --classic     # install with classic confinement
snap list                                # list installed snaps
sudo snap refresh                        # update all snaps
sudo snap remove app-name               # remove a snap
```
