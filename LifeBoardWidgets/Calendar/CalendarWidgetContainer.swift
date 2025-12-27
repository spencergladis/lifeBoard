//
//  CalendarWidgetContainer.swift
//  LifeBoardWidgets
//
//  Calendar widget container that fetches and displays events
//

import SwiftUI
import EventKit

/// Calendar widget container that handles data fetching
public struct CalendarWidgetContainer: View {
    @State private var events: [EKEvent] = []
    @State private var isLoading = true
    @State private var error: Error?
    
    private let eventStore = EKEventStore()
    
    public init() {}
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = error {
                Text("Error loading events")
                    .font(DesignSystem.Typography.secondary)
                    .foregroundColor(DesignSystem.Colors.textSecondary)
            } else {
                CalendarWidgetView(events: events)
            }
        }
        .task {
            await loadEvents()
        }
    }
    
    private func loadEvents() async {
        do {
            let granted = try await eventStore.requestAccess(to: .event)
            
            guard granted else {
                error = CalendarWidgetError.accessDenied
                isLoading = false
                return
            }
            
            let calendars = eventStore.calendars(for: .event)
            let startDate = Date()
            let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate) ?? startDate
            
            let predicate = eventStore.predicateForEvents(
                withStart: startDate,
                end: endDate,
                calendars: calendars
            )
            
            let fetchedEvents = eventStore.events(matching: predicate)
                .sorted { $0.startDate < $1.startDate }
                .prefix(5)
            
            events = Array(fetchedEvents)
            isLoading = false
        } catch {
            self.error = error
            isLoading = false
        }
    }
}

