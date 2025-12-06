//
//  HomeView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var purchaseCard = PurchaseCard()
    @State private var show: Bool = false
    @State private var dragging: CGSize = .zero
    @State private var position: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            ContentView(purchaseCard: purchaseCard)
                .mask { RoundedRectangle(cornerRadius: min(dragging.width + position.width / 5, 50), style: .continuous)}
                .scaleEffect(scale)
                .offset(x: max(min(dragging.width + position.width, 220), 0))
                .gesture(
                    DragGesture()
                        .onChanged(openGestureOnChange)
                        .onEnded(closeGestureOnEnded)
                )
        }
        .ignoresSafeArea()
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
}

#Preview {
    HomeView()
}

//35.35
