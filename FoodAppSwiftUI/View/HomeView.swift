//
//  HomeView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

/// The main view for the home screen of the FoodAppSwiftUI application.
///
/// This view manages the display of different content tabs including home, purchase, favorite, and trash.
/// It also handles the side menu interaction with drag gestures, animating the main content view accordingly.
struct HomeView: View {
    /// The purchase card data model observed for changes.
    @StateObject private var purchaseCard = PurchaseCard()
    
    /// The currently selected tab in the content view.
    @State private var selectionTab: ContentViewSelection = .home
    
    /// A boolean state indicating whether the purchase card view is shown.
    @State private var show: Bool = false
    
    /// The current drag gesture translation size.
    @State private var dragging: CGSize = .zero
    
    /// The current position offset of the main content view.
    @State private var position: CGSize = .zero
    
    /// The current scale factor of the main content view.
    @State private var scale: CGFloat = 1.0
    
    /// The body of the HomeView which displays the selected tab content wrapped in a scalable and draggable container,
    /// and overlays the side menu with drag gesture support.
    var body: some View {
        ZStack {
            switch selectionTab {
            case .home:
                TabViewContentWrapper(dragging: dragging, position: position, scale: scale) {
                    ContentView(purchaseCard: purchaseCard, show: $show)
                }
            case .purchase:
                TabViewContentWrapper(dragging: dragging, position: position, scale: scale) {
                    PurchaseCardView(purchaseCard: purchaseCard)
                }
            case .favorite:
                TabViewContentWrapper(dragging: dragging, position: position, scale: scale) {
                    Text("Favorite").frame(maxWidth: .infinity, maxHeight: .infinity) .background(.bc)
                }
            case .trash:
                TabViewContentWrapper(dragging: dragging, position: position, scale: scale) {
                    Text("Trash").frame(maxWidth: .infinity, maxHeight: .infinity) .background(.bc)
                }
            }
            
            SideView(selectionTab: $selectionTab)
                .offset(x: -220)
                .offset(x: max(min(dragging.width + position.width, 220), 0))
        }
        .gesture(
            DragGesture()
                .onChanged(openGestureOnChange)
                .onEnded(closeGestureOnEnded)
        )
        .ignoresSafeArea()
        .onChange(of: show) { newValue in
            withAnimation {
                if show { open() } else { close() }
            }
        }.onChange(of: selectionTab) { newValue in
            withAnimation { close() }
        }
    }
    
    /// Handles changes during the drag gesture to update the dragging offset and scale of the main content view.
    ///
    /// - Parameter value: The current value of the drag gesture.
    private func openGestureOnChange(value: DragGesture.Value) {
        withAnimation {
            if position.width == 0 && value.translation.width < 0 {
                dragging = .zero
            } else {
                dragging = value.translation
                let adjustment = position.width == 220 ? 0 : (value.translation.width / 625)
                scale = position.width + value.translation.width >= 220 ? 0.9 : max(1 - adjustment, 0.9)
            }
        }
    }
    
    /// Handles the end of the drag gesture to determine whether to open or close the side menu based on drag distance.
    ///
    /// - Parameter value: The final value of the drag gesture.
    private func closeGestureOnEnded(value: DragGesture.Value) {
        withAnimation {
            if value.translation.width >= 50 {
                position.width += (value.translation.width > 0) ? 220 : -220
            } else {
                position.width = 0
                scale = 1.0
            }
            
            dragging.width = .zero
        }
    }
    
    /// Opens the side menu by setting the dragging and position offsets and scaling down the main content view.
    private func open() {
        dragging.width = 220
        position.width = 220
        scale = 0.9
    }
    
    /// Closes the side menu by resetting the dragging and position offsets and restoring the scale of the main content view.
    private func close() {
        dragging.width = 0
        position.width = 0
        scale = 1
    }
}

#Preview {
    HomeView()
}
