//
//  UserProfile.swift
//  LifeBoardCore
//
//  User profile model
//  Codable struct with CloudKit support
//

import Foundation
import CloudKit

/// User profile model
/// Codable struct that can be converted to/from CloudKit records
public struct UserProfile: Codable, Identifiable {
    
    /// Unique identifier
    public let id: String
    
    /// User's full name
    public var name: String
    
    /// User's email address
    public var email: String
    
    /// Profile photo URL (optional)
    public var photoURL: String?
    
    /// Creation date
    public let createdAt: Date
    
    /// Last update date
    public var updatedAt: Date
    
    /// Initializer
    public init(
        id: String = UUID().uuidString,
        name: String,
        email: String,
        photoURL: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.photoURL = photoURL
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - CloudKit Conversion

extension UserProfile {
    
    /// CloudKit record type identifier
    static let recordType = "UserProfile"
    
    /// Converts UserProfile to CKRecord
    func toCKRecord() -> CKRecord {
        let recordID = CKRecord.ID(recordName: id)
        let record = CKRecord(recordType: Self.recordType, recordID: recordID)
        
        record["name"] = name
        record["email"] = email
        if let photoURL = photoURL {
            record["photoURL"] = photoURL
        }
        record["createdAt"] = createdAt
        record["updatedAt"] = updatedAt
        
        return record
    }
    
    /// Creates UserProfile from CKRecord
    init?(from record: CKRecord) {
        guard let name = record["name"] as? String,
              let email = record["email"] as? String else {
            return nil
        }
        
        self.id = record.recordID.recordName
        self.name = name
        self.email = email
        self.photoURL = record["photoURL"] as? String
        self.createdAt = record["createdAt"] as? Date ?? record.creationDate ?? Date()
        self.updatedAt = record["updatedAt"] as? Date ?? record.modificationDate ?? Date()
    }
}

