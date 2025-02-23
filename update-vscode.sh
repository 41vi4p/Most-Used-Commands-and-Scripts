#!/bin/bash

# Define variables
VSCODE_URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-x64"
INSTALL_DIR="/opt/VSCode"
TEMP_FILE="/tmp/vscode.tar.gz"
DESKTOP_ENTRY="$HOME/.local/share/applications/code.desktop"

# Step 1: Download the latest VS Code
echo "Downloading latest VS Code..."
wget -O "$TEMP_FILE" "$VSCODE_URL"

# Step 2: Remove old installation
echo "Removing old VS Code installation..."
sudo rm -rf "$INSTALL_DIR"

# Step 3: Extract new version
echo "Extracting VS Code..."
sudo mkdir -p "$INSTALL_DIR"
sudo tar -xzf "$TEMP_FILE" --strip-components=1 -C "$INSTALL_DIR"

# Step 4: Create a symlink to make 'code' command available
sudo ln -sf "$INSTALL_DIR/code" /usr/local/bin/code

# Step 5: Ensure desktop entry exists
echo "Creating/updating desktop entry..."
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

# Step 6: Set permissions
chmod +x "$DESKTOP_ENTRY"
sudo chmod -R 755 "$INSTALL_DIR"

# Step 7: Refresh application database
update-desktop-database ~/.local/share/applications/

echo "VS Code updated successfully!"
