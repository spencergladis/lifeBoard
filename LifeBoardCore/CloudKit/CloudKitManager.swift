//
//  CloudKitManager.swift
//  LifeBoardCore
//
//  CloudKit sync manager for Development environment
//  Handles basic sync operations for UserProfile, Widget, and DashboardLayout
//

import Foundation
import CloudKit
import Combine

/// Manages CloudKit operations for lifeBoard
/// Handles sync for UserProfile, Widget, and DashboardLayout record types
@MainActor
public final class CloudKitManager: ObservableObject {
    
    /// Shared singleton instance
    public static let shared = CloudKitManager()
    
    /// CloudKit container
    private let container: CKContainer
    
    /// Private database (Development environment)
    private var database: CKDatabase {
        container.privateCloudDatabase
    }
    
    /// Sync status
    @Published public var syncStatus: SyncStatus = .idle
    
    public enum SyncStatus {
        case idle
        case syncing
        case success
        case error(Error)
    }
    
    private init() {
        // CloudKit container identifier
        // Update this to match your CloudKit container from Xcode capabilities
        container = CKContainer(identifier: "iCloud.com.lifeboardapp.lifeBoard")
    }
    
    // MARK: - Public Methods
    
    /// Saves a record to CloudKit
    /// - Parameters:
    ///   - record: CKRecord to save
    ///   - completion: Completion handler with result
    public func save(_ record: CKRecord, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        syncStatus = .syncing
        
        database.save(record) { [weak self] savedRecord, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.syncStatus = .error(error)
                    completion(.failure(error))
                } else if let savedRecord = savedRecord {
                    self?.syncStatus = .success
                    completion(.success(savedRecord))
                }
            }
        }
    }
    
    /// Fetches a record by ID
    /// - Parameters:
    ///   - recordID: CKRecord.ID to fetch
    ///   - completion: Completion handler with result
    public func fetch(recordID: CKRecord.ID, completion: @escaping (Result<CKRecord, Error>) -> Void) {
        syncStatus = .syncing
        
        database.fetch(withRecordID: recordID) { [weak self] record, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.syncStatus = .error(error)
                    completion(.failure(error))
                } else if let record = record {
                    self?.syncStatus = .success
                    completion(.success(record))
                }
            }
        }
    }
    
    /// Queries records by type
    /// - Parameters:
    ///   - recordType: Record type to query
    ///   - predicate: Query predicate (default: all records)
    ///   - completion: Completion handler with results
    public func query(
        recordType: String,
        predicate: NSPredicate = NSPredicate(value: true),
        completion: @escaping (Result<[CKRecord], Error>) -> Void
    ) {
        syncStatus = .syncing
        
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { [weak self] records, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.syncStatus = .error(error)
                    completion(.failure(error))
                } else if let records = records {
                    self?.syncStatus = .success
                    completion(.success(records))
                } else {
                    self?.syncStatus = .success
                    completion(.success([]))
                }
            }
        }
    }
    
    /// Deletes a record
    /// - Parameters:
    ///   - recordID: CKRecord.ID to delete
    ///   - completion: Completion handler with result
    public func delete(recordID: CKRecord.ID, completion: @escaping (Result<Void, Error>) -> Void) {
        syncStatus = .syncing
        
        database.delete(withRecordID: recordID) { [weak self] _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.syncStatus = .error(error)
                    completion(.failure(error))
                } else {
                    self?.syncStatus = .success
                    completion(.success(()))
                }
            }
        }
    }
    
    /// Checks CloudKit account status
    /// - Parameter completion: Completion handler with account status
    public func checkAccountStatus(completion: @escaping (Result<CKAccountStatus, Error>) -> Void) {
        container.accountStatus { status, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(status))
                }
            }
        }
    }
}

