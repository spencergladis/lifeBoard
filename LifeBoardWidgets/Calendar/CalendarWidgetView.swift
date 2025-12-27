//
//  CalendarWidgetView.swift
//  LifeBoardWidgets
//
//  Calendar widget SwiftUI view
//  Displays upcoming calendar events with Liquid Glass styling
//

import SwiftUI
import EventKit

/// Calendar widget view
/// Displays upcoming events with programmatic design
public struct CalendarWidgetView: View {
    
    let events: [EKEvent]
    
    public init(events: [EKEvent]) {
        self.events = Array(events.prefix(5)) // Limit to 5 events
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.large) {
            // Header
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.red.opacity(0.8))
                
                Text("UP NEXT")
                    .font(DesignSystem.Typography.caption)
                    .foregroundColor(.red.opacity(0.8))
                    .tracking(1.0)
                
                Spacer()
                
                Text("Today")
                    .font(DesignSystem.Typography.secondary)
                    .foregroundColor(DesignSystem.Colors.textMetadata)
            }
            
            // Events list
            if events.isEmpty {
                Text("No upcoming events")
                    .font(DesignSystem.Typography.secondary)
                    .foregroundColor(DesignSystem.Colors.textSecondary)
            } else {
                VStack(alignment: .leading, spacing: DesignSystem.Spacing.regular) {
                    ForEach(Array(events.enumerated()), id: \.element.eventIdentifier) { index, event in
                        EventRow(event: event, isCurrent: index == 0)
                    }
                }
            }
        }
        .padding(DesignSystem.Spacing.large)
    }
}

// MARK: - Event Row

private struct EventRow: View {
    let event: EKEvent
    let isCurrent: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: DesignSystem.Spacing.regular) {
            // Colored bar
            Rectangle()
                .fill(Color(event.calendar.cgColor))
                .frame(width: 2)
            
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.compact / 2) {
                Text(event.title)
                    .font(DesignSystem.Typography.body)
                    .foregroundColor(isCurrent ? DesignSystem.Colors.textPrimary : DesignSystem.Colors.textPrimary.opacity(0.5))
                
                Text(timeString(from: event.startDate))
                    .font(DesignSystem.Typography.metadata)
                    .foregroundColor(DesignSystem.Colors.textMetadata)
            }
        }
    }
    
    private func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

