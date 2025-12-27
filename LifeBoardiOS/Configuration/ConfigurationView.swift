//
//  ConfigurationView.swift
//  LifeBoardiOS
//
//  Main configuration screen for iOS companion app
//  Widget and service management
//

import SwiftUI

/// Main configuration view for iOS app
public struct ConfigurationView: View {
    
    @EnvironmentObject var profileManager: ProfileDataManager
    @State private var selectedTab = 0
    
    public init() {}
    
    public var body: some View {
        TabView(selection: $selectedTab) {
            WidgetList()
                .tabItem {
                    Label("Widgets", systemImage: "square.grid.2x2")
                }
                .tag(0)
            
            ProfileSettingsView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(1)
        }
    }
}

