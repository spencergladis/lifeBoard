//
//  HomeWidget.swift
//  LifeBoardWidgets
//
//  Home widget implementation
//  Displays home status information
//

import Foundation
import HomeKit
import SwiftUI

/// Home widget that displays home status
/// Uses HomeKit for home automation status
public struct HomeWidget: WidgetProtocol {
    
    public let id: String
    public let name: String = "Home"
    public let type: String = "home"
    public var position: Int
    public var size: WidgetSize
    
    /// Initializer
    public init(
        id: String = UUID().uuidString,
        position: Int = 0,
        size: WidgetSize = .small
    ) {
        self.id = id
        self.position = position
        self.size = size
    }
    
    // MARK: - WidgetProtocol
    
    public func fetchData() async throws -> WidgetData {
        // For prototype, use mock data
        // In production, integrate with HomeKit
        let mockData: [String: AnyCodable] = [
            "livingRoom": AnyCodable([
                "name": "Living Room",
                "status": "On",
                "brightness": 80
            ]),
            "temperature": AnyCodable([
                "value": 70,
                "unit": "F"
            ])
        ]
        
        return WidgetData(content: mockData)
    }
    
    @ViewBuilder
    public func view() -> AnyView {
        AnyView(HomeWidgetView())
    }
    
    public mutating func resize(to newSize: WidgetSize) {
        self.size = newSize
    }
}

