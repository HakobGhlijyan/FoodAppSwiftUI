//
//  ContentView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

// MARK: - RootView
/// The root entry view of the application.
///
/// `RootView` manages the display of the onboarding sequence (`OnBoardingView`)
/// or the main home interface (`HomeView`) depending on the current onboarding index.
///
/// - Properties:
///   - currentIndex: Tracks the current step in the onboarding flow.
///
/// Usage:
/// ```swift
/// RootView()
/// ```
struct RootView: View {
    /// The current step index in the onboarding flow.
    ///
    /// Determines whether to show `OnBoardingView` or `HomeView`.
    @State private var currentIndex: Int = 0
    
    /// The main view hierarchy.
    ///
    /// Displays `OnBoardingView` for indices 0...2 and transitions to `HomeView` when complete.
    /// Uses asymmetric move transitions for insertion and removal.
    var body: some View {
        Group {
            if currentIndex < 3 {
                OnBoardingView(currentIndex: $currentIndex)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            } else {
                HomeView()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
    }
} 

#Preview {
    RootView()
}
