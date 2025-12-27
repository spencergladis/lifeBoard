# Xcode Quick Reference - Next Steps

## ✅ Files Recreated

I've recreated all the missing tvOS app files:
- `lifeBoard/LifeBoardApp.swift` - Main app entry point
- `lifeBoard/Platform/Authentication/SignInView.swift` - Sign in screen
- `lifeBoard/UserProfile/Widgets/DashboardView.swift` - Main dashboard
- `lifeBoard/UserProfile/Widgets/WidgetGrid.swift` - Widget grid layout
- `lifeBoard/UserProfile/Widgets/WidgetView.swift` - Individual widget wrapper
- `lifeBoard/Navigation/NavigationCoordinator.swift` - Navigation manager

## 🎯 Immediate Next Steps in Xcode

### Step 1: Add tvOS App Files to Xcode Project

1. **In Xcode Project Navigator**, find the **lifeBoard** folder (your tvOS app target)
2. **Delete** the default `lifeBoard.swift` file if it exists (right-click → Delete → Move to Trash)
3. **Right-click** on the **lifeBoard** folder
4. Select **"Add Files to 'lifeBoard'..."**
5. Navigate to: `/Users/spencergladis/lifeBoard.main/`
6. Select these folders/files:
   - `lifeBoard/LifeBoardApp.swift`
   - `lifeBoard/Platform/` folder
   - `lifeBoard/UserProfile/` folder
   - `lifeBoard/Navigation/` folder
7. **Important Options:**
   - ❌ **"Copy items if needed"** — **UNCHECK** (files are already in the right place)
   - ✅ **"Create groups"** — **CHECK**
   - ✅ **"Add to targets"** — Select **lifeBoard** only
8. Click **Add**

### Step 2: Create Framework Targets

Follow the detailed steps in `XCODE_SETUP_STEPS.md` to create:
- LifeBoardCore framework
- LifeBoardSecurity framework  
- LifeBoardWidgets framework

### Step 3: Add Framework Files

Add existing code to each framework (see `XCODE_SETUP_STEPS.md` for details):
- LifeBoardCore → Add `LifeBoardCore/` folder
- LifeBoardSecurity → Add `LifeBoardSecurity/` folder
- LifeBoardWidgets → Add `LifeBoardWidgets/` folder

### Step 4: Create iOS Target

Create the iOS companion app target (see `XCODE_SETUP_STEPS.md`)

### Step 5: Configure Dependencies

Add frameworks to app targets:
- lifeBoard (tvOS) → Needs: LifeBoardCore, LifeBoardSecurity, LifeBoardWidgets
- LifeBoardiOS (iOS) → Needs: LifeBoardCore, LifeBoardSecurity, LifeBoardWidgets

### Step 6: Configure Capabilities

Enable capabilities for both app targets:
- **CloudKit** → Container: `iCloud.com.lifeboardapp.lifeBoard`
- **App Groups** → Group: `group.com.lifeboardapp.lifeBoard`
- **Sign in with Apple** → (tvOS only)

### Step 7: Update Code Identifiers

After configuring capabilities, update:
- `CloudKitManager.swift` → Container identifier
- `KeychainManager.swift` → App Group identifier

## 📝 Files Location

All files are in: `/Users/spencergladis/lifeBoard.main/`

```
lifeBoard/                    ← tvOS app files (just recreated)
LifeBoardCore/                ← Framework files
LifeBoardSecurity/             ← Framework files
LifeBoardWidgets/              ← Framework files
LifeBoardiOS/                  ← iOS app files
```

## ⚠️ Important Notes

1. **Don't copy files** - Always uncheck "Copy items if needed" when adding files
2. **Use groups** - Check "Create groups" to maintain folder structure
3. **Target membership** - Make sure files are added to the correct targets
4. **Build errors** - You'll get errors until frameworks are created and dependencies are configured

## 🚀 After Setup

Once everything is added:
1. Build the project (⌘B)
2. Fix any import errors
3. Run on Apple TV simulator
4. Test Sign in with Apple flow

## 📚 Full Instructions

See `XCODE_SETUP_STEPS.md` for complete step-by-step instructions.


