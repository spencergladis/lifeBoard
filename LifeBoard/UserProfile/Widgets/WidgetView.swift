//
//  WidgetView.swift
//  LifeBoard
//
//  Individual widget wrapper
//  Uses FocusableCard and LiquidGlassModifier
//

import SwiftUI

/// Individual widget view wrapper
/// Applies FocusableCard and LiquidGlassModifier
public struct WidgetView: View {
    
    let widget: Widget
    @State private var isLoading = true
    @State private var error: Error?
    
    public init(widget: Widget) {
        self.widget = widget
    }
    
    public var body: some View {
        FocusableCard {
            Group {
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(DesignSystem.Spacing.large)
                } else if let error = error {
                    VStack(spacing: DesignSystem.Spacing.regular) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 32))
                            .foregroundColor(DesignSystem.Colors.textMetadata)
                        Text("Error loading widget")
                            .font(DesignSystem.Typography.secondary)
                            .foregroundColor(DesignSystem.Colors.textSecondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(DesignSystem.Spacing.large)
                } else {
                    widgetContent
                }
            }
            .liquidGlass()
        }
        .task {
            await loadWidgetData()
        }
    }
    
    @ViewBuilder
    private var widgetContent: some View {
        if let widgetProtocol = WidgetProvider.shared.createWidget(
            type: widget.type,
            widgetData: widget
        ) {
            AnyView(widgetProtocol.view())
        } else {
            // Fallback for unknown widget type
            VStack(spacing: DesignSystem.Spacing.regular) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 32))
                    .foregroundColor(DesignSystem.Colors.textMetadata)
                Text("Unknown widget: \(widget.type)")
                    .font(DesignSystem.Typography.body)
                    .foregroundColor(DesignSystem.Colors.textSecondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(DesignSystem.Spacing.large)
        }
    }
    
    // MARK: - Private Methods
    
    private func loadWidgetData() async {
        guard let widgetProtocol = WidgetProvider.shared.createWidget(
            type: widget.type,
            widgetData: widget
        ) else {
            error = NSError(domain: "WidgetView", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown widget type"])
            isLoading = false
            return
        }
        
        do {
            _ = try await widgetProtocol.fetchData()
            isLoading = false
        } catch {
            self.error = error
            isLoading = false
        }
    }
}

