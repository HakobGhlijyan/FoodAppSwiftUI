//
//  DetailView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

// MARK: - DetailView
/// A view representing a single onboarding step detail screen.
///
/// `DetailView` displays the step index, title, description, and an associated image.
/// It is used inside `OnBoardingView` to show each onboarding page.
///
/// - Properties:
///   - data: The `OnboardingItem` containing title and details for this step.
///   - items: The total number of onboarding steps.
///   - currentIndex: The index of the current onboarding step.
///   - imageName: The name of the image asset to display.
///
/// Usage:
/// ```swift
/// DetailView(
///     data: onboardingItem,
///     items: onboardingItems.count,
///     currentIndex: index,
///     imageName: onboardingItem.imageName
/// )
/// ```
struct DetailView: View {
    /// The onboarding item containing title and details for this step.
    var data: OnboardingItem
    /// The total number of onboarding steps.
    var items: Int
    /// The index of the current onboarding step.
    var currentIndex: Int
    /// The name of the image asset to display for this step.
    var imageName: String

    /// The view hierarchy for the onboarding detail screen.
    ///
    /// Displays the step number, title, description, and the associated image with proper layout and padding.
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 20) {
                Text("\(currentIndex + 1) of \(items)").font(.title3).bold().foregroundStyle(.primary)
                Text(data.title).font(.system(size: 40)).bold().foregroundStyle(.primary)
                Text(data.details).font(.title3).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 60)
                .padding(.top, 40)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    DetailView(
        data: OnboardingItemData.onBoardingItems[0],
        items: OnboardingItemData.onBoardingItems.count,
        currentIndex: 0,
        imageName: OnboardingItemData.onBoardingItems[0].imageName
    )
//    .preferredColorScheme(.dark)
}
