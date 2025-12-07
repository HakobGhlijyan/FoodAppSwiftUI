//
//  OnBoardingView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

// MARK: - OnBoardingView
/// A view that displays the onboarding sequence for the application.
///
/// `OnBoardingView` iterates over predefined `OnboardingItem` data and shows
/// one screen at a time using `DetailView`. Users can navigate through the
/// sequence using a universal "Next" button with gradient animation.
///
/// - Properties:
///   - onBoardingItems: The array of onboarding items to display.
///   - currentIndex: A binding to track the current step in the onboarding flow.
///
/// Usage:
/// ```swift
/// OnBoardingView(currentIndex: $currentIndex)
/// ```
struct OnBoardingView: View {
    /// The list of onboarding items retrieved from `OnboardingItemData`.
    let onBoardingItems = OnboardingItemData.onBoardingItems
    
    /// The current step index in the onboarding flow.
    ///
    /// Determines which `DetailView` is currently visible.
    @Binding var currentIndex: Int
    
    /// The main view hierarchy of the onboarding view.
    ///
    /// Displays the current onboarding step in a ZStack and overlays a
    /// `GlowGradientButtonUniversal` for navigation.
    var body: some View {
        ZStack {
            ForEach(0..<onBoardingItems.count, id: \.self) { index in
                if index == currentIndex {
                    DetailView(
                        data: onBoardingItems[index],
                        items: onBoardingItems.count,
                        currentIndex: currentIndex,
                        imageName: onBoardingItems[index].imageName
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
            
            GlowGradientButtonUniversal(title: "Next") {
                withAnimation(.smooth(duration: 0.6)) {
                    if currentIndex < 3 {
                        currentIndex += 1
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    OnBoardingView(currentIndex: .constant(0))
//    OnBoardingView(currentIndex: .constant(1))
//    OnBoardingView(currentIndex: .constant(2))
//        .preferredColorScheme(.dark)
}
