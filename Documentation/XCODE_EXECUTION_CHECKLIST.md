# Xcode Setup - Execution Checklist

## ✅ Pre-Flight Check Complete

All files are verified and ready:
- ✅ All tvOS app files present
- ✅ All iOS app files present  
- ✅ All framework files present
- ✅ CloudKit identifier configured: `iCloud.com.lifeboardapp.lifeBoard`
- ✅ App Group identifier configured: `group.com.lifeboardapp.lifeBoard`

## 🎯 Execution Steps (Follow in Order)

### Phase 1: Add tvOS App Files (5 minutes)

- [ ] **Step 1.1**: In Xcode, open Project Navigator (⌘1)
- [ ] **Step 1.2**: Find and expand the **lifeBoard** folder (tvOS app target)
- [ ] **Step 1.3**: Delete default `lifeBoard.swift` file if it exists
  - Right-click → Delete → Move to Trash
- [ ] **Step 1.4**: Right-click on **lifeBoard** folder (the blue project icon)
- [ ] **Step 1.5**: Select **"Add Files to 'lifeBoard'..."**
- [ ] **Step 1.6**: Navigate to: `/Users/spencergladis/lifeBoard.main/`
- [ ] **Step 1.7**: Select these items:
  - `lifeBoard/LifeBoardApp.swift`
  - `lifeBoard/Platform/` folder
  - `lifeBoard/UserProfile/` folder
  - `lifeBoard/Navigation/` folder
- [ ] **Step 1.8**: In the dialog, set options:
  - ❌ **Uncheck** "Copy items if needed"
  - ✅ **Check** "Create groups"
  - ✅ **Check** "Add to targets: lifeBoard"
- [ ] **Step 1.9**: Click **Add**
- [ ] **Step 1.10**: Verify files appear in Project Navigator (they may show errors - that's OK for now)

### Phase 2: Create Framework Targets (10 minutes)

#### LifeBoardCore Framework

- [ ] **Step 2.1**: Click **+** button at top of Project Navigator (or File → New → Target)
- [ ] **Step 2.2**: Select **Framework & Library** → **Framework**
- [ ] **Step 2.3**: Click **Next**
- [ ] **Step 2.4**: Enter:
  - Product Name: `LifeBoardCore`
  - Organization Identifier: `com.lifeboardapp`
  - Language: **Swift**
- [ ] **Step 2.5**: Click **Finish**
- [ ] **Step 2.6**: If asked to activate scheme, click **Activate**

#### LifeBoardSecurity Framework

- [ ] **Step 2.7**: Repeat Steps 2.1-2.6 with:
  - Product Name: `LifeBoardSecurity`
  - Organization Identifier: `com.lifeboardapp`
  - Language: **Swift**

#### LifeBoardWidgets Framework

- [ ] **Step 2.8**: Repeat Steps 2.1-2.6 with:
  - Product Name: `LifeBoardWidgets`
  - Organization Identifier: `com.lifeboardapp`
  - Language: **Swift**

### Phase 3: Add Framework Files (10 minutes)

#### Add LifeBoardCore Files

- [ ] **Step 3.1**: In Project Navigator, find **LifeBoardCore** folder
- [ ] **Step 3.2**: Right-click **LifeBoardCore** → **"Add Files to 'lifeBoard'..."**
- [ ] **Step 3.3**: Navigate to `/Users/spencergladis/lifeBoard.main/`
- [ ] **Step 3.4**: Select **`LifeBoardCore/`** folder
- [ ] **Step 3.5**: Options:
  - ❌ **Uncheck** "Copy items if needed"
  - ✅ **Check** "Create groups"
  - ✅ **Check** "Add to targets: LifeBoardCore"
- [ ] **Step 3.6**: Click **Add**

#### Add LifeBoardSecurity Files

- [ ] **Step 3.7**: Right-click **LifeBoardSecurity** → **"Add Files to 'lifeBoard'..."**
- [ ] **Step 3.8**: Select **`LifeBoardSecurity/`** folder
- [ ] **Step 3.9**: Options:
  - ❌ **Uncheck** "Copy items if needed"
  - ✅ **Check** "Create groups"
  - ✅ **Check** "Add to targets: LifeBoardSecurity"
- [ ] **Step 3.10**: Click **Add**

#### Add LifeBoardWidgets Files

- [ ] **Step 3.11**: Right-click **LifeBoardWidgets** → **"Add Files to 'lifeBoard'..."**
- [ ] **Step 3.12**: Select **`LifeBoardWidgets/`** folder
- [ ] **Step 3.13**: Options:
  - ❌ **Uncheck** "Copy items if needed"
  - ✅ **Check** "Create groups"
  - ✅ **Check** "Add to targets: LifeBoardWidgets"
- [ ] **Step 3.14**: Click **Add**

### Phase 4: Create iOS Target (5 minutes)

- [ ] **Step 4.1**: Click **+** button (or File → New → Target)
- [ ] **Step 4.2**: Select **iOS** → **App**
- [ ] **Step 4.3**: Click **Next**
- [ ] **Step 4.4**: Enter:
  - Product Name: `LifeBoardiOS`
  - Organization Identifier: `com.lifeboardapp`
  - Interface: **SwiftUI**
  - Language: **Swift**
  - ❌ **Uncheck** "Include Tests"
- [ ] **Step 4.5**: Click **Finish**
- [ ] **Step 4.6**: If asked to activate scheme, click **Activate**

#### Add iOS Files

- [ ] **Step 4.7**: Right-click **LifeBoardiOS** → **"Add Files to 'lifeBoard'..."**
- [ ] **Step 4.8**: Select **`LifeBoardiOS/`** folder
- [ ] **Step 4.9**: Options:
  - ❌ **Uncheck** "Copy items if needed"
  - ✅ **Check** "Create groups"
  - ✅ **Check** "Add to targets: LifeBoardiOS"
- [ ] **Step 4.10**: Click **Add**

### Phase 5: Configure Dependencies (10 minutes)

#### For lifeBoard (tvOS) Target

- [ ] **Step 5.1**: Select **lifeBoard** target in Project Navigator
- [ ] **Step 5.2**: Go to **Build Phases** tab
- [ ] **Step 5.3**: Expand **"Dependencies"** section
- [ ] **Step 5.4**: Click **+** button
- [ ] **Step 5.5**: Add these frameworks (one at a time):
  - `LifeBoardCore`
  - `LifeBoardSecurity`
  - `LifeBoardWidgets`
- [ ] **Step 5.6**: Expand **"Link Binary With Libraries"** section
- [ ] **Step 5.7**: Click **+** button
- [ ] **Step 5.8**: Add the same three frameworks:
  - `LifeBoardCore.framework`
  - `LifeBoardSecurity.framework`
  - `LifeBoardWidgets.framework`

#### For LifeBoardiOS (iOS) Target

- [ ] **Step 5.9**: Select **LifeBoardiOS** target
- [ ] **Step 5.10**: Go to **Build Phases** tab
- [ ] **Step 5.11**: Repeat Steps 5.3-5.8 (add same frameworks)

#### For LifeBoardCore Framework (if needed)

- [ ] **Step 5.12**: Select **LifeBoardCore** target
- [ ] **Step 5.13**: Go to **Build Phases** → **Dependencies**
- [ ] **Step 5.14**: Add **LifeBoardSecurity** (if LifeBoardCore uses KeychainManager)

### Phase 6: Configure Capabilities (10 minutes)

#### CloudKit (Both Targets)

**For lifeBoard (tvOS):**

- [ ] **Step 6.1**: Select **lifeBoard** target
- [ ] **Step 6.2**: Go to **Signing & Capabilities** tab
- [ ] **Step 6.3**: Click **"+ Capability"** button (top left)
- [ ] **Step 6.4**: Search for and double-click **"CloudKit"**
- [ ] **Step 6.5**: Note the container identifier (should be `iCloud.com.lifeboardapp.lifeBoard`)
- [ ] **Step 6.6**: If different, update `CloudKitManager.swift` with the actual identifier

**For LifeBoardiOS (iOS):**

- [ ] **Step 6.7**: Select **LifeBoardiOS** target
- [ ] **Step 6.8**: Repeat Steps 6.2-6.6

#### App Groups (Both Targets)

**For lifeBoard (tvOS):**

- [ ] **Step 6.9**: Select **lifeBoard** target → **Signing & Capabilities**
- [ ] **Step 6.10**: Click **"+ Capability"**
- [ ] **Step 6.11**: Search for and double-click **"App Groups"**
- [ ] **Step 6.12**: Click **+** button next to App Groups
- [ ] **Step 6.13**: Enter: `group.com.lifeboardapp.lifeBoard`
- [ ] **Step 6.14**: Click **OK**

**For LifeBoardiOS (iOS):**

- [ ] **Step 6.15**: Select **LifeBoardiOS** target
- [ ] **Step 6.16**: Repeat Steps 6.10-6.14 (use same group identifier)

#### Sign in with Apple (tvOS Only)

- [ ] **Step 6.17**: Select **lifeBoard** target → **Signing & Capabilities**
- [ ] **Step 6.18**: Click **"+ Capability"**
- [ ] **Step 6.19**: Search for and double-click **"Sign in with Apple"**
- [ ] **Step 6.20**: No additional configuration needed

### Phase 7: Build and Test (10 minutes)

- [ ] **Step 7.1**: Select **lifeBoard** scheme (top toolbar)
- [ ] **Step 7.2**: Select **Apple TV 4K** simulator (or any tvOS simulator)
- [ ] **Step 7.3**: Press **⌘B** to build
- [ ] **Step 7.4**: Fix any compilation errors (common issues below)
- [ ] **Step 7.5**: Once build succeeds, press **⌘R** to run
- [ ] **Step 7.6**: Test Sign in with Apple flow
- [ ] **Step 7.7**: Repeat for **LifeBoardiOS** scheme (iOS simulator)

## 🔧 Common Issues & Fixes

### Issue: "No such module 'LifeBoardCore'"
**Fix**: 
1. Check that LifeBoardCore is in Dependencies
2. Check that LifeBoardCore is in Link Binary With Libraries
3. Clean build folder: Product → Clean Build Folder (⇧⌘K)
4. Rebuild

### Issue: Files show in red (missing)
**Fix**:
1. Right-click file → "Show in Finder"
2. Verify file exists
3. If missing, re-add using "Add Files" (don't copy)

### Issue: CloudKit errors
**Fix**:
1. Verify CloudKit capability is enabled
2. Check container identifier matches in `CloudKitManager.swift`
3. Ensure you're signed in to iCloud on simulator

### Issue: App Groups errors
**Fix**:
1. Verify App Groups capability enabled for both targets
2. Check group identifier matches in `KeychainManager.swift`
3. Ensure same group ID for both targets

### Issue: Sign in with Apple not working
**Fix**:
1. Verify capability enabled for tvOS target
2. Check bundle identifier is correct
3. Test on real device (simulator has limitations)

## ✅ Completion Checklist

- [ ] All files added to correct targets
- [ ] All frameworks created and linked
- [ ] iOS target created and configured
- [ ] All capabilities enabled
- [ ] Project builds without errors
- [ ] tvOS app runs on simulator
- [ ] iOS app runs on simulator
- [ ] Sign in with Apple works (or shows UI)

## 🎉 Success!

Once all checkboxes are complete, your lifeBoard project is fully set up and ready for development!

## 📚 Reference Documents

- **Detailed Instructions**: `XCODE_SETUP_STEPS.md`
- **Quick Reference**: `XCODE_QUICK_REFERENCE.md`
- **Project Overview**: `README.md`


