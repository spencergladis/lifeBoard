//
//  WidgetList.swift
//  LifeBoardiOS
//
//  Widget list and management screen
//  Add/remove widgets, enable/disable
//

import SwiftUI

/// Widget list view for managing widgets
public struct WidgetList: View {
    
    @StateObject private var widgetManager = WidgetManager.shared
    @State private var availableWidgetTypes = WidgetProvider.shared.availableWidgetTypes()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            List {
                Section("Active Widgets") {
                    ForEach(widgetManager.widgets.sorted(by: { $0.position < $1.position })) { widget in
                        WidgetRow(widget: widget) {
                            deleteWidget(widget)
                        }
                    }
                }
                
                Section("Available Widgets") {
                    ForEach(availableWidgetTypes, id: \.self) { type in
                        if !widgetManager.widgets.contains(where: { $0.type == type }) {
                            Button(action: {
                                addWidget(type: type)
                            }) {
                                HStack {
                                    Text(widgetName(for: type))
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Widgets")
            .refreshable {
                await refreshWidgets()
            }
        }
        .task {
            await loadWidgets()
        }
    }
    
    // MARK: - Private Methods
    
    private func widgetName(for type: String) -> String {
        switch type {
        case "calendar":
            return "Calendar"
        case "weather":
            return "Weather"
        case "music":
            return "Music"
        case "home":
            return "Home"
        default:
            return type.capitalized
        }
    }
    
    private func addWidget(type: String) {
        widgetManager.addWidget(
            type: type,
            name: widgetName(for: type),
            size: .medium
        ) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("Failed to add widget: \(error)")
            }
        }
    }
    
    private func deleteWidget(_ widget: Widget) {
        widgetManager.deleteWidget(widgetID: widget.id) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print("Failed to delete widget: \(error)")
            }
        }
    }
    
    private func loadWidgets() async {
        widgetManager.loadWidgets { _ in }
    }
    
    private func refreshWidgets() async {
        widgetManager.loadWidgets { _ in }
    }
}

// MARK: - Widget Row

private struct WidgetRow: View {
    let widget: Widget
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(widget.name)
                    .font(.headline)
                Text(widget.type)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(widget.size.rawValue.capitalized)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
}

