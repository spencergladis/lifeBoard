//
//  NavigationCoordinator.swift
//  LifeBoard
//
//  Navigation state management
//  Handles Apple Remote and back button navigation
//

import SwiftUI

/// Navigation coordinator for tvOS
/// Manages navigation state and Apple Remote handling
@MainActor
public final class NavigationCoordinator: ObservableObject {
    
    /// Shared singleton instance
    public static let shared = NavigationCoordinator()
    
    /// Current navigation path
    @Published public var navigationPath: NavigationPath = NavigationPath()
    
    /// Whether we're showing dashboard or detail view
    @Published public var isShowingDetail = false
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Navigates to a detail view
    /// - Parameter item: Item to show detail for
    public func navigateToDetail(_ item: Any) {
        isShowingDetail = true
        navigationPath.append(item)
    }
    
    /// Navigates back to dashboard
    public func navigateBack() {
        isShowingDetail = false
        navigationPath.removeLast()
    }
    
    /// Resets navigation to root
    public func reset() {
        isShowingDetail = false
        navigationPath = NavigationPath()
    }
}

