//
//  ProfileDataManager.swift
//  LifeBoardCore
//
//  User profile data management
//  Handles CRUD operations and CloudKit sync
//

import Foundation
import CloudKit
import Combine

/// Manages user profile data operations
/// Handles CloudKit sync for user profile
@MainActor
public final class ProfileDataManager: ObservableObject {
    
    /// Shared singleton instance
    public static let shared = ProfileDataManager()
    
    /// Current user profile
    @Published public var currentProfile: UserProfile?
    
    /// Loading state
    @Published public var isLoading: Bool = false
    
    /// Error state
    @Published public var error: Error?
    
    private let cloudKitManager = CloudKitManager.shared
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Creates a new user profile
    /// - Parameters:
    ///   - name: User's name
    ///   - email: User's email
    ///   - photoURL: Optional photo URL
    ///   - completion: Completion handler
    public func createProfile(
        name: String,
        email: String,
        photoURL: String? = nil,
        completion: @escaping (Result<UserProfile, Error>) -> Void
    ) {
        isLoading = true
        error = nil
        
        let profile = UserProfile(
            name: name,
            email: email,
            photoURL: photoURL
        )
        
        let record = profile.toCKRecord()
        
        cloudKitManager.save(record) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let savedRecord):
                    if let savedProfile = UserProfile(from: savedRecord) {
                        self?.currentProfile = savedProfile
                        completion(.success(savedProfile))
                    } else {
                        let error = NSError(domain: "ProfileDataManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create profile from record"])
                        self?.error = error
                        completion(.failure(error))
                    }
                case .failure(let error):
                    self?.error = error
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Loads user profile from CloudKit
    /// - Parameter completion: Completion handler
    public func loadProfile(completion: @escaping (Result<UserProfile?, Error>) -> Void) {
        isLoading = true
        error = nil
        
        // Query for user profile
        // For MVP, we'll fetch the first profile (in production, filter by user ID)
        cloudKitManager.query(recordType: UserProfile.recordType) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let records):
                    if let firstRecord = records.first,
                       let profile = UserProfile(from: firstRecord) {
                        self?.currentProfile = profile
                        completion(.success(profile))
                    } else {
                        self?.currentProfile = nil
                        completion(.success(nil))
                    }
                case .failure(let error):
                    self?.error = error
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Updates existing profile
    /// - Parameters:
    ///   - profile: Updated profile
    ///   - completion: Completion handler
    public func updateProfile(
        _ profile: UserProfile,
        completion: @escaping (Result<UserProfile, Error>) -> Void
    ) {
        isLoading = true
        error = nil
        
        var updatedProfile = profile
        updatedProfile.updatedAt = Date()
        
        let record = updatedProfile.toCKRecord()
        
        cloudKitManager.save(record) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let savedRecord):
                    if let savedProfile = UserProfile(from: savedRecord) {
                        self?.currentProfile = savedProfile
                        completion(.success(savedProfile))
                    } else {
                        let error = NSError(domain: "ProfileDataManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to update profile from record"])
                        self?.error = error
                        completion(.failure(error))
                    }
                case .failure(let error):
                    self?.error = error
                    completion(.failure(error))
                }
            }
        }
    }
}

