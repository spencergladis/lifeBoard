//
//  LifeBoardApp.swift
//  lifeBoard
//
//  lifeBoard tvOS app entry point
//  Command Center for your life
//

import SwiftUI

@main
struct LifeBoardApp: App {
    
    @StateObject private var authManager = AuthenticationManager.shared
    @StateObject private var profileManager = ProfileDataManager.shared
    @StateObject private var cloudKitManager = CloudKitManager.shared
    @StateObject private var themeManager = ThemeManager.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isAuthenticated {
                    DashboardView()
                        .environmentObject(authManager)
                        .environmentObject(profileManager)
                        .environmentObject(cloudKitManager)
                        .environmentObject(themeManager)
                } else {
                    SignInView()
                        .environmentObject(authManager)
                        .environmentObject(profileManager)
                        .environmentObject(cloudKitManager)
                        .environmentObject(themeManager)
                }
            }
            .onAppear {
                authManager.checkAuthenticationStatus()
            }
        }
    }
}

