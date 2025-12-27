//
//  SignInView.swift
//  LifeBoard
//
//  Sign in with Apple authentication screen
//  Programmatic design using DesignSystem constants
//

import SwiftUI
import AuthenticationServices

/// Sign in screen with programmatic design
public struct SignInView: View {
    
    @StateObject private var authManager = AuthenticationManager.shared
    @State private var isSigningIn = false
    
    let onSignInSuccess: () -> Void
    
    public init(onSignInSuccess: @escaping () -> Void) {
        self.onSignInSuccess = onSignInSuccess
    }
    
    public var body: some View {
        ZStack {
            // Aurora background
            AuroraBackground()
                .ignoresSafeArea()
            
            // Content
            VStack(spacing: DesignSystem.Spacing.section) {
                Spacer()
                
                // Logo (programmatic)
                RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.card)
                    .fill(DesignSystem.Colors.glass20)
                    .frame(width: 96, height: 96)
                    .overlay(
                        Image(systemName: "command")
                            .font(.system(size: 48))
                            .foregroundColor(DesignSystem.Colors.textPrimary)
                    )
                    .liquidGlass()
                
                // Title
                VStack(spacing: DesignSystem.Spacing.compact) {
                    Text("lifeBoard")
                        .font(DesignSystem.Typography.display)
                        .foregroundColor(DesignSystem.Colors.textPrimary)
                        .tracking(-1.0)
                    
                    Text("Command Center")
                        .font(DesignSystem.Typography.secondary)
                        .foregroundColor(DesignSystem.Colors.textSecondary)
                }
                
                Spacer()
                
                // Sign in button
                Button(action: {
                    isSigningIn = true
                    authManager.signIn { result in
                        handleSignInResult(result)
                    }
                }) {
                    HStack(spacing: DesignSystem.Spacing.regular) {
                        Image(systemName: "applelogo")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        
                        Text("Sign in with Apple")
                            .font(DesignSystem.Typography.body)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, DesignSystem.Spacing.section)
                    .padding(.vertical, DesignSystem.Spacing.regular)
                    .background(Color.white)
                    .cornerRadius(DesignSystem.CornerRadius.small)
                }
                .disabled(isSigningIn)
                .padding(.horizontal, DesignSystem.Spacing.section)
                
                // Hint text
                Text("Press Enter to connect")
                    .font(DesignSystem.Typography.metadata)
                    .foregroundColor(DesignSystem.Colors.textMetadata)
                    .padding(.top, DesignSystem.Spacing.regular)
                
                Spacer()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSignInResult(_ result: Result<Void, Error>) {
        switch result {
        case .success:
            isSigningIn = false
            onSignInSuccess()
        case .failure(let error):
            isSigningIn = false
            print("Sign in error: \(error)")
        }
    }
}

