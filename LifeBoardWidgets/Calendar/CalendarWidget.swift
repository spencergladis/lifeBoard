//
//  CalendarWidget.swift
//  LifeBoardWidgets
//
//  Calendar widget implementation
//  Uses EventKit to fetch calendar events
//

import Foundation
import EventKit
import SwiftUI

/// Calendar widget that displays upcoming calendar events
public struct CalendarWidget: WidgetProtocol {
    
    public let id: String
    public let name: String = "Calendar"
    public let type: String = "calendar"
    public var position: Int
    public var size: WidgetSize
    
    /// EventKit store
    private let eventStore = EKEventStore()
    
    /// Initializer
    public init(
        id: String = UUID().uuidString,
        position: Int = 0,
        size: WidgetSize = .medium
    ) {
        self.id = id
        self.position = position
        self.size = size
    }
    
    // MARK: - WidgetProtocol
    
    public func fetchData() async throws -> WidgetData {
        // Request calendar access
        let granted = try await eventStore.requestAccess(to: .event)
        
        guard granted else {
            throw CalendarWidgetError.accessDenied
        }
        
        // Fetch upcoming events
        let calendars = eventStore.calendars(for: .event)
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate) ?? startDate
        
        let predicate = eventStore.predicateForEvents(
            withStart: startDate,
            end: endDate,
            calendars: calendars
        )
        
        let events = eventStore.events(matching: predicate)
            .sorted { $0.startDate < $1.startDate }
            .prefix(5) // Limit to 5 events
        
        // Convert to widget data
        let eventData = events.map { event in
            [
                "title": event.title,
                "startDate": event.startDate.timeIntervalSince1970,
                "endDate": event.endDate.timeIntervalSince1970,
                "calendarColor": event.calendar.cgColor.components?.prefix(3).map { $0 } ?? []
            ]
        }
        
        return WidgetData(content: ["events": AnyCodable(Array(eventData))])
    }
    
    @ViewBuilder
    public func view() -> AnyView {
        AnyView(CalendarWidgetContainer())
    }
    
    public mutating func resize(to newSize: WidgetSize) {
        self.size = newSize
    }
}

// MARK: - Calendar Widget Error

enum CalendarWidgetError: Error {
    case accessDenied
    case noEvents
}

