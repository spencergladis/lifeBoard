//
//  LifeBoardApp.swift
//  LifeBoard
//
//  lifeBoard tvOS app entry point
//  Command Center application
//

import SwiftUI

@main
struct LifeBoardApp: App {
    
    @StateObject private var authManager = AuthenticationManager.shared
    @StateObject private var themeManager = ThemeManager.shared
    @StateObject private var profileManager = ProfileDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isAuthenticated {
                    DashboardView()
                } else {
                    SignInView {
                        // On sign in success, create profile
                        Task {
                            await createUserProfile()
                        }
                    }
                }
            }
            .environmentObject(themeManager)
            .environmentObject(authManager)
            .environmentObject(profileManager)
        }
    }
    
    // MARK: - Private Methods
    
    private func createUserProfile() async {
        guard let userID = authManager.userIdentifier,
              let email = authManager.userEmail else {
            return
        }
        
        let name = authManager.userFullName?.formatted() ?? "User"
        
        await MainActor.run {
            profileManager.createProfile(
                name: name,
                email: email,
                photoURL: nil
            ) { result in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    print("Failed to create profile: \(error)")
                }
            }
        }
    }
}

