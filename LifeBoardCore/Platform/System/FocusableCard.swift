//
//  FocusableCard.swift
//  LifeBoardCore
//
//  tvOS focus wrapper view that handles focus state automatically
//  Provides "Bloom" effect and spring animations on focus
//

import SwiftUI

/// Wrapper view that automatically handles tvOS focus state
/// Provides scale, shadow, and border animations on focus
/// Usage: `FocusableCard { content }`
public struct FocusableCard<Content: View>: View {
    
    @FocusState private var isFocused: Bool
    
    let content: Content
    
    /// Initializer
    /// - Parameter content: View content to wrap
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .focusable()
            .focused($isFocused)
            .scaleEffect(isFocused ? 1.1 : 1.0)
            .shadow(
                color: .black.opacity(isFocused ? DesignSystem.Shadows.bloom.opacity : DesignSystem.Shadows.standard.opacity),
                radius: isFocused ? DesignSystem.Shadows.bloom.radius : DesignSystem.Shadows.standard.radius,
                x: isFocused ? DesignSystem.Shadows.bloom.offset.width : DesignSystem.Shadows.standard.offset.width,
                y: isFocused ? DesignSystem.Shadows.bloom.offset.height : DesignSystem.Shadows.standard.offset.height
            )
            .overlay(focusRing)
            .overlay(glossySheen)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isFocused)
    }
    
    // MARK: - Private Helpers
    
    @ViewBuilder
    private var focusRing: some View {
        if isFocused {
            RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.card)
                .stroke(DesignSystem.Colors.glass40, lineWidth: 4)
        }
    }
    
    @ViewBuilder
    private var glossySheen: some View {
        if isFocused {
            LinearGradient(
                colors: [
                    DesignSystem.Colors.glass20,
                    Color.clear
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.card))
        }
    }
}

