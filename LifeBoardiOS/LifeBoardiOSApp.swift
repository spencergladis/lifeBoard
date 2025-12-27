//
//  LifeBoardiOSApp.swift
//  LifeBoardiOS
//
//  lifeBoard iOS companion app entry point
//  Configuration and widget management
//

import SwiftUI

@main
struct LifeBoardiOSApp: App {
    
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject private var profileManager = ProfileDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            ConfigurationView()
                .environmentObject(themeManager)
                .environmentObject(profileManager)
        }
    }
}

