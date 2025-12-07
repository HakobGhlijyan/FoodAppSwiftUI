//
//  OnboardingItem.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import Foundation

// MARK: - OnboardingItem
/// A data model representing a single onboarding screen element.
///
/// Each onboarding item contains a title, descriptive text,
/// and an image name used to visually represent the step.
///
/// Conforms to `Identifiable` for easy use in SwiftUI lists and paging views.
struct OnboardingItem: Identifiable {
    /// A unique identifier for this onboarding item.
    ///
    /// Automatically generated when the item is initialized.
    var id: UUID = UUID()
    /// The title displayed at the top of the onboarding screen.
    var title: String
    /// A descriptive text explaining the feature shown in the onboarding step.
    var details: String
    /// The name of the image asset associated with this onboarding item.
    var imageName: String
}

// MARK: - OnboardingItemData
/// A container providing static onboarding items used throughout the app.
///
/// `onBoardingItems` defines the full sequence of onboarding screens
/// shown when the user first launches the application.
struct OnboardingItemData {
    /// The predefined list of onboarding steps displayed to the user.
    static let onBoardingItems: [OnboardingItem] = [
        OnboardingItem(
            title: "Layout",
            details: "You can easily change the screen display from horizontal to vertical with LazyVGrid.",
            imageName: "part1"
        ),
        OnboardingItem(
            title: "Dark and Light",
            details: "Swiftly switch between dark and light mode.",
            imageName: "part2"
        ),
        OnboardingItem(
            title: "Side Bar",
            details: "With Side Bar. Move between different screens using drag gesture with animation.",
            imageName: "part3"
        )
    ]
}
