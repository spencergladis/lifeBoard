//
//  NavigationCoordinator.swift
//  lifeBoard
//
//  Navigation coordinator for tvOS app
//  Manages screen navigation and Apple Remote handling
//

import SwiftUI

/// Navigation screen enum
public enum Screen: Hashable {
    case signIn
    case dashboard
    case widgetDetail(UUID) // For expanding a widget
}

/// Navigation coordinator
/// Manages navigation state within the tvOS app
@MainActor
public class NavigationCoordinator: ObservableObject {
    
    @Published var currentScreen: Screen = .signIn
    
    public init() {}
    
    /// Navigate to a screen
    /// - Parameter screen: Target screen
    public func navigate(to screen: Screen) {
        self.currentScreen = screen
    }
    
    /// Navigate back
    public func goBack() {
        // Implement more sophisticated back stack logic if needed
        // For MVP, a simple back to dashboard might suffice
        if currentScreen != .dashboard {
            currentScreen = .dashboard
        }
    }
}


