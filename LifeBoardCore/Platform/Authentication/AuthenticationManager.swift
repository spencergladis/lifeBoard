//
//  AuthenticationManager.swift
//  LifeBoardCore
//
//  Sign in with Apple authentication manager
//  Handles identity establishment, session management, and token handling
//

import Foundation
import AuthenticationServices
import Combine

/// Manages Sign in with Apple authentication
/// Observable object for authentication state
@MainActor
public final class AuthenticationManager: NSObject, ObservableObject {
    
    /// Shared singleton instance
    public static let shared = AuthenticationManager()
    
    /// Current authentication state
    @Published public var isAuthenticated: Bool = false
    
    /// Current user identifier
    @Published public var userIdentifier: String?
    
    /// Current user email
    @Published public var userEmail: String?
    
    /// Current user full name
    @Published public var userFullName: PersonNameComponents?
    
    private override init() {
        super.init()
        checkExistingAuthentication()
    }
    
    // MARK: - Public Methods
    
    /// Initiates Sign in with Apple flow
    /// - Parameter completion: Completion handler with result
    public func signIn(completion: @escaping (Result<Void, Error>) -> Void) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        
        self.completion = completion
        controller.performRequests()
    }
    
    /// Signs out the current user
    public func signOut() {
        userIdentifier = nil
        userEmail = nil
        userFullName = nil
        isAuthenticated = false
    }
    
    // MARK: - Private Properties
    
    private var completion: ((Result<Void, Error>) -> Void)?
    private var presentationContextProvider: ASAuthorizationControllerPresentationContextProviding?
}

// MARK: - ASAuthorizationControllerDelegate

extension AuthenticationManager: ASAuthorizationControllerDelegate {
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Store user identifier
            let userID = appleIDCredential.user
            userIdentifier = userID
            
            // Store user information
            userEmail = appleIDCredential.email
            userFullName = appleIDCredential.fullName
            
            // Store identity token if available
            if let identityToken = appleIDCredential.identityToken,
               let tokenString = String(data: identityToken, encoding: .utf8) {
                // Store token securely (will use KeychainManager)
            }
            
            isAuthenticated = true
            completion?(.success(()))
        }
    }
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        isAuthenticated = false
        completion?(.failure(error))
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension AuthenticationManager: ASAuthorizationControllerPresentationContextProviding {
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // For tvOS, this will be handled by the view
        // Return a window anchor - implementation depends on platform
        #if os(tvOS)
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow } ?? UIWindow()
        #else
        return UIApplication.shared.windows.first { $0.isKeyWindow } ?? UIWindow()
        #endif
    }
}

// MARK: - Private Methods

private extension AuthenticationManager {
    
    /// Checks for existing authentication state
    func checkExistingAuthentication() {
        // Check if user is already authenticated
        // This would check KeychainManager for stored credentials
        // For now, default to false
        isAuthenticated = false
    }
}

