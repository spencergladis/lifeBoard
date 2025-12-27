# Xcode Setup Steps - lifeBoard Project

## Current Status
✅ Xcode project created at: `lifeBoard/lifeBoard.xcodeproj/`
✅ Existing code in root directory ready to add

## Step-by-Step Setup

### Step 1: Create Framework Targets

#### A. Create LifeBoardCore Framework
1. In Xcode, click the **+** button at the top of the Project Navigator (or File → New → Target)
2. Select **Framework** (not Static Library or Metal Library)
3. Product Name: `LifeBoardCore`
4. Organization Identifier: `com.lifeboardapp`
5. Language: Swift
6. Click **Finish**

#### B. Create LifeBoardSecurity Framework
1. Repeat above steps
2. Product Name: `LifeBoardSecurity`
3. Organization Identifier: `com.lifeboardapp`
4. Language: Swift
5. Click **Finish**

#### C. Create LifeBoardWidgets Framework
1. Repeat above steps
2. Product Name: `LifeBoardWidgets`
3. Organization Identifier: `com.lifeboardapp`
4. Language: Swift
5. Click **Finish**

### Step 2: Create iOS Target

1. Click **+** button (or File → New → Target)
2. Select **iOS** → **App**
3. Product Name: `LifeBoardiOS`
4. Organization Identifier: `com.lifeboardapp`
5. Interface: SwiftUI
6. Language: Swift
7. **Uncheck** "Include Tests" (for now)
8. Click **Finish**

### Step 3: Add Existing Files to Targets

#### A. Add LifeBoardCore Framework Files

1. In Project Navigator, right-click on **LifeBoardCore** target (or the LifeBoardCore folder)
2. Select **"Add Files to 'lifeBoard'..."**
3. Navigate to `/Users/spencergladis/lifeBoard.main/`
4. Select these folders:
   - `LifeBoardCore/Platform/`
   - `LifeBoardCore/UserProfile/`
   - `LifeBoardCore/CloudKit/`
5. **Important Options:**
   - ✅ **"Copy items if needed"** — **UNCHECK** (files are already in the right place)
   - ✅ **"Create groups"** — **CHECK**
   - ✅ **"Add to targets"** — Select **LifeBoardCore** only
6. Click **Add**

#### B. Add LifeBoardSecurity Framework Files

1. Right-click **LifeBoardSecurity** target
2. Select **"Add Files to 'lifeBoard'..."**
3. Navigate to `/Users/spencergladis/lifeBoard.main/`
4. Select: `LifeBoardSecurity/KeychainManager.swift`
5. **Options:**
   - ❌ **"Copy items if needed"** — **UNCHECK**
   - ✅ **"Create groups"** — **CHECK**
   - ✅ **"Add to targets"** — Select **LifeBoardSecurity** only
6. Click **Add**

#### C. Add LifeBoardWidgets Framework Files

1. Right-click **LifeBoardWidgets** target
2. Select **"Add Files to 'lifeBoard'..."**
3. Navigate to `/Users/spencergladis/lifeBoard.main/`
4. Select these folders:
   - `LifeBoardWidgets/Calendar/`
   - `LifeBoardWidgets/Weather/`
   - `LifeBoardWidgets/Music/`
   - `LifeBoardWidgets/Home/`
5. **Options:**
   - ❌ **"Copy items if needed"** — **UNCHECK**
   - ✅ **"Create groups"** — **CHECK**
   - ✅ **"Add to targets"** — Select **LifeBoardWidgets** only
6. Click **Add**

#### D. Add tvOS App Files (lifeBoard target)

1. In Project Navigator, find the **lifeBoard** folder (tvOS app)
2. Delete the default `lifeBoard.swift` file (if it exists)
3. Right-click the **lifeBoard** folder
4. Select **"Add Files to 'lifeBoard'..."**
5. Navigate to `/Users/spencergladis/lifeBoard.main/`
6. **We need to recreate these files** (they were in the old LifeBoard/ directory):
   - Create `LifeBoard/LifeBoardApp.swift` (main app file)
   - Create `LifeBoard/Platform/Authentication/SignInView.swift`
   - Create `LifeBoard/UserProfile/Widgets/DashboardView.swift`
   - Create `LifeBoard/UserProfile/Widgets/WidgetGrid.swift`
   - Create `LifeBoard/UserProfile/Widgets/WidgetView.swift`
   - Create `LifeBoard/Navigation/NavigationCoordinator.swift`

**Note:** These files need to be recreated. I'll help you with this in the next step.

#### E. Add iOS App Files (LifeBoardiOS target)

1. Right-click **LifeBoardiOS** target
2. Select **"Add Files to 'lifeBoard'..."**
3. Navigate to `/Users/spencergladis/lifeBoard.main/`
4. Select:
   - `LifeBoardiOS/LifeBoardiOSApp.swift` (replace default)
   - `LifeBoardiOS/Configuration/` folder
   - `LifeBoardiOS/UserProfile/` folder
5. **Options:**
   - ❌ **"Copy items if needed"** — **UNCHECK**
   - ✅ **"Create groups"** — **CHECK**
   - ✅ **"Add to targets"** — Select **LifeBoardiOS** only
6. Click **Add**

### Step 4: Configure Target Dependencies

#### For lifeBoard (tvOS) Target:

1. Select **lifeBoard** target in Project Navigator
2. Go to **Build Phases** tab
3. Expand **"Dependencies"** section
4. Click **+** button
5. Add:
   - `LifeBoardCore`
   - `LifeBoardSecurity`
   - `LifeBoardWidgets`
6. Expand **"Link Binary With Libraries"** section
7. Click **+** button
8. Add the same frameworks:
   - `LifeBoardCore.framework`
   - `LifeBoardSecurity.framework`
   - `LifeBoardWidgets.framework`

#### For LifeBoardiOS (iOS) Target:

1. Select **LifeBoardiOS** target
2. Go to **Build Phases** tab
3. Repeat steps 3-8 above (same frameworks)

#### For LifeBoardCore Framework:

1. Select **LifeBoardCore** target
2. Go to **Build Phases** tab
3. Add **LifeBoardSecurity** to dependencies (if LifeBoardCore uses KeychainManager)

### Step 5: Configure Capabilities

#### CloudKit (Both lifeBoard and LifeBoardiOS targets)

1. Select **lifeBoard** target → **Signing & Capabilities** tab
2. Click **"+ Capability"**
3. Search for and add **"CloudKit"**
4. Container will be created automatically: `iCloud.com.lifeboardapp.lifeBoard`
5. **Note the container identifier** - you'll need to update `CloudKitManager.swift`
6. Repeat for **LifeBoardiOS** target (same container)

#### App Groups (Both targets)

1. Select **lifeBoard** target → **Signing & Capabilities** tab
2. Click **"+ Capability"**
3. Search for and add **"App Groups"**
4. Click **"+** next to App Groups
5. Enter: `group.com.lifeboardapp.lifeBoard`
6. Click **OK**
7. Repeat for **LifeBoardiOS** target (same group)

#### Sign in with Apple (lifeBoard tvOS target only)

1. Select **lifeBoard** target → **Signing & Capabilities** tab
2. Click **"+ Capability"**
3. Search for and add **"Sign in with Apple"**
4. No additional configuration needed

### Step 6: Update Code Files

After capabilities are configured, update these files with the correct identifiers:

#### CloudKitManager.swift
```swift
// Update this line:
container = CKContainer(identifier: "iCloud.com.lifeboardapp.lifeBoard")
```

#### KeychainManager.swift
```swift
// Update this line:
private let accessGroup: String? = "group.com.lifeboardapp.lifeBoard"
```

### Step 7: Build and Test

1. Select **lifeBoard** scheme (tvOS)
2. Select **Apple TV 4K** simulator
3. Press **⌘B** to build
4. Fix any compilation errors
5. Repeat for **LifeBoardiOS** scheme (iOS)

## Troubleshooting

### Files show in red (missing)
- Right-click → "Show in Finder" to verify location
- Re-add files if needed

### Build errors about missing modules
- Check that frameworks are added to "Dependencies" and "Link Binary With Libraries"
- Clean build folder: Product → Clean Build Folder (⇧⌘K)

### CloudKit errors
- Verify CloudKit capability is enabled
- Check container identifier matches in code

### App Groups errors
- Verify App Groups capability is enabled for both targets
- Check group identifier matches in code


