//
//  AuroraBackground.swift
//  LifeBoardCore
//
//  Programmatic animated background using SwiftUI Shapes
//  Creates Aurora effect with gradient circles and pulsing animation
//

import SwiftUI

/// Programmatic animated background creating Aurora effect
/// Uses SwiftUI Shapes (Circle) - no static assets
/// Usage: `AuroraBackground().ignoresSafeArea()`
public struct AuroraBackground: View {
    
    @State private var pulsePhase: Double = 0
    
    /// Animation cycle duration in seconds (8-12 seconds)
    let cycleDuration: Double = 10
    
    public init() {}
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                DesignSystem.Colors.background
                
                // Primary Aurora (Blue)
                Circle()
                    .fill(DesignSystem.Aurora.primary)
                    .frame(
                        width: geometry.size.width * 0.6,
                        height: geometry.size.height * 0.6
                    )
                    .blur(radius: DesignSystem.Blur.aurora)
                    .offset(
                        x: -geometry.size.width * 0.1,
                        y: -geometry.size.height * 0.1
                    )
                    .opacity(0.3 + 0.1 * sin(pulsePhase))
                
                // Secondary Aurora (Purple)
                Circle()
                    .fill(DesignSystem.Aurora.secondary)
                    .frame(
                        width: geometry.size.width * 0.6,
                        height: geometry.size.height * 0.6
                    )
                    .blur(radius: DesignSystem.Blur.aurora)
                    .offset(
                        x: geometry.size.width * 0.1,
                        y: geometry.size.height * 0.1
                    )
                    .opacity(0.3 + 0.1 * sin(pulsePhase + .pi / 3))
                
                // Accent Aurora (Pink)
                Circle()
                    .fill(DesignSystem.Aurora.accent)
                    .frame(
                        width: geometry.size.width * 0.4,
                        height: geometry.size.height * 0.4
                    )
                    .blur(radius: DesignSystem.Blur.aurora * 0.83) // ~100px
                    .offset(
                        x: geometry.size.width * 0.2,
                        y: geometry.size.height * 0.2
                    )
                    .opacity(0.2 + 0.1 * sin(pulsePhase + 2 * .pi / 3))
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    // MARK: - Private Helpers
    
    private func startAnimation() {
        withAnimation(
            .linear(duration: cycleDuration)
            .repeatForever(autoreverses: false)
        ) {
            pulsePhase = 2 * .pi
        }
    }
}

// MARK: - Preview

#if DEBUG
struct AuroraBackground_Previews: PreviewProvider {
    static var previews: some View {
        AuroraBackground()
            .ignoresSafeArea()
    }
}
#endif

