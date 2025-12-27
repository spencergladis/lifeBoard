//
//  WidgetManager.swift
//  LifeBoardCore
//
//  Widget management and CloudKit sync
//  Handles widget CRUD operations
//

import Foundation
import CloudKit
import Combine

/// Manages widgets and CloudKit sync
/// Handles widget CRUD operations
@MainActor
public final class WidgetManager: ObservableObject {
    
    /// Shared singleton instance
    public static let shared = WidgetManager()
    
    /// Current widgets
    @Published public var widgets: [Widget] = []
    
    /// Loading state
    @Published public var isLoading: Bool = false
    
    /// Error state
    @Published public var error: Error?
    
    private let cloudKitManager = CloudKitManager.shared
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Loads widgets from CloudKit
    /// - Parameter completion: Completion handler
    public func loadWidgets(completion: @escaping (Result<[Widget], Error>) -> Void) {
        isLoading = true
        error = nil
        
        cloudKitManager.query(recordType: Widget.recordType) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let records):
                    let widgets = records.compactMap { Widget(from: $0) }
                        .sorted { $0.position < $1.position }
                    self?.widgets = widgets
                    completion(.success(widgets))
                case .failure(let error):
                    self?.error = error
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Saves a widget to CloudKit
    /// - Parameters:
    ///   - widget: Widget to save
    ///   - completion: Completion handler
    public func saveWidget(_ widget: Widget, completion: @escaping (Result<Widget, Error>) -> Void) {
        isLoading = true
        error = nil
        
        var updatedWidget = widget
        updatedWidget.updatedAt = Date()
        
        let record = updatedWidget.toCKRecord()
        
        cloudKitManager.save(record) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let savedRecord):
                    if let savedWidget = Widget(from: savedRecord) {
                        // Update local widgets array
                        if let index = self?.widgets.firstIndex(where: { $0.id == savedWidget.id }) {
                            self?.widgets[index] = savedWidget
                        } else {
                            self?.widgets.append(savedWidget)
                        }
                        completion(.success(savedWidget))
                    } else {
                        let error = NSError(domain: "WidgetManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to create widget from record"])
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
    
    /// Deletes a widget
    /// - Parameters:
    ///   - widgetID: Widget ID to delete
    ///   - completion: Completion handler
    public func deleteWidget(widgetID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        error = nil
        
        let recordID = CKRecord.ID(recordName: widgetID)
        
        cloudKitManager.delete(recordID: recordID) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success:
                    self?.widgets.removeAll { $0.id == widgetID }
                    completion(.success(()))
                case .failure(let error):
                    self?.error = error
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Adds a new widget
    /// - Parameters:
    ///   - type: Widget type
    ///   - name: Widget name
    ///   - size: Widget size
    ///   - completion: Completion handler
    public func addWidget(
        type: String,
        name: String,
        size: WidgetSize = .medium,
        completion: @escaping (Result<Widget, Error>) -> Void
    ) {
        let position = widgets.count
        let newWidget = Widget(
            name: name,
            type: type,
            position: position,
            size: size
        )
        
        saveWidget(newWidget, completion: completion)
    }
}

