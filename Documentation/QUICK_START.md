# lifeBoard Prototype - Quick Start Guide

## 🚀 Getting Started

This guide will help you set up the Xcode project and get the prototype running.

## Step 1: Create Xcode Project

1. **Open Xcode**
2. **Create New Project**
   - Choose "tvOS" → "App"
   - Product Name: `lifeBoard`
   - Interface: SwiftUI
   - Language: Swift
   - Save location: `/Users/spencergladis/lifeBoard.main/`

3. **Add iOS Target**
   - File → New → Target
   - Choose "iOS" → "App"
   - Product Name: `LifeBoardiOS`
   - Interface: SwiftUI
   - Language: Swift

4. **Create Shared Framework**
   - File → New → Target
   - Choose "Framework"
   - Product Name: `LifeBoardCore`
   - Language: Swift

## Step 2: Add Files to Project

### Add LifeBoardCore Framework Files

1. Right-click `LifeBoardCore` in Project Navigator
2. Select "Add Files to LifeBoardCore..."
3. Add these folders/files:
   - `LifeBoardCore/Platform/` (all files)
   - `LifeBoardCore/UserProfile/` (all files)
   - `LifeBoardCore/CloudKit/CloudKitManager.swift`

### Add LifeBoardSecurity Framework

1. Create new framework target: `LifeBoardSecurity`
2. Add file: `LifeBoardSecurity/KeychainManager.swift`

### Add LifeBoardWidgets Framework

1. Create new framework target: `LifeBoardWidgets`
2. Add folders:
   - `LifeBoardWidgets/Calendar/` (all files)
   - `LifeBoardWidgets/Weather/` (all files)

### Add tvOS App Files

1. Select `lifeBoard` target
2. Add files:
   - `lifeBoard/LifeBoardApp.swift` (replace default)
   - `lifeBoard/Platform/Authentication/SignInView.swift`
   - `lifeBoard/UserProfile/Widgets/` (all files)
   - `lifeBoard/Navigation/NavigationCoordinator.swift`

### Add iOS App Files

1. Select `LifeBoardiOS` target
2. Add files:
   - `LifeBoardiOS/LifeBoardiOSApp.swift` (replace default)
   - `LifeBoardiOS/Configuration/` (all files)
   - `LifeBoardiOS/UserProfile/Profile/ProfileSettingsView.swift`

## Step 3: Configure Dependencies

### For lifeBoard (tvOS) Target:
- Add `LifeBoardCore` framework
- Add `LifeBoardSecurity` framework
- Add `LifeBoardWidgets` framework

### For LifeBoardiOS (iOS) Target:
- Add `LifeBoardCore` framework
- Add `LifeBoardSecurity` framework
- Add `LifeBoardWidgets` framework

### For LifeBoardCore Framework:
- Add `LifeBoardSecurity` framework (if needed)

## Step 4: Configure Capabilities

### CloudKit (Both Targets)

1. Select target → Signing & Capabilities
2. Click "+ Capability"
3. Add "CloudKit"
4. Create container: `iCloud.com.lifeboard.app`
5. **Update `CloudKitManager.swift`**:
   ```swift
   container = CKContainer(identifier: "iCloud.com.lifeboard.app")
   ```
   Replace with your actual container identifier

### App Groups (Both Targets)

1. Select target → Signing & Capabilities
2. Click "+ Capability"
3. Add "App Groups"
4. Create group: `group.com.lifeboard.app`
5. **Update `KeychainManager.swift`**:
   ```swift
   self.appGroup = "group.com.lifeboard.app"
   ```
   Replace with your actual app group identifier

### Sign in with Apple (tvOS Target Only)

1. Select `lifeBoard` target → Signing & Capabilities
2. Click "+ Capability"
3. Add "Sign in with Apple"
4. Configure in Apple Developer portal

## Step 5: Configure Info.plist

### For lifeBoard (tvOS) Target:

Add to `Info.plist`:
```xml
<key>NSCalendarsUsageDescription</key>
<string>lifeBoard needs access to your calendar to display upcoming events.</string>
```

## Step 6: Create CloudKit Schema

1. Open CloudKit Dashboard (developer.apple.com)
2. Select your container: `iCloud.com.lifeboard.app`
3. Go to "Schema" → "Record Types"
4. Create record types:

### UserProfile Record Type
- `name` (String, Required)
- `email` (String, Required)
- `photoURL` (String, Optional)
- `createdAt` (Date/Time, Required)
- `updatedAt` (Date/Time, Required)

### Widget Record Type
- `name` (String, Required)
- `type` (String, Required)
- `position` (Int64, Required)
- `size` (String, Required)
- `config` (Bytes, Optional)
- `createdAt` (Date/Time, Required)
- `updatedAt` (Date/Time, Required)

### DashboardLayout Record Type
- `widgetIDs` (String List, Required)
- `layout` (Bytes, Optional)

## Step 7: Build and Run

1. **Select tvOS Simulator** (Apple TV)
2. **Select lifeBoard scheme**
3. **Build** (⌘B)
4. **Run** (⌘R)

## Step 8: Test Flow

1. **Sign In**: Use Sign in with Apple
2. **Dashboard**: Should see greeting and widgets
3. **Widgets**: Calendar and Weather widgets should display
4. **Focus**: Navigate with Apple Remote (simulator)
5. **iOS App**: Run LifeBoardiOS to configure widgets

## Troubleshooting

### Build Errors

- **Missing imports**: Ensure all frameworks are added as dependencies
- **CloudKit errors**: Verify container identifier matches
- **Keychain errors**: Verify app group identifier matches
- **EventKit errors**: Add NSCalendarsUsageDescription to Info.plist

### Runtime Errors

- **CloudKit not working**: Check iCloud account is signed in
- **Calendar not loading**: Grant calendar permissions when prompted
- **Focus not working**: Ensure running on tvOS (not iOS)

## Next Steps

Once prototype is running:
1. Test all features
2. Verify CloudKit sync works
3. Test widget data display
4. Verify focus navigation
5. Polish visual effects
6. Add more widgets
7. Implement service integrations

## Support Files

- `README.md` - Full project documentation
- `BUILD_SUMMARY.md` - Complete build status
- Architecture plan: `.cursor/plans/apple_tv_dashboard_app_85ee9c8a.plan.md`

