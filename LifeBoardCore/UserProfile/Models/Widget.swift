//
//  Widget.swift
//  LifeBoardCore
//
//  Widget data model
//  Codable struct with CloudKit support
//

import Foundation
import CloudKit

/// Widget data model
/// Codable struct that can be converted to/from CloudKit records
public struct Widget: Codable, Identifiable {
    
    /// Unique identifier
    public let id: String
    
    /// Widget display name
    public var name: String
    
    /// Widget type identifier
    public var type: String
    
    /// Widget position in grid
    public var position: Int
    
    /// Widget size
    public var size: WidgetSize
    
    /// Widget configuration (JSON encoded)
    public var config: Data?
    
    /// Creation date
    public let createdAt: Date
    
    /// Last update date
    public var updatedAt: Date
    
    /// Initializer
    public init(
        id: String = UUID().uuidString,
        name: String,
        type: String,
        position: Int,
        size: WidgetSize,
        config: Data? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.position = position
        self.size = size
        self.config = config
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - CloudKit Conversion

extension Widget {
    
    /// CloudKit record type identifier
    static let recordType = "Widget"
    
    /// Converts Widget to CKRecord
    func toCKRecord() -> CKRecord {
        let recordID = CKRecord.ID(recordName: id)
        let record = CKRecord(recordType: Self.recordType, recordID: recordID)
        
        record["name"] = name
        record["type"] = type
        record["position"] = position
        record["size"] = size.rawValue
        if let config = config {
            record["config"] = config
        }
        record["createdAt"] = createdAt
        record["updatedAt"] = updatedAt
        
        return record
    }
    
    /// Creates Widget from CKRecord
    init?(from record: CKRecord) {
        guard let name = record["name"] as? String,
              let type = record["type"] as? String,
              let position = record["position"] as? Int,
              let sizeString = record["size"] as? String,
              let size = WidgetSize(rawValue: sizeString) else {
            return nil
        }
        
        self.id = record.recordID.recordName
        self.name = name
        self.type = type
        self.position = position
        self.size = size
        self.config = record["config"] as? Data
        self.createdAt = record["createdAt"] as? Date ?? record.creationDate ?? Date()
        self.updatedAt = record["updatedAt"] as? Date ?? record.modificationDate ?? Date()
    }
}

