#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "==> Building QBMenubar and QBMenubarWidget in Release mode..."
swift build -c release

BIN_DIR="$(swift build -c release --show-bin-path)"
MAIN_BIN="$BIN_DIR/QBMenubar"
WIDGET_BIN="$BIN_DIR/QBMenubarWidget"

APP_DIR="$DIR/QBMenubar.app"
CONTENTS_DIR="$APP_DIR/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"
PLUGINS_DIR="$CONTENTS_DIR/PlugIns"
WIDGET_APPEX="$PLUGINS_DIR/QBMenubarWidget.appex"
WIDGET_CONTENTS="$WIDGET_APPEX/Contents"
WIDGET_MACOS="$WIDGET_CONTENTS/MacOS"

echo "==> Creating macOS App Bundle at $APP_DIR..."
rm -rf "$APP_DIR"
mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"
mkdir -p "$WIDGET_MACOS"

cp "$MAIN_BIN" "$MACOS_DIR/QBMenubar"
chmod +x "$MACOS_DIR/QBMenubar"

cp "$WIDGET_BIN" "$WIDGET_MACOS/QBMenubarWidget"
chmod +x "$WIDGET_MACOS/QBMenubarWidget"

if [ -f "$DIR/AppIcon.icns" ]; then
    cp "$DIR/AppIcon.icns" "$RESOURCES_DIR/AppIcon.icns"
fi

cat <<EOF > "$WIDGET_CONTENTS/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundlePackageType</key>
    <string>XPC!</string>
    <key>CFBundleName</key>
    <string>QBMenubarWidget</string>
    <key>CFBundleDisplayName</key>
    <string>qBittorrent</string>
    <key>CFBundleIdentifier</key>
    <string>com.antigravity.QBMenubar.QBMenubarWidget</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleVersion</key>
    <string>1.3.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.3.0</string>
    <key>CFBundleExecutable</key>
    <string>QBMenubarWidget</string>
    <key>CFBundleSupportedPlatforms</key>
    <array>
        <string>MacOSX</string>
    </array>
    <key>LSMinimumSystemVersion</key>
    <string>14.0</string>
    <key>NSExtension</key>
    <dict>
        <key>NSExtensionPointIdentifier</key>
        <string>com.apple.widgetkit-extension</string>
    </dict>
</dict>
</plist>
EOF

cat <<EOF > "$CONTENTS_DIR/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleName</key>
    <string>QBMenubar</string>
    <key>CFBundleDisplayName</key>
    <string>QBMenubar</string>
    <key>CFBundleIdentifier</key>
    <string>com.antigravity.QBMenubar</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleVersion</key>
    <string>1.3.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.3.0</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>CFBundleExecutable</key>
    <string>QBMenubar</string>
    <key>CFBundleSupportedPlatforms</key>
    <array>
        <string>MacOSX</string>
    </array>
    <key>LSMinimumSystemVersion</key>
    <string>14.0</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLName</key>
            <string>com.antigravity.QBMenubar</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>qbmenubar</string>
            </array>
        </dict>
    </array>
</dict>
</plist>
EOF

echo "==> Code-signing QBMenubarWidget.appex with Sandbox and App Group..."
codesign --force --sign - --entitlements "$DIR/QBMenubarWidget.entitlements" "$WIDGET_APPEX"

echo "==> Code-signing QBMenubar.app..."
codesign --force --sign - --entitlements "$DIR/QBMenubar.entitlements" "$APP_DIR"

echo "==> QBMenubar.app with QBMenubarWidget successfully created and code-signed!"
echo "Location: $APP_DIR"
