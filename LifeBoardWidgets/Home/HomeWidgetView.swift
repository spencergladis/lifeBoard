//
//  HomeWidgetView.swift
//  LifeBoardWidgets
//
//  Home widget SwiftUI view
//  Displays home status with programmatic design
//

import SwiftUI

/// Home widget view
/// Displays home automation status with programmatic design
public struct HomeWidgetView: View {
    
    // Mock data for prototype
    private let livingRoomStatus = "On"
    private let livingRoomBrightness = 80
    private let temperature = 70
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top section
            HStack {
                Text("Home")
                    .font(DesignSystem.Typography.body)
                    .foregroundColor(DesignSystem.Colors.textPrimary)
                
                Spacer()
                
                // Icon badge
                Circle()
                    .fill(Color.yellow.opacity(0.2))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "house.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.yellow.opacity(0.8))
                    )
            }
            
            Spacer()
            
            // Bottom section - 2-column grid
            HStack(spacing: DesignSystem.Spacing.compact) {
                // Living Room
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.compact / 2) {
                    Text("LIVING ROOM")
                        .font(DesignSystem.Typography.metadata)
                        .foregroundColor(DesignSystem.Colors.textMetadata)
                        .tracking(1.0)
                    
                    Text("\(livingRoomStatus) • \(livingRoomBrightness)%")
                        .font(DesignSystem.Typography.body)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(DesignSystem.Spacing.regular)
                .background(DesignSystem.Colors.glass10)
                .cornerRadius(DesignSystem.CornerRadius.small)
                
                // Temperature
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.compact / 2) {
                    Text("TEMP")
                        .font(DesignSystem.Typography.metadata)
                        .foregroundColor(DesignSystem.Colors.textMetadata)
                        .tracking(1.0)
                    
                    Text("\(temperature)° F")
                        .font(DesignSystem.Typography.body)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(DesignSystem.Spacing.regular)
                .background(DesignSystem.Colors.glass10)
                .cornerRadius(DesignSystem.CornerRadius.small)
            }
        }
        .padding(DesignSystem.Spacing.large)
    }
}

