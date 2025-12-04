//
//  OnboardingItem.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import Foundation

struct OnboardingItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    var details: String
    var imageName: String
}

struct OnboardingItemData {
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
