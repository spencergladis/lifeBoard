//
//  WidgetGrid.swift
//  LifeBoard
//
//  Widget grid layout with 3-column system
//  Uses LazyVGrid with Focus Engine integration
//

import SwiftUI

/// Widget grid container with 3-column layout
public struct WidgetGrid: View {
    
    let widgets: [Widget]
    
    public init(widgets: [Widget]) {
        self.widgets = widgets
    }
    
    public var body: some View {
        let columns = [
            GridItem(.flexible(), spacing: DesignSystem.Spacing.large * 4),
            GridItem(.flexible(), spacing: DesignSystem.Spacing.large * 4),
            GridItem(.flexible(), spacing: DesignSystem.Spacing.large * 4)
        ]
        
        LazyVGrid(columns: columns, spacing: DesignSystem.Spacing.large * 4) {
            ForEach(widgets.sorted(by: { $0.position < $1.position })) { widget in
                WidgetView(widget: widget)
                    .gridColumnSpan(widget.size.columnSpan)
            }
        }
    }
}

