//
//  ThemeManager.swift
//  LifeBoardCore
//
//  Theme management singleton
//  Applies theme using DesignSystem constants
//

import SwiftUI
import Combine

/// Manages theme application throughout the app
/// Uses DesignSystem constants as default theme
@MainActor
public final class ThemeManager: ObservableObject {
    
    /// Shared singleton instance
    public static let shared = ThemeManager()
    
    /// Current theme (uses DesignSystem defaults)
    @Published public var currentTheme: Theme
    
    private init() {
        // Initialize with default theme from DesignSystem
        self.currentTheme = Theme.default
    }
    
    /// Applies theme updates
    /// - Parameter theme: New theme to apply
    public func apply(_ theme: Theme) {
        currentTheme = theme
    }
}

/// Theme model using DesignSystem constants
public struct Theme {
    /// Default theme using DesignSystem
    public static let `default` = Theme()
    
    /// Spacing system
    public let spacing: DesignSystem.Spacing.Type
    
    /// Corner radii
    public let cornerRadius: DesignSystem.CornerRadius.Type
    
    /// Colors
    public let colors: DesignSystem.Colors.Type
    
    /// Typography
    public let typography: DesignSystem.Typography.Type
    
    private init() {
        self.spacing = DesignSystem.Spacing.self
        self.cornerRadius = DesignSystem.CornerRadius.self
        self.colors = DesignSystem.Colors.self
        self.typography = DesignSystem.Typography.self
    }
}

