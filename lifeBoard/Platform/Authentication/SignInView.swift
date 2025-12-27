//
//  SignInView.swift
//  lifeBoard
//
//  Sign in with Apple authentication view
//  Programmatic design with Liquid Glass
//

import SwiftUI
import AuthenticationServices

/// Sign in view for tvOS
/// Displays Sign in with Apple button with programmatic design
public struct SignInView: View {
    
    @EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var profileManager: ProfileDataManager
    @FocusState private var isSignInButtonFocused: Bool
    
    public init() {}
    
    public var body: some View {
        ZStack {
            AuroraBackground()
            
            VStack(spacing: DesignSystem.Spacing.section) {
                VStack(spacing: DesignSystem.Spacing.regular) {
                    Image(systemName: "command.square.fill")
                        .font(.system(size: 96))
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                        .frame(width: 96, height: 96)
                        .liquidGlass(cornerRadius: DesignSystem.CornerRadius.card)
                    
                    Text("lifeBoard")
                        .font(DesignSystem.Typography.display)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                    
                    Text("Command Center")
                        .font(DesignSystem.Typography.title)
                        .foregroundColor(DesignSystem.Colors.textSecondary)
                }
                
                VStack(spacing: DesignSystem.Spacing.large) {
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        switch result {
                        case .success(let authorization):
                            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                                authManager.signInWithApple(credential: appleIDCredential) { result in
                                    switch result {
                                    case .success:
                                        // Create or fetch user profile
                                        if let userID = appleIDCredential.user as String? {
                                            profileManager.createUserProfile(
                                                id: userID,
                                                fullName: appleIDCredential.fullName?.givenName,
                                                email: appleIDCredential.email
                                            )
                                        }
                                    case .failure(let error):
                                        print("Sign in failed: \(error.localizedDescription)")
                                    }
                                }
                            }
                        case .failure(let error):
                            print("Authorization failed: \(error.localizedDescription)")
                        }
                    }
                    .signInWithAppleButtonStyle(.white)
                    .frame(width: 300, height: 60)
                    .cornerRadius(DesignSystem.CornerRadius.small)
                    .focusable()
                    .focused($isSignInButtonFocused)
                    .scaleEffect(isSignInButtonFocused ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSignInButtonFocused)
                    
                    Text("Press Enter to connect")
                        .font(DesignSystem.Typography.metadata)
                        .foregroundColor(DesignSystem.Colors.textMetadata)
                }
            }
        }
    }
}

