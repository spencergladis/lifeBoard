# lifeBoard - Command Center for Your Life

## Overview

lifeBoard is a tvOS Command Center application with an iOS companion app. It provides a customizable dashboard with rich integrations, empowering visual people to optimize their life.

## Architecture

- **Platform Component**: Authentication, display characteristics, customization
- **User Profile Component**: User data, widgets, services
- **Programmatic Design System**: All UI is code-based, no static assets
- **CloudKit Sync**: Seamless data synchronization between devices

## Project Structure

```
lifeBoard.main/
├── Documentation/          # Project documentation
│   ├── BUILD_SUMMARY.md
│   ├── ENHANCEMENTS.md
│   ├── EXECUTION_SUMMARY.md
│   ├── GITHUB_SETUP.md
│   ├── QUICK_START.md
│   ├── XCODE_EXECUTION_CHECKLIST.md
│   ├── XCODE_QUICK_REFERENCE.md
│   └── XCODE_SETUP_STEPS.md
├── Scripts/                # Build and setup scripts
│   └── setup_xcode.sh
├── LifeBoardCore/          # Shared framework
│   ├── Platform/
│   │   ├── Display/        # DesignSystem, LiquidGlass, AuroraBackground, ThemeManager
│   │   ├── Authentication/ # AuthenticationManager
│   │   └── System/         # FocusableCard
│   ├── UserProfile/
│   │   ├── Models/         # UserProfile, Widget, DashboardLayout
│   │   ├── Profile/        # ProfileDataManager
│   │   └── Widgets/        # WidgetProtocol, WidgetProvider, WidgetManager
│   ├── CloudKit/           # CloudKitManager
│   └── Security/           # KeychainManager
├── lifeBoard/              # tvOS app (lowercase to match Xcode project)
│   ├── LifeBoardApp.swift
│   ├── Navigation/
│   │   └── NavigationCoordinator.swift
│   ├── Platform/
│   │   └── Authentication/
│   │       └── SignInView.swift
│   ├── UserProfile/
│   │   └── Widgets/
│   │       ├── DashboardView.swift
│   │       ├── WidgetGrid.swift
│   │       └── WidgetView.swift
│   ├── lifeBoard.docc/     # Documentation catalog
│   └── lifeBoard.xcodeproj/
├── LifeBoardiOS/           # iOS companion app
│   ├── LifeBoardiOSApp.swift
│   ├── Configuration/
│   │   ├── ConfigurationView.swift
│   │   └── WidgetList.swift
│   └── UserProfile/
│       └── Profile/
│           └── ProfileSettingsView.swift
└── LifeBoardWidgets/       # Widget implementations
    ├── Calendar/
    │   ├── CalendarWidget.swift
    │   ├── CalendarWidgetView.swift
    │   └── CalendarWidgetContainer.swift
    ├── Home/
    │   ├── HomeWidget.swift
    │   └── HomeWidgetView.swift
    ├── Music/
    │   ├── MusicWidget.swift
    │   └── MusicWidgetView.swift
    └── Weather/
        ├── WeatherWidget.swift
        └── WeatherWidgetView.swift
```

## Setup Instructions

### 1. Create Xcode Project

1. Open Xcode
2. Create new workspace: `lifeBoard.xcworkspace`
3. Add tvOS target: `lifeBoard`
4. Add iOS target: `LifeBoardiOS`
5. Create shared framework: `LifeBoardCore`

### 2. Configure CloudKit

1. Enable CloudKit capability for both targets
2. Create CloudKit container: `iCloud.com.lifeboard.app`
3. Configure Development environment
4. Create record types in CloudKit Dashboard:
   - `UserProfile` (name, email, photoURL)
   - `Widget` (name, type, position, size, config)
   - `DashboardLayout` (widgetIDs, layout)

### 3. Configure App Groups

1. Enable App Groups capability for both targets
2. Create app group: `group.com.lifeboard.app`
3. Update `KeychainManager.swift` with your app group identifier

### 4. Configure Sign in with Apple

1. Enable Sign in with Apple capability for tvOS target
2. Configure in Apple Developer portal
3. Update bundle identifier as needed

### 5. Add Files to Project

Add all Swift files to their respective targets:
- `LifeBoardCore` files → LifeBoardCore framework
- `lifeBoard` files → lifeBoard (tvOS) target
- `LifeBoardiOS` files → LifeBoardiOS (iOS) target
- `LifeBoardWidgets` files → Both targets

**Note**: The tvOS app directory is named `lifeBoard` (lowercase) to match the Xcode project structure.

### 6. Dependencies

- SwiftUI (built-in)
- CloudKit (built-in)
- EventKit (for Calendar widget)
- AuthenticationServices (for Sign in with Apple)

## Design System

All UI uses the programmatic design system:

- **DesignSystem.swift**: Single source of truth for all constants
- **LiquidGlassModifier**: `.liquidGlass()` modifier for glass effects
- **FocusableCard**: Automatic tvOS focus handling
- **AuroraBackground**: Programmatic animated background

## Widget System

Widgets conform to `WidgetProtocol`:
- `CalendarWidget`: Uses EventKit for calendar events
- `WeatherWidget`: Mock data for prototype

To add a new widget:
1. Create widget struct conforming to `WidgetProtocol`
2. Create widget view using DesignSystem constants
3. Register in `WidgetProvider.shared.register()`

## Current Status

✅ **Completed**:
- Design System (4 core files)
- Authentication Manager
- CloudKit Manager
- Keychain Manager
- User Profile models
- Widget system foundation
- Calendar Widget
- Weather Widget
- tvOS Dashboard UI
- iOS Configuration UI

⏳ **Next Steps**:
1. Create Xcode project and configure targets
2. Set up CloudKit schema
3. Test Sign in with Apple flow
4. Test widget display and data
5. Test CloudKit sync
6. Polish and optimize

## Prototype Features

- Sign in with Apple authentication
- Dashboard with 2 widgets (Calendar, Weather)
- Liquid Glass aesthetic
- Aurora background animation
- Focus Engine navigation
- Basic CloudKit sync
- iOS widget management

## Notes

- CloudKit container identifier needs to be updated in `CloudKitManager.swift`
- App group identifier needs to be updated in `LifeBoardCore/Security/KeychainManager.swift`
- Calendar widget requires EventKit permissions
- Weather widget uses mock data (no API needed for prototype)

