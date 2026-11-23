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
    <string>QBMenubar</string>
    <key>CFBundleIdentifier</key>
    <string>com.antigravity.QBMenubar.QBMenubarWidget</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleVersion</key>
    <string>1.3.4</string>
    <key>CFBundleShortVersionString</key>
    <string>1.3.4</string>
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
    <string>1.3.4</string>
    <key>CFBundleShortVersionString</key>
    <string>1.3.4</string>
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
    <key>NSUserNotificationAlertStyle</key>
    <string>alert</string>
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

# Detect available code signing certificate in Keychain
SIGN_IDENTITY=$(security find-identity -v -p codesigning | grep "Apple Development" | head -n 1 | awk -F '"' '{print $2}')
if [ -z "$SIGN_IDENTITY" ]; then
    SIGN_IDENTITY=$(security find-identity -v -p codesigning | grep "Developer ID Application" | head -n 1 | awk -F '"' '{print $2}')
fi
if [ -z "$SIGN_IDENTITY" ]; then
    echo "==> Notice: No Apple Development or Developer ID certificate found; falling back to ad-hoc (-)"
    SIGN_IDENTITY="-"
else
    echo "==> Using code signing identity: $SIGN_IDENTITY"
fi

# Ensure clean entitlements
cat <<EOF > "$DIR/QBMenubarWidget.entitlements"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.app-sandbox</key>
    <true/>
    <key>com.apple.security.application-groups</key>
    <array>
        <string>27F3GS56YW.group.com.antigravity.QBMenubar</string>
        <string>group.com.antigravity.QBMenubar</string>
    </array>
</dict>
</plist>
EOF

cat <<EOF > "$DIR/QBMenubar.entitlements"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.application-groups</key>
    <array>
        <string>27F3GS56YW.group.com.antigravity.QBMenubar</string>
        <string>group.com.antigravity.QBMenubar</string>
    </array>
</dict>
</plist>
EOF

echo "==> Code-signing inner binaries and app extension..."
codesign --force --sign "$SIGN_IDENTITY" --entitlements "$DIR/QBMenubarWidget.entitlements" "$WIDGET_MACOS/QBMenubarWidget"
codesign --force --sign "$SIGN_IDENTITY" --entitlements "$DIR/QBMenubarWidget.entitlements" "$WIDGET_APPEX"

echo "==> Code-signing main executable and app bundle..."
codesign --force --sign "$SIGN_IDENTITY" --entitlements "$DIR/QBMenubar.entitlements" "$MACOS_DIR/QBMenubar"
codesign --force --sign "$SIGN_IDENTITY" --entitlements "$DIR/QBMenubar.entitlements" "$APP_DIR"

echo "==> QBMenubar.app with QBMenubarWidget successfully created and code-signed!"
echo "Location: $APP_DIR"
