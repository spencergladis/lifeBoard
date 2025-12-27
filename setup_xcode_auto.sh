#!/bin/bash

# lifeBoard Xcode Project Auto-Configuration Script
# Run this script on your Mac with Xcode installed to automatically configure the project

set -e

echo "🔧 lifeBoard Xcode Project Setup"
echo "=================================="
echo ""

# Configuration
PROJECT_PATH="LifeBoard/lifeBoard.xcodeproj"
WORKSPACE_PATH="LifeBoard/lifeBoard.xcworkspace"
TVOS_TARGET="lifeBoard"
IOS_TARGET="LifeBoardiOS"
FRAMEWORKS=("LifeBoardCore" "LifeBoardSecurity" "LifeBoardWidgets")

# Verify we're in the right directory
if [ ! -d "LifeBoardCore" ]; then
    echo "❌ Error: Must run from project root directory"
    echo "   Current directory: $(pwd)"
    exit 1
fi

echo "✅ Project root verified: $(pwd)"
echo ""

# Check if Xcode is available
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: xcodebuild not found"
    echo "   Please install Xcode Command Line Tools: xcode-select --install"
    exit 1
fi

echo "✅ Xcode found: $(xcodebuild -version | head -1)"
echo ""

# Function to create framework
create_framework() {
    local name=$1
    echo "→ Creating $name framework..."

    xcodebuild -project "$PROJECT_PATH" \
        -scheme "$name" \
        -showBuildSettings > /dev/null 2>&1 || {
        echo "  ⚠️  $name not yet configured, will create via Xcode"
        return 1
    }

    echo "  ✅ $name already exists"
    return 0
}

# Function to add files to target
add_files_to_target() {
    local target=$1
    local files_path=$2

    echo "→ Adding files to $target..."

    # This would need to be done in Xcode GUI or with complex pbxproj manipulation
    # For now, we'll document what needs to be done
    echo "  ℹ️  See instructions below"
}

# Create backup of original project
if [ -f "$PROJECT_PATH/project.pbxproj" ]; then
    cp "$PROJECT_PATH/project.pbxproj" "$PROJECT_PATH/project.pbxproj.backup"
    echo "✅ Backed up original project"
fi

echo ""
echo "📋 Configuration Status:"
echo "-" * 50
echo ""

# Check existing targets
echo "Checking existing targets..."
for framework in "${FRAMEWORKS[@]}"; do
    if create_framework "$framework" 2>/dev/null; then
        echo "  ✅ $framework"
    else
        echo "  ⚠️  $framework needs creation"
    fi
done

echo ""
echo "⚠️  NOTE: Complete Xcode Configuration"
echo "-" * 50
echo ""
echo "Due to Xcode's GUI-centric project management, some steps must be done manually in Xcode."
echo "Follow these steps in Xcode after opening the project:"
echo ""
echo "1. CREATE FRAMEWORK TARGETS"
echo "   For each framework (LifeBoardCore, LifeBoardSecurity, LifeBoardWidgets):"
echo "   • File → New → Target"
echo "   • Select Framework & Library → Framework"
echo "   • Product Name: [FrameworkName]"
echo "   • Language: Swift"
echo "   • Click Finish"
echo ""
echo "2. CREATE iOS TARGET"
echo "   • File → New → Target"
echo "   • Select iOS → App"
echo "   • Product Name: LifeBoardiOS"
echo "   • Interface: SwiftUI"
echo "   • Language: Swift"
echo "   • Click Finish"
echo ""
echo "3. ADD SOURCE FILES TO TARGETS"
echo "   For each target, drag-and-drop or Add Files:"
echo "   • LifeBoardCore: LifeBoardCore/ folder"
echo "   • LifeBoardSecurity: LifeBoardSecurity/ folder"
echo "   • LifeBoardWidgets: LifeBoardWidgets/ folder"
echo "   • lifeBoard (tvOS): lifeBoard/ folder"
echo "   • LifeBoardiOS: LifeBoardiOS/ folder"
echo ""
echo "   Make sure to:"
echo "   ✅ UNCHECK 'Copy items if needed'"
echo "   ✅ CHECK 'Create groups'"
echo "   ✅ SELECT correct target in 'Add to targets'"
echo ""
echo "4. CONFIGURE TARGET DEPENDENCIES"
echo "   For lifeBoard (tvOS) and LifeBoardiOS targets:"
echo "   • Select target"
echo "   • Build Phases tab"
echo "   • Link Binary With Libraries: Add LifeBoardCore, LifeBoardSecurity, LifeBoardWidgets"
echo ""
echo "5. CONFIGURE CAPABILITIES"
echo "   For lifeBoard (tvOS):"
echo "   • Signing & Capabilities tab"
echo "   • + Capability → CloudKit"
echo "   • + Capability → App Groups (group.com.lifeboardapp.lifeBoard)"
echo "   • + Capability → Sign in with Apple"
echo ""
echo "   For LifeBoardiOS:"
echo "   • Signing & Capabilities tab"
echo "   • + Capability → CloudKit"
echo "   • + Capability → App Groups (group.com.lifeboardapp.lifeBoard)"
echo ""
echo "6. BUILD & TEST"
echo "   • Select lifeBoard scheme"
echo "   • Select Apple TV 4K simulator"
echo "   • Product → Build (⌘B)"
echo ""
echo "✅ To get started:"
echo "   open LifeBoard/lifeBoard.xcodeproj"
echo ""
