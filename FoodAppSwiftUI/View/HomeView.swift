//
//  HomeView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var purchaseCard = PurchaseCard()
    @State private var selectionTab: ContentViewSelection = .home
    @State private var show: Bool = false
    @State private var dragging: CGSize = .zero
    @State private var position: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    
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
    
    private func open() {
        dragging.width = 220
        position.width = 220
        scale = 0.9
    }
    private func close() {
        dragging.width = 0
        position.width = 0
        scale = 1
    }
}

#Preview {
    HomeView()
}
