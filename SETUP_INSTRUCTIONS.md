# lifeBoard Xcode Setup - Complete Guide

## Quick Summary

The lifeBoard project contains all source code ready for Xcode. You need to:
1. Open the existing Xcode project
2. Create 3 framework targets
3. Create 1 iOS app target
4. Add source files to each target
5. Configure capabilities

**Estimated time: 30-45 minutes**

---

## Prerequisites

- Mac with Xcode 15+ installed
- Apple Developer Account (for capabilities)
- Project files at: `/tmp/cc-agent/61937285/project`

---

## Step-by-Step Instructions

### Step 1: Open the Project

```bash
open LifeBoard/lifeBoard.xcodeproj
```

---

### Step 2: Create Framework Targets (3 frameworks)

Repeat these steps for: **LifeBoardCore**, **LifeBoardSecurity**, **LifeBoardWidgets**

#### For each framework:

1. In Xcode top menu: **File → New → Target**
2. Select **Framework & Library** → **Framework** → **Next**
3. Enter details:
   - **Product Name**: `LifeBoardCore` (or Security/Widgets)
   - **Organization Identifier**: `com.lifeboardapp`
   - **Language**: Swift
   - **Platforms**: Choose based on framework needs
4. Click **Finish**
5. If asked "Activate scheme?", click **Activate**

**Result**: You should see 3 new frameworks in Project Navigator

---

### Step 3: Create iOS Target

1. **File → New → Target**
2. Select **iOS** → **App** → **Next**
3. Enter details:
   - **Product Name**: `LifeBoardiOS`
   - **Organization Identifier**: `com.lifeboardapp`
   - **Interface**: SwiftUI
   - **Language**: Swift
   - **☐ Include Tests**: Leave unchecked
4. Click **Finish**
5. If asked "Activate scheme?", click **Activate**

**Result**: New iOS app target appears in Project Navigator

---

### Step 4: Add Source Files to Targets

For each target, you need to add the corresponding source files.

#### 4A. Add LifeBoardCore Files

1. In Project Navigator, click on **LifeBoardCore** folder/target
2. **File → Add Files to "lifeBoard"...**
3. Navigate to project root folder
4. **Select**: `LifeBoardCore/` folder
5. **Important dialog settings**:
   - ☐ **Copy items if needed** → UNCHECK
   - ☑ **Create groups** → CHECK
   - ☑ **Add to targets** → Select **LifeBoardCore** only
6. Click **Add**

#### 4B. Add LifeBoardSecurity Files

1. Click on **LifeBoardSecurity** folder/target
2. **File → Add Files to "lifeBoard"...**
3. **Select**: `LifeBoardSecurity/` folder
4. **Same dialog settings** (uncheck copy, check groups, select LifeBoardSecurity)
5. Click **Add**

#### 4C. Add LifeBoardWidgets Files

1. Click on **LifeBoardWidgets** folder/target
2. **File → Add Files to "lifeBoard"...**
3. **Select**: `LifeBoardWidgets/` folder
4. **Same dialog settings** (uncheck copy, check groups, select LifeBoardWidgets)
5. Click **Add**

#### 4D. Add tvOS App Files

1. Click on **lifeBoard** folder (tvOS app)
2. Delete any default files (like `lifeBoard.swift`)
3. **File → Add Files to "lifeBoard"...**
4. **Select**: `lifeBoard/` folder
5. **Dialog settings**: uncheck copy, check groups, select lifeBoard target
6. Click **Add**

#### 4E. Add iOS App Files

1. Click on **LifeBoardiOS** folder/target
2. Delete default `LifeBoardiOSApp.swift` if present
3. **File → Add Files to "lifeBoard"...**
4. **Select**: `LifeBoardiOS/` folder
5. **Dialog settings**: uncheck copy, check groups, select LifeBoardiOS target
6. Click **Add**

---

### Step 5: Configure Target Dependencies

The app targets (lifeBoard and LifeBoardiOS) need to link to the framework targets.

#### For lifeBoard (tvOS):

1. Click **lifeBoard** target in Project Navigator
2. Go to **Build Phases** tab (next to General, Info, etc.)
3. Expand **Link Binary With Libraries** section
4. Click **+** button
5. Add these frameworks (one at a time):
   - `LifeBoardCore.framework`
   - `LifeBoardSecurity.framework`
   - `LifeBoardWidgets.framework`
6. Click **Add**

#### For LifeBoardiOS:

1. Click **LifeBoardiOS** target
2. Go to **Build Phases** tab
3. Expand **Link Binary With Libraries**
4. Add same 3 frameworks
5. Click **Add**

#### For LifeBoardCore:

1. Click **LifeBoardCore** target
2. Go to **Build Phases** tab
3. Expand **Link Binary With Libraries**
4. Add **LifeBoardSecurity.framework** (if LifeBoardCore imports KeychainManager)

---

### Step 6: Configure Capabilities

Capabilities enable features like CloudKit and Sign in with Apple.

#### For lifeBoard (tvOS) - 3 capabilities:

1. Click **lifeBoard** target
2. Go to **Signing & Capabilities** tab
3. Click **+ Capability** (top left)
4. Search and double-click: **CloudKit**
   - Note the container name (usually `iCloud.com.lifeboardapp.lifeBoard`)
5. Repeat: Add **App Groups**
   - Click **+** and add: `group.com.lifeboardapp.lifeBoard`
6. Repeat: Add **Sign in with Apple**
   - No additional setup needed

#### For LifeBoardiOS - 2 capabilities:

1. Click **LifeBoardiOS** target
2. Go to **Signing & Capabilities** tab
3. Add **CloudKit** (same container as tvOS)
4. Add **App Groups**: `group.com.lifeboardapp.lifeBoard`

---

### Step 7: Update Code Identifiers

After adding capabilities, you may need to update code if identifiers differ.

#### Check CloudKit Identifier

1. Open `LifeBoardCore/CloudKit/CloudKitManager.swift`
2. Find: `container = CKContainer(identifier: "iCloud.com.lifeboardapp.lifeBoard")`
3. If your container identifier is different, update it to match Xcode

#### Check App Groups Identifier

1. Open `LifeBoardCore/Security/KeychainManager.swift`
2. Find the app group identifier
3. If different, update to: `group.com.lifeboardapp.lifeBoard`

---

### Step 8: Build and Test

#### Build tvOS app:

1. Top toolbar: Select **lifeBoard** scheme
2. Select **Apple TV 4K** simulator (or tvOS device)
3. **Product → Build** (or press ⌘B)
4. Wait for build to complete
5. Fix any errors (see troubleshooting below)

#### Build iOS app:

1. Top toolbar: Select **LifeBoardiOS** scheme
2. Select **iPhone 16** simulator (or any iOS device)
3. **Product → Build** (or press ⌘B)
4. Wait for build to complete

---

## Troubleshooting

### Issue: "No such module 'LifeBoardCore'"

**Solution:**
1. Click target → **Build Phases**
2. Verify frameworks are in **Link Binary With Libraries**
3. Product → Clean Build Folder (⇧⌘K)
4. Rebuild (⌘B)

### Issue: Files show in red (missing)

**Solution:**
1. Right-click red file → Show in Finder
2. If file is missing, re-add it using "Add Files" (don't copy)
3. Clean and rebuild

### Issue: "Command 'xcodebuild' not found"

**Solution:**
```bash
xcode-select --install
```

### Issue: CloudKit errors at runtime

**Solution:**
1. Verify CloudKit capability is enabled
2. Check container identifier in code matches Xcode
3. Sign in to iCloud in simulator: Settings → iCloud

### Issue: Build succeeds but app won't run

**Solution:**
1. Check Build Schemes (top toolbar)
2. Verify correct target scheme is selected
3. Check simulator is running (or device connected)

---

## Verification Checklist

After setup, verify:

- ☑ All 3 frameworks appear in Project Navigator
- ☑ LifeBoardiOS target appears in Project Navigator
- ☑ tvOS app builds without errors (⌘B)
- ☑ iOS app builds without errors (⌘B)
- ☑ CloudKit capability enabled on both targets
- ☑ App Groups capability enabled on both targets (same group ID)
- ☑ Sign in with Apple enabled on tvOS target only
- ☑ Code identifiers match Xcode capabilities
- ☑ All frameworks linked in Build Phases

---

## Next Steps

Once everything builds:

1. **Test tvOS app**: Run on Apple TV 4K simulator
2. **Test iOS app**: Run on iPhone simulator
3. **Test Sign in**: Tap "Sign in with Apple" button
4. **Test CloudKit**: Verify data syncs between devices
5. **Configure widgets**: Add widgets via iOS app

---

## Files Reference

| Target | Source Folder | Purpose |
|--------|---------------|---------|
| LifeBoardCore | `LifeBoardCore/` | Shared framework (auth, design, user profile) |
| LifeBoardSecurity | `LifeBoardSecurity/` | Keychain management |
| LifeBoardWidgets | `LifeBoardWidgets/` | Widget implementations |
| lifeBoard | `lifeBoard/` | tvOS app (main application) |
| LifeBoardiOS | `LifeBoardiOS/` | iOS companion app |

---

## Support

For issues or questions, check:
- `XCODE_SETUP_STEPS.md` - Detailed reference
- `XCODE_QUICK_REFERENCE.md` - Quick lookup
- `README.md` - Project overview

