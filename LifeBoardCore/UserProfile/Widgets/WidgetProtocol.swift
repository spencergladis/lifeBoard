//
//  WidgetProtocol.swift
//  LifeBoardCore
//
//  Widget protocol definition
//  All widgets must conform to this protocol
//

import SwiftUI

/// Protocol that all widgets must conform to
/// Defines the interface for widget functionality
public protocol WidgetProtocol: Identifiable {
    
    /// Unique widget identifier
    var id: String { get }
    
    /// Widget display name
    var name: String { get }
    
    /// Widget type identifier
    var type: String { get }
    
    /// Widget position in grid
    var position: Int { get set }
    
    /// Widget size (small, medium, large)
    var size: WidgetSize { get set }
    
    /// Fetches widget data asynchronously
    /// - Returns: Widget data
    func fetchData() async throws -> WidgetData
    
    /// Creates the SwiftUI view for the widget
    /// - Returns: Widget view
    @ViewBuilder
    func view() -> AnyView
    
    /// Resizes the widget
    /// - Parameter newSize: New size for the widget
    mutating func resize(to newSize: WidgetSize)
}

/// Widget size options
public enum WidgetSize: String, Codable {
    case small = "small"
    case medium = "medium"
    case large = "large"
    case custom = "custom"
    
    /// Column span for grid layout
    public var columnSpan: Int {
        switch self {
        case .small:
            return 1
        case .medium:
            return 2
        case .large:
            return 3
        case .custom:
            return 2 // Default to medium for custom
        }
    }
}

/// Widget data container
public struct WidgetData: Codable {
    public let content: [String: AnyCodable]
    
    public init(content: [String: AnyCodable]) {
        self.content = content
    }
}

/// Type-erased codable value for widget data
public struct AnyCodable: Codable {
    public let value: Any
    
    public init(_ value: Any) {
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let int = try? container.decode(Int.self) {
            value = int
        } else if let double = try? container.decode(Double.self) {
            value = double
        } else if let string = try? container.decode(String.self) {
            value = string
        } else if let array = try? container.decode([AnyCodable].self) {
            value = array.map { $0.value }
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            value = dictionary.mapValues { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "AnyCodable value cannot be decoded")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch value {
        case let bool as Bool:
            try container.encode(bool)
        case let int as Int:
            try container.encode(int)
        case let double as Double:
            try container.encode(double)
        case let string as String:
            try container.encode(string)
        case let array as [Any]:
            try container.encode(array.map { AnyCodable($0) })
        case let dictionary as [String: Any]:
            try container.encode(dictionary.mapValues { AnyCodable($0) })
        default:
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: container.codingPath, debugDescription: "AnyCodable value cannot be encoded"))
        }
    }
}

