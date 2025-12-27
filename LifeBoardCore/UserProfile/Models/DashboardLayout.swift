//
//  DashboardLayout.swift
//  LifeBoardCore
//
//  Dashboard layout model
//  Stores widget positions and layout configuration
//

import Foundation
import CloudKit

/// Dashboard layout model
/// Stores widget positions and layout preferences
public struct DashboardLayout: Codable, Identifiable {
    
    /// Unique identifier
    public let id: String
    
    /// Array of widget IDs in order
    public var widgetIDs: [String]
    
    /// Layout configuration (JSON encoded)
    public var layout: Data?
    
    /// Creation date
    public let createdAt: Date
    
    /// Last update date
    public var updatedAt: Date
    
    /// Initializer
    public init(
        id: String = UUID().uuidString,
        widgetIDs: [String] = [],
        layout: Data? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.widgetIDs = widgetIDs
        self.layout = layout
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - CloudKit Conversion

extension DashboardLayout {
    
    /// CloudKit record type identifier
    static let recordType = "DashboardLayout"
    
    /// Converts DashboardLayout to CKRecord
    func toCKRecord() -> CKRecord {
        let recordID = CKRecord.ID(recordName: id)
        let record = CKRecord(recordType: Self.recordType, recordID: recordID)
        
        record["widgetIDs"] = widgetIDs
        if let layout = layout {
            record["layout"] = layout
        }
        record["createdAt"] = createdAt
        record["updatedAt"] = updatedAt
        
        return record
    }
    
    /// Creates DashboardLayout from CKRecord
    init?(from record: CKRecord) {
        guard let widgetIDs = record["widgetIDs"] as? [String] else {
            return nil
        }
        
        self.id = record.recordID.recordName
        self.widgetIDs = widgetIDs
        self.layout = record["layout"] as? Data
        self.createdAt = record["createdAt"] as? Date ?? record.creationDate ?? Date()
        self.updatedAt = record["updatedAt"] as? Date ?? record.modificationDate ?? Date()
    }
}

