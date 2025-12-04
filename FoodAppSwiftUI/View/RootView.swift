//
//  ContentView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

struct RootView: View {
    @State private var currentIndex: Int = 0
    
    var body: some View {
        Group {
            if currentIndex < 3 {
                OnBoardingView(currentIndex: $currentIndex)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else {
                HomeView()
            }
        }
    }
}

#Preview {
    RootView()
        .preferredColorScheme(.dark)
}
