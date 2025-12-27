---
name: Visual Design Brief with Code Patterns
overview: Update the visual design brief to incorporate specific design patterns from the React example code, including Liquid Glass effects, focus states, widget layouts, and animation specifications. Translate React/Tailwind patterns to SwiftUI/tvOS equivalents for the designer.
todos:
  - id: design-brief-update
    content: Update visual design brief document with specific code patterns (Liquid Glass, Focus Ring, Aurora Background, Widget layouts)
    status: pending
  - id: design-system-specs
    content: "Document exact design system specifications: opacity values (10%, 20%, 40%, 60%, 80%), blur radii (24px, 100-120px), corner radius (32px), typography sizes"
    status: pending
    dependencies:
      - design-brief-update
  - id: component-library
    content: "Create design component library: Glass Panel, Focus Ring, Aurora Background, Widget Card Template, Status Bar"
    status: pending
    dependencies:
      - design-system-specs
  - id: widget-designs
    content: Design individual widgets (Weather, Music, Calendar, Home) following exact code patterns and layouts
    status: pending
    dependencies:
      - component-library
  - id: screen-designs
    content: Design all screens (Auth, Dashboard, Service Linking) with consistent application of design patterns
    status: pending
    dependencies:
      - component-library
  - id: animation-specs
    content: "Document animation specifications: timing curves, focus animations, screen transitions, background animations with exact durations and easing"
    status: pending
    dependencies:
      - component-library
  - id: swiftui-translation
    content: Create SwiftUI implementation notes translating React/Tailwind patterns to SwiftUI modifiers and components
    status: pending
    dependencies:
      - design-system-specs
---

# Visual Design Brief Update: Incorporating Code Patterns

## Overview

This plan updates the visual design brief to incorporate specific design patterns demonstrated in the React example code. The patterns will be translated from React/Tailwind CSS to SwiftUI/tvOS equivalents for implementation guidance.

## Key Visual Patterns from Example Code

### 1. Liquid Glass Panel System

**React/Tailwind Pattern:**

```css
bg-white/10 backdrop-blur-xl border border-white/20 shadow-2xl
```

**SwiftUI Equivalent:**

- Background: `.ultraThinMaterial` or `.thinMaterial` with white opacity overlay
- Border: `border(Color.white.opacity(0.2), width: 1)`
- Shadow: `shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 10)`
- Corner radius: `cornerRadius(32)` (rounded-3xl equivalent)

**Design Specification:**

- Glass panels use 10% white opacity background
- Backdrop blur intensity: `xl` (approximately 24px blur radius)
- Border: 1px solid white at 20% opacity
- Shadow: Large shadow with 2xl intensity (approximately 20px blur, 10px offset)
- Rounded corners: 32px radius (squircle-like appearance)

### 2. Focus Ring System

**React/Tailwind Pattern:**

```css
ring-4 ring-white/40 ring-offset-0 transition-all duration-300 transform scale-105 z-10 shadow-[0_20px_50px_rgba(0,0,0,0.5)]
```

**SwiftUI Equivalent:**

- Focus ring: `overlay(RoundedRectangle(cornerRadius: 32).stroke(Color.white.opacity(0.4), lineWidth: 4))`
- Scale: `.scaleEffect(1.05)` when focused
- Shadow: `shadow(color: .black.opacity(0.5), radius: 25, x: 0, y: 20)`
- Animation: `.animation(.easeInOut(duration: 0.3), value: isFocused)`

**Design Specification:**

- Focus ring: 4px solid white at 40% opacity
- Scale transformation: 105% when focused (5% increase)
- Enhanced shadow: 50px blur radius, 20px vertical offset, 50% black opacity
- Transition duration: 300ms with ease-in-out timing
- Z-index elevation when focused

### 3. Dynamic Background (Aurora Effect)

**React/Tailwind Pattern:**

```css
bg-blue-600/30 rounded-full blur-[120px] animate-pulse
bg-purple-600/30 rounded-full blur-[100px] animate-pulse
bg-pink-500/20 rounded-full blur-[100px] animate-pulse
```

**SwiftUI Equivalent:**

- Multiple gradient circles with blur effects
- Animated opacity/position changes
- ZStack layering for depth

**Design Specification:**

- **Primary Aurora**: Blue gradient circle (60% width, 60% height), 30% opacity, 120px blur radius
- **Secondary Aurora**: Purple gradient circle (60% width, 60% height), 30% opacity, 120px blur radius
- **Accent Aurora**: Pink gradient circle (40% width, 40% height), 20% opacity, 100px blur radius
- Animation: Pulsing effect with 8-12 second duration cycles
- Positioning: Offset from center (-10% to +20% from edges)
- Background: Pure black (#111 or #000)

### 4. Widget Card Structure

**React/Tailwind Pattern:**

```css
rounded-[2rem] relative overflow-hidden transition-all duration-300
```

**Design Specification:**

- Corner radius: 32px (2rem)
- Relative positioning for layered effects
- Overflow hidden for clean edges
- Transition: 300ms for all properties
- Glossy sheen overlay on focus (gradient from white/20% to transparent)

### 5. Typography System

**React/Tailwind Patterns:**

- Primary: `text-white font-medium tracking-tight`
- Secondary: `text-white/60 font-medium`
- Headings: `text-4xl font-semibold`, `text-5xl font-semibold`
- Body: `text-xl`, `text-lg`

**Design Specification:**

- **Display Text**: SF Pro Display, semibold, 48-64pt, white, tight tracking
- **Title Text**: SF Pro Text, semibold, 32-40pt, white, normal tracking
- **Body Text**: SF Pro Text, medium, 18-24pt, white, normal tracking
- **Secondary Text**: SF Pro Text, medium, 14-18pt, white at 60% opacity
- **Metadata**: SF Pro Text, regular, 12-14pt, white at 40-50% opacity
- All text uses SF Pro system font family

### 6. Widget-Specific Designs

#### Weather Widget

- **Layout**: Vertical flex, space-between justification
- **Top Section**: Location name (primary text), condition (secondary text), icon (8x8 size)
- **Bottom Section**: Large temperature (72pt, light weight), metadata (wind, humidity) with icons
- **Spacing**: 24px padding (p-6)

#### Music Widget

- **Background**: Gradient overlay (pink-500/20 to purple-900/40)
- **Layout**: Full-height flex with relative positioning
- **Top**: Icon badge (12x12, white/20% bg, rounded-lg), status indicators
- **Middle**: Track title (20pt, semibold), artist/album (secondary text)
- **Bottom**: Progress bar (1px height, white/20% bg, white fill at 1/3), time display
- **Visual**: Album art background blur effect

#### Calendar Widget

- **Layout**: Vertical flex with 24px padding
- **Header**: Icon + "Up Next" label (red-400, uppercase, tracking-wider), date (secondary)
- **Events**: Vertical list with 16px spacing
- **Event Item**: Colored bar (1px width, full height), title (18pt, medium), time (secondary, 14pt)
- **Visual Hierarchy**: Current event at full opacity, upcoming at 50% opacity

#### Home Widget

- **Layout**: Vertical flex, space-between
- **Top**: Title (primary), icon badge (yellow-500/20, rounded-full)
- **Bottom**: 2-column grid (3px gap)
- **Grid Items**: White/5% background, backdrop blur, rounded-lg, 12px padding
- **Content**: Label (uppercase, 12pt, white/50%), value (medium, white)

### 7. Authentication Screen

**Design Specification:**

- **Layout**: Centered vertical flex, 48px spacing between elements
- **Logo**: 96x96px rounded-3xl glass panel with icon (48x48px)
- **Title**: "lifeBoard" (64pt, semibold, white, tight tracking)
- **Subtitle**: "Command Center" (20pt, white at 50% opacity)
- **Button**: Sign in with Apple button
- White background, black text
- 48px horizontal padding, 16px vertical padding
- 12px corner radius
- 20pt semibold text
- Apple logo icon (24x24px)
- Focus: 110% scale, white glow shadow
- **Hint Text**: "Press Enter to connect" (14pt, white/40%, centered)
- **Spacing**: 48px margin-top before button

### 8. Dashboard Layout

**Grid System:**

- **Container**: 3-column grid, 2-row grid
- **Gap**: 32px between widgets (gap-8)
- **Widget Spans**: 
- Small widgets: 1 column span
- Medium widgets: 2 column span
- Large widgets: 3 column span (full width)
- **Padding**: 64px horizontal, 48px bottom, 96px top (for status bar)

**Example Layout:**

```javascript
Row 1: [Weather (1)] [Music (2)]
Row 2: [Calendar (2)] [Home (1)]
```



### 9. Status Bar

**Design Specification:**

- **Position**: Top of screen, 40px padding
- **Layout**: Horizontal flex, space-between
- **Left**: Time display (18pt, semibold, white/80%, drop shadow)
- **Right**: Icon group (20px icons, 16px spacing, 80% opacity, drop shadow)
- **Icons**: WiFi, User (and other system icons)
- **Background**: Transparent (overlay on background)
- **Z-index**: Above content, below modals

### 10. Animation Specifications

**Transitions:**

- **Duration**: 300ms standard, 500-700ms for screen transitions
- **Timing**: `cubic-bezier(0.25, 0.46, 0.45, 0.94)` (ease-in-out-cubic)
- **Properties**: All transform, opacity, scale, shadow properties

**Focus Animations:**

- Scale: 100% → 105% (5% increase)
- Shadow: Standard → Enhanced (50px blur, 20px offset)
- Opacity: Sheen overlay 0% → 100%
- Ring: Appears with 300ms transition

**Screen Transitions:**

- Fade in: `fade-in duration-700`
- Slide in: `slide-in-from-bottom-10`
- Opacity transition: 0.5s for auth → dashboard

**Background Animations:**

- Aurora pulses: 8-12 second cycles
- Continuous subtle movement
- Opacity variations: 20-30% range

## Design Deliverables Update

### Updated Deliverables Checklist

#### Phase 1: Foundation (Updated)

- [ ] Design system documentation with exact opacity values
- [ ] Color palette with opacity specifications (white/10, white/20, white/40, white/60, white/80)
- [ ] Typography system with SF Pro specifications
- [ ] Icon library (Lucide-style icons or SF Symbols equivalents)
- [ ] Logo and branding assets
- [ ] **Liquid Glass style guide** (backdrop blur, opacity, border specifications)
- [ ] **Focus ring specifications** (ring width, opacity, shadow values)

#### Phase 2: Component Library (New)

- [ ] **Glass Panel Component** (exact specifications from code)
- [ ] **Focus Ring Component** (scale, shadow, ring specifications)
- [ ] **Aurora Background Component** (gradient circles, blur, animation)
- [ ] **Widget Card Template** (base structure for all widgets)
- [ ] **Status Bar Component** (time, icons, positioning)

#### Phase 3: Widget Designs (Updated with Code Patterns)

- [ ] **Weather Widget** (exact layout from code)
- [ ] **Music Widget** (gradient background, progress bar, album art)
- [ ] **Calendar Widget** (event list with colored bars)
- [ ] **Home Widget** (2-column grid layout)
- [ ] Additional widget templates following same pattern

#### Phase 4: Screen Designs (Updated)

- [ ] **Auth Screen** (centered layout, button specifications)
- [ ] **Dashboard Screen** (3-column grid, spacing, greeting)
- [ ] **Widget Expansion Views** (full-screen or split-view)
- [ ] **Service Linking Screen** (list with checkboxes)

#### Phase 5: Animation Specifications (New)

- [ ] **Transition Timing Curves** (cubic-bezier values)
- [ ] **Focus Animation Specs** (scale, shadow, duration)
- [ ] **Screen Transition Specs** (fade, slide, duration)
- [ ] **Background Animation Specs** (aurora pulse cycles)

## SwiftUI Implementation Notes for Designer

### Material System

- Use `.ultraThinMaterial`, `.thinMaterial`, `.regularMaterial` for glass effects
- Combine with `Color.white.opacity(0.1)` overlay for exact match
- Apply `blur(radius: 24)` for backdrop blur

### Focus Engine Integration

- Use `@FocusState` for focus management
- Apply `.focusable()` modifier
- Use `.focusEffect()` for custom focus visuals
- Scale and shadow changes on focus state

### Layout System

- Use `LazyVGrid` with 3-column flexible grid
- Widget spans controlled by `gridItem` column span
- 32px gap between items
- Padding: 64px horizontal, 48px bottom

### Animation System

- Use `.animation(.easeInOut(duration: 0.3), value: focusState)`
- Custom timing curve: `Animation.timingCurve(0.25, 0.46, 0.45, 0.94, duration: 0.3)`
- Background animations: `TimelineView` with periodic updates

## Design File Structure

### Recommended Organization

```javascript
Design Files/
├── 01_Foundation/
│   ├── Color_System.fig (with opacity variants)
│   ├── Typography_System.fig
│   ├── Liquid_Glass_Specs.fig
│   └── Focus_Ring_Specs.fig
├── 02_Components/
│   ├── Glass_Panel.fig
│   ├── Focus_Ring.fig
│   ├── Aurora_Background.fig
│   ├── Status_Bar.fig
│   └── Widget_Card_Base.fig
├── 03_Widgets/
│   ├── Weather_Widget.fig
│   ├── Music_Widget.fig
│   ├── Calendar_Widget.fig
│   └── Home_Widget.fig
├── 04_Screens/
│   ├── Auth_Screen.fig
│   ├── Dashboard_Screen.fig
│   └── Service_Linking.fig
└── 05_Animations/
    ├── Focus_States.fig
    ├── Transitions.fig
    └── Background_Animations.fig
```



## Design Review Criteria

### Visual Fidelity

- [ ] Exact opacity values match specifications (10%, 20%, 40%, 60%, 80%)
- [ ] Blur radius matches (24px for panels, 100-120px for aurora)
- [ ] Corner radius consistent (32px for all cards)
- [ ] Typography sizes match (48-64pt display, 18-24pt body)

### Interaction Fidelity

- [ ] Focus ring appears with 300ms transition
- [ ] Scale effect is exactly 105% (5% increase)
- [ ] Shadow enhancement matches (50px blur, 20px offset)
- [ ] Aurora animations cycle at 8-12 seconds

### System Integration

- [ ] Follows tvOS Human Interface Guidelines
- [ ] Uses SF Pro font family throughout
- [ ] Respects safe areas and focus zones
- [ ] Accessibility compliant (Dynamic Type, VoiceOver)

## Next Steps

1. **Designer Review**: Review this updated brief with specific code patterns
2. **Design System Creation**: Create Figma/Sketch design system with exact specifications
3. **Component Library**: Build reusable components matching code patterns
4. **Widget Designs**: Create individual widget designs following established patterns
5. **Screen Designs**: Design all screens with consistent application of patterns
6. **Animation Specs**: Document all animations with timing and easing