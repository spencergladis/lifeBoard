//
//  WeatherWidgetView.swift
//  LifeBoardWidgets
//
//  Weather widget SwiftUI view
//  Displays weather information with programmatic design
//

import SwiftUI

/// Weather widget view
/// Displays current weather with programmatic design
public struct WeatherWidgetView: View {
    
    // Mock data for prototype
    private let location = "Cupertino"
    private let condition = "Mostly Clear"
    private let temperature = 72
    private let windSpeed = 4
    private let humidity = 12
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Top section
            HStack {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.compact / 2) {
                    Text(location)
                        .font(DesignSystem.Typography.body)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                    
                    Text(condition)
                        .font(DesignSystem.Typography.secondary)
                        .foregroundColor(DesignSystem.Colors.textSecondary)
                }
                
                Spacer()
                
                Image(systemName: "cloud")
                    .font(.system(size: 32))
                    .foregroundColor(DesignSystem.Colors.textPrimary)
            }
            
            Spacer()
            
            // Bottom section
            HStack(alignment: .bottom) {
                Text("\(temperature)°")
                    .font(.system(size: 72, weight: .light, design: .default))
                    .foregroundColor(DesignSystem.Colors.textPrimary)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: DesignSystem.Spacing.compact / 2) {
                    HStack(spacing: DesignSystem.Spacing.compact) {
                        Image(systemName: "wind")
                            .font(.system(size: 14))
                            .foregroundColor(DesignSystem.Colors.textMetadata)
                        Text("\(windSpeed)mph")
                            .font(DesignSystem.Typography.metadata)
                            .foregroundColor(DesignSystem.Colors.textMetadata)
                    }
                    
                    HStack(spacing: DesignSystem.Spacing.compact) {
                        Image(systemName: "drop")
                            .font(.system(size: 14))
                            .foregroundColor(DesignSystem.Colors.textMetadata)
                        Text("\(humidity)%")
                            .font(DesignSystem.Typography.metadata)
                            .foregroundColor(DesignSystem.Colors.textMetadata)
                    }
                }
            }
        }
        .padding(DesignSystem.Spacing.large)
    }
}

