#!/bin/bash

# lifeBoard Xcode Setup Verification Script
# This script helps verify that files are ready for Xcode setup

echo "🔍 lifeBoard Xcode Setup Verification"
echo "======================================"
echo ""

# Check if we're in the right directory
if [ ! -d "LifeBoardCore" ]; then
    echo "❌ Error: Must run from lifeBoard.main directory"
    exit 1
fi

echo "✅ Current directory: $(pwd)"
echo ""

# Check for required directories
echo "📁 Checking project structure..."
directories=("lifeBoard" "LifeBoardCore" "LifeBoardWidgets" "LifeBoardiOS")
missing_dirs=()

for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo "  ✅ $dir/"
    else
        echo "  ❌ $dir/ (MISSING)"
        missing_dirs+=("$dir")
    fi
done

if [ ${#missing_dirs[@]} -gt 0 ]; then
    echo ""
    echo "❌ Missing directories: ${missing_dirs[*]}"
    exit 1
fi

echo ""
echo "📄 Checking key files..."

# Check tvOS app files
echo "  Checking tvOS app files..."
tvos_files=(
    "lifeBoard/LifeBoardApp.swift"
    "lifeBoard/Platform/Authentication/SignInView.swift"
    "lifeBoard/UserProfile/Widgets/DashboardView.swift"
    "lifeBoard/UserProfile/Widgets/WidgetGrid.swift"
    "lifeBoard/UserProfile/Widgets/WidgetView.swift"
    "lifeBoard/Navigation/NavigationCoordinator.swift"
)

missing_files=()
for file in "${tvos_files[@]}"; do
    if [ -f "$file" ]; then
        echo "    ✅ $file"
    else
        echo "    ❌ $file (MISSING)"
        missing_files+=("$file")
    fi
done

# Check iOS app files
echo "  Checking iOS app files..."
ios_files=(
    "LifeBoardiOS/LifeBoardiOSApp.swift"
    "LifeBoardiOS/Configuration/ConfigurationView.swift"
    "LifeBoardiOS/Configuration/WidgetList.swift"
)

for file in "${ios_files[@]}"; do
    if [ -f "$file" ]; then
        echo "    ✅ $file"
    else
        echo "    ❌ $file (MISSING)"
        missing_files+=("$file")
    fi
done

# Check framework files
echo "  Checking framework files..."
framework_files=(
    "LifeBoardCore/Platform/Display/DesignSystem.swift"
    "LifeBoardCore/CloudKit/CloudKitManager.swift"
    "LifeBoardCore/Security/KeychainManager.swift"
    "LifeBoardWidgets/Calendar/CalendarWidget.swift"
    "LifeBoardWidgets/Weather/WeatherWidget.swift"
)

for file in "${framework_files[@]}"; do
    if [ -f "$file" ]; then
        echo "    ✅ $file"
    else
        echo "    ❌ $file (MISSING)"
        missing_files+=("$file")
    fi
done

if [ ${#missing_files[@]} -gt 0 ]; then
    echo ""
    echo "❌ Missing files found. Please check the project structure."
    exit 1
fi

echo ""
echo "🔧 Checking code configuration..."

# Check CloudKit identifier
if grep -q "iCloud.com.lifeboardapp.lifeBoard" "LifeBoardCore/CloudKit/CloudKitManager.swift"; then
    echo "  ✅ CloudKit identifier configured"
else
    echo "  ⚠️  CloudKit identifier may need updating"
fi

# Check App Group identifier
if grep -q "group.com.lifeboardapp.lifeBoard" "LifeBoardCore/Security/KeychainManager.swift"; then
    echo "  ✅ App Group identifier configured"
else
    echo "  ⚠️  App Group identifier may need updating"
fi

echo ""
echo "✅ All files are ready for Xcode setup!"
echo ""
echo "📋 Next Steps:"
echo "  1. Open Xcode project: lifeBoard/lifeBoard.xcodeproj"
echo "  2. Follow XCODE_SETUP_STEPS.md for detailed instructions"
echo "  3. Or use XCODE_QUICK_REFERENCE.md for quick reference"
echo ""
echo "🎯 Quick Start:"
echo "  - Add tvOS files: lifeBoard/ folder → lifeBoard target"
echo "  - Create frameworks: LifeBoardCore, LifeBoardWidgets"
echo "  - Add framework files to their respective targets"
echo "  - Create iOS target: LifeBoardiOS"
echo "  - Configure capabilities: CloudKit, App Groups, Sign in with Apple"
echo ""

