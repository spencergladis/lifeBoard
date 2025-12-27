//
//  DesignSystem.swift
//  LifeBoardCore
//
//  Created for lifeBoard
//  Singleton source of truth for all visual constants
//

import SwiftUI

/// Singleton design system providing all visual constants for lifeBoard
/// All UI elements must reference this system - no hardcoded values in views
public final class DesignSystem {
    
    /// Shared singleton instance
    public static let shared = DesignSystem()
    
    private init() {}
    
    // MARK: - Spacing & Layout (8pt Baseline Grid)
    
    /// Spacing constants based on 8pt baseline grid system
    public struct Spacing {
        /// Compact spacing: 8pt
        public static let compact: CGFloat = 8
        
        /// Regular spacing: 16pt
        public static let regular: CGFloat = 16
        
        /// Large spacing: 24pt
        public static let large: CGFloat = 24
        
        /// Section spacing: 40pt
        public static let section: CGFloat = 40
        
        private init() {}
    }
    
    // MARK: - Corner Radii
    
    /// Corner radius constants
    public struct CornerRadius {
        /// Small corner radius: 8pt
        public static let small: CGFloat = 8
        
        /// Card corner radius: 24pt
        public static let card: CGFloat = 24
        
        /// Window corner radius: 40pt
        public static let window: CGFloat = 40
        
        private init() {}
    }
    
    // MARK: - Colors (Semantic - No Hex Codes in Views)
    
    /// Semantic color system - all colors defined here
    /// Views must use these constants, never hex codes directly
    public struct Colors {
        /// Glass palette - white opacity levels
        public static let glass10 = Color.white.opacity(0.1)  // Glass panel backgrounds
        public static let glass20 = Color.white.opacity(0.2)  // Widget card backgrounds, borders
        public static let glass40 = Color.white.opacity(0.4)  // Focus rings, secondary UI
        public static let glass60 = Color.white.opacity(0.6)  // Secondary text
        public static let glass80 = Color.white.opacity(0.8)  // Primary UI elements, status bar
        
        /// Text colors
        public static let textPrimary = Color.white
        public static let textSecondary = Color.white.opacity(0.6)
        public static let textMetadata = Color.white.opacity(0.4)
        
        /// Background
        public static let background = Color.black
        
        private init() {}
    }
    
    // MARK: - Typography (SF Pro with Precise Tracking)
    
    /// Typography system using SF Pro with precise tracking values
    public struct Typography {
        /// Display text: Large, tight tracking (-1.0)
        /// Use for: Main headings, app title
        public static let display: Font = .system(size: 64, weight: .semibold, design: .default)
            .tracking(-1.0)
        
        /// Title text: Semibold, normal tracking
        /// Use for: Section headings, widget titles
        public static let title: Font = .system(size: 40, weight: .semibold, design: .default)
        
        /// Body text: Medium weight, standard tracking
        /// Use for: Primary content, descriptions
        public static let body: Font = .system(size: 20, weight: .medium, design: .default)
        
        /// Secondary text: Medium weight, 60% opacity
        /// Use for: Supporting information
        public static let secondary: Font = .system(size: 16, weight: .medium, design: .default)
        
        /// Caption: Regular weight, uppercase, wide tracking (+1.0), reduced opacity
        /// Use for: Labels, metadata, hints
        public static let caption: Font = .system(size: 14, weight: .regular, design: .default)
            .tracking(1.0)
        
        /// Metadata: Small, regular weight, 40-50% opacity
        /// Use for: Timestamps, small details
        public static let metadata: Font = .system(size: 12, weight: .regular, design: .default)
        
        private init() {}
    }
    
    // MARK: - Aurora Background Gradients
    
    /// Aurora background gradient constants
    /// All gradients defined here for programmatic background
    public struct Aurora {
        /// Primary Aurora: Blue gradient
        public static let primary: LinearGradient = LinearGradient(
            colors: [Color.blue.opacity(0.3)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        /// Secondary Aurora: Purple gradient
        public static let secondary: LinearGradient = LinearGradient(
            colors: [Color.purple.opacity(0.3)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        /// Accent Aurora: Pink gradient
        public static let accent: LinearGradient = LinearGradient(
            colors: [Color.pink.opacity(0.2)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        private init() {}
    }
    
    // MARK: - Shadows
    
    /// Shadow constants for depth and elevation
    public struct Shadows {
        /// Standard shadow: 20px blur, 10px offset
        public static let standard = (radius: CGFloat(20), offset: CGSize(width: 0, height: 10), opacity: 0.5)
        
        /// Bloom shadow (focused): 50px blur, 20px offset
        public static let bloom = (radius: CGFloat(50), offset: CGSize(width: 0, height: 20), opacity: 0.5)
        
        private init() {}
    }
    
    // MARK: - Blur
    
    /// Blur radius constants
    public struct Blur {
        /// Panel blur: 24px (for Liquid Glass panels)
        public static let panel: CGFloat = 24
        
        /// Aurora blur: 100-120px (for background effects)
        public static let aurora: CGFloat = 120
        
        private init() {}
    }
}

