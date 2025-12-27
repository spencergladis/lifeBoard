//
//  DashboardView.swift
//  lifeBoard
//
//  Main dashboard view for tvOS
//  Displays widgets in a grid layout
//

import SwiftUI

/// Main dashboard view
/// Displays user greeting and widget grid
public struct DashboardView: View {
    
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var profileManager: ProfileDataManager
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var widgetManager = WidgetManager.shared
    @State private var isLoading = true
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AuroraBackground()
            
            VStack(alignment: .leading, spacing: 0) {
                // Status bar
                HStack {
                    Text(currentTime)
                        .font(DesignSystem.Typography.body)
                        .foregroundColor(DesignSystem.Colors.textPrimary.opacity(0.8))
                        .shadow(radius: 2)
                    
                    Spacer()
                    
                    HStack(spacing: DesignSystem.Spacing.regular) {
                        Image(systemName: "wifi")
                        Image(systemName: "person.circle.fill")
                    }
                    .font(.system(size: 20))
                    .foregroundColor(DesignSystem.Colors.textPrimary.opacity(0.8))
                    .shadow(radius: 2)
                }
                .padding(.horizontal, DesignSystem.Spacing.section)
                .padding(.top, DesignSystem.Spacing.section)
                .padding(.bottom, DesignSystem.Spacing.large)
                
                // Greeting
                Text(greeting)
                    .font(DesignSystem.Typography.title)
                    .foregroundColor(DesignSystem.Colors.textPrimary.opacity(0.9))
                    .padding(.horizontal, DesignSystem.Spacing.section)
                    .padding(.bottom, DesignSystem.Spacing.large)
                
                // Widget grid
                if widgetManager.isLoading || isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if widgetManager.widgets.isEmpty {
                    // Empty state
                    VStack(spacing: DesignSystem.Spacing.large) {
                        Image(systemName: "square.grid.2x2")
                            .font(.system(size: 64))
                            .foregroundColor(DesignSystem.Colors.textMetadata)
                        
                        Text("No Widgets")
                            .font(DesignSystem.Typography.title)
                            .foregroundColor(DesignSystem.Colors.textSecondary)
                        
                        Text("Add widgets from the iOS app")
                            .font(DesignSystem.Typography.secondary)
                            .foregroundColor(DesignSystem.Colors.textMetadata)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    WidgetGrid(widgets: widgetManager.widgets)
                        .padding(.horizontal, DesignSystem.Spacing.section * 1.6)
                        .padding(.bottom, DesignSystem.Spacing.section * 1.2)
                }
            }
        }
        .task {
            await loadWidgets()
        }
    }
    
    // MARK: - Private Properties
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        let timeOfDay: String
        
        switch hour {
        case 0..<12:
            timeOfDay = "Good Morning"
        case 12..<17:
            timeOfDay = "Good Afternoon"
        default:
            timeOfDay = "Good Evening"
        }
        
        if let name = profileManager.currentProfile?.name.components(separatedBy: " ").first {
            return "\(timeOfDay), \(name)"
        }
        
        return timeOfDay
    }
    
    private var currentTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
    
    // MARK: - Private Methods
    
    private func loadWidgets() async {
        // Load widgets from CloudKit
        widgetManager.loadWidgets { result in
            Task { @MainActor in
                switch result {
                case .success:
                    // If no widgets, create defaults for prototype
                    if widgetManager.widgets.isEmpty {
                        await createDefaultWidgets()
                    }
                    isLoading = false
                case .failure:
                    // On error, use default widgets for prototype
                    await createDefaultWidgets()
                    isLoading = false
                }
            }
        }
    }
    
    private func createDefaultWidgets() async {
        // Create default widgets for prototype
        let defaultWidgets = [
            Widget(name: "Weather", type: "weather", position: 0, size: .small),
            Widget(name: "Calendar", type: "calendar", position: 1, size: .medium),
            Widget(name: "Music", type: "music", position: 2, size: .medium),
            Widget(name: "Home", type: "home", position: 3, size: .small)
        ]
        
        // Save default widgets
        for widget in defaultWidgets {
            widgetManager.saveWidget(widget) { _ in }
        }
    }
}

