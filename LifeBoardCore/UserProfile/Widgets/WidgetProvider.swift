//
//  WidgetProvider.swift
//  LifeBoardCore
//
//  Widget factory and registry
//  Manages widget instantiation and discovery
//

import Foundation

/// Factory for widget instantiation
/// Manages widget registry and creation
public final class WidgetProvider {
    
    /// Shared singleton instance
    public static let shared = WidgetProvider()
    
    /// Widget registry: type identifier -> widget factory closure
    private var widgetFactories: [String: () -> any WidgetProtocol] = [:]
    
    private init() {
        registerDefaultWidgets()
    }
    
    // MARK: - Public Methods
    
    /// Registers a widget factory
    /// - Parameters:
    ///   - type: Widget type identifier
    ///   - factory: Factory closure that creates the widget
    public func register(type: String, factory: @escaping () -> any WidgetProtocol) {
        widgetFactories[type] = factory
    }
    
    /// Creates a widget instance by type
    /// - Parameters:
    ///   - type: Widget type identifier
    ///   - widgetData: Optional widget data model
    /// - Returns: Widget instance or nil if type not registered
    public func createWidget(type: String, widgetData: Widget? = nil) -> (any WidgetProtocol)? {
        guard let factory = widgetFactories[type] else {
            return nil
        }
        
        var widget = factory()
        
        // Apply widget data if provided
        if let widgetData = widgetData {
            // Update widget properties from data
            // This would need to be implemented per widget type
        }
        
        return widget
    }
    
    /// Gets all registered widget types
    /// - Returns: Array of widget type identifiers
    public func availableWidgetTypes() -> [String] {
        return Array(widgetFactories.keys)
    }
    
    // MARK: - Private Methods
    
    private func registerDefaultWidgets() {
        // Calendar Widget
        register(type: "calendar") {
            CalendarWidget()
        }
        
        // Weather Widget
        register(type: "weather") {
            WeatherWidget()
        }
        
        // Music Widget
        register(type: "music") {
            MusicWidget()
        }
        
        // Home Widget
        register(type: "home") {
            HomeWidget()
        }
    }
}

