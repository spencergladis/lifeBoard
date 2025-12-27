//
//  LiquidGlassModifier.swift
//  LifeBoardCore
//
//  Custom ViewModifier for Liquid Glass aesthetic
//  Programmatic glass effect using SwiftUI materials
//

import SwiftUI

/// Custom ViewModifier that applies Liquid Glass aesthetic to any view
/// Usage: `.liquidGlass()`
public struct LiquidGlassModifier: ViewModifier {
    
    /// Material type for glass effect
    public enum MaterialType {
        case ultraThin
        case thin
        case regular
    }
    
    /// Material type to use
    let materialType: MaterialType
    
    /// White overlay opacity (5-10% for reflection effect)
    let overlayOpacity: Double
    
    /// Border opacity (20-30% for edge definition)
    let borderOpacity: Double
    
    /// Initializer with customizable parameters
    public init(
        materialType: MaterialType = .ultraThin,
        overlayOpacity: Double = 0.08,
        borderOpacity: Double = 0.25
    ) {
        self.materialType = materialType
        self.overlayOpacity = overlayOpacity
        self.borderOpacity = borderOpacity
    }
    
    public func body(content: Content) -> some View {
        content
            .background(material)
            .overlay(overlay)
            .overlay(border)
            .shadow(
                color: .black.opacity(DesignSystem.Shadows.standard.opacity),
                radius: DesignSystem.Shadows.standard.radius,
                x: DesignSystem.Shadows.standard.offset.width,
                y: DesignSystem.Shadows.standard.offset.height
            )
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.card))
    }
    
    // MARK: - Private Helpers
    
    @ViewBuilder
    private var material: some View {
        switch materialType {
        case .ultraThin:
            Material.ultraThinMaterial
        case .thin:
            Material.thinMaterial
        case .regular:
            Material.regularMaterial
        }
    }
    
    private var overlay: some View {
        Color.white.opacity(overlayOpacity)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.card))
    }
    
    private var border: some View {
        RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.card)
            .stroke(Color.white.opacity(borderOpacity), lineWidth: 1)
    }
}

// MARK: - View Extension

public extension View {
    /// Applies Liquid Glass aesthetic to the view
    /// - Parameters:
    ///   - materialType: Material type (default: .ultraThin)
    ///   - overlayOpacity: White overlay opacity (default: 0.08)
    ///   - borderOpacity: Border opacity (default: 0.25)
    /// - Returns: Modified view with Liquid Glass effect
    func liquidGlass(
        materialType: LiquidGlassModifier.MaterialType = .ultraThin,
        overlayOpacity: Double = 0.08,
        borderOpacity: Double = 0.25
    ) -> some View {
        modifier(LiquidGlassModifier(
            materialType: materialType,
            overlayOpacity: overlayOpacity,
            borderOpacity: borderOpacity
        ))
    }
}

