//
//  ContentViewSelection.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/7/25.
//

import SwiftUI

// MARK: - ContentViewSelection
/// Represents the available root-level navigation tabs in the application.
///
/// `ContentViewSelection` is used to control which main view is visible on screen.
/// Each case corresponds to a tab in the bottom navigation bar and provides
/// a title and an SF Symbol icon for UI rendering.
enum ContentViewSelection: CaseIterable {
    case home
    case purchase
    case favorite
    case trash
    
    // MARK: - Title
    /// A human‑readable title associated with each tab.
    ///
    /// Used primarily for labeling UI components and accessibility.
    var title: String {
        switch self {
        case .home: "Home"
        case .purchase: "Purchase"
        case .favorite: "Favorite"
        case .trash: "Trash"
        }
    }

    // MARK: - Icon
    /// The SF Symbol name corresponding to each tab.
    ///
    /// These icons are used in the bottom tab bar and other UI elements.
    var icon: String {
        switch self {
        case .home: "house"
        case .purchase: "cart"
        case .favorite: "star"
        case .trash: "trash"
        }
    }
}
