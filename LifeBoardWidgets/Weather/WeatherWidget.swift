//
//  WeatherWidget.swift
//  LifeBoardWidgets
//
//  Weather widget implementation
//  Uses mock data for prototype
//

import Foundation
import SwiftUI

/// Weather widget that displays current weather conditions
/// Uses mock data for prototype (no API needed)
public struct WeatherWidget: WidgetProtocol {
    
    public let id: String
    public let name: String = "Weather"
    public let type: String = "weather"
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
        // Mock weather data for prototype
        let mockData: [String: AnyCodable] = [
            "location": AnyCodable("Cupertino"),
            "condition": AnyCodable("Mostly Clear"),
            "temperature": AnyCodable(72),
            "windSpeed": AnyCodable(4),
            "humidity": AnyCodable(12)
        ]
        
        return WidgetData(content: mockData)
    }
    
    @ViewBuilder
    public func view() -> AnyView {
        AnyView(WeatherWidgetView())
    }
    
    public mutating func resize(to newSize: WidgetSize) {
        self.size = newSize
    }
}

