//
//  ProfileSettingsView.swift
//  LifeBoardiOS
//
//  Profile settings view
//  Displays user profile information
//

import SwiftUI

/// Profile settings view
public struct ProfileSettingsView: View {
    
    @EnvironmentObject var profileManager: ProfileDataManager
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            List {
                if let profile = profileManager.currentProfile {
                    Section("Profile Information") {
                        HStack {
                            Text("Name")
                            Spacer()
                            Text(profile.name)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Text("Email")
                            Spacer()
                            Text(profile.email)
                                .foregroundColor(.secondary)
                        }
                    }
                } else {
                    Section {
                        Text("No profile found")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Profile")
        }
        .task {
            profileManager.loadProfile { _ in }
        }
    }
}

