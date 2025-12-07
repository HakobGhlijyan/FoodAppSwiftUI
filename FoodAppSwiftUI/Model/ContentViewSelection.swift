//
//  ContentViewSelection.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/7/25.
//

import SwiftUI

enum ContentViewSelection: CaseIterable {
    case home
    case purchase
    case favorite
    case trash
    
    var title: String {
        switch self {
        case .home: "Home"
        case .purchase: "Purchase"
        case .favorite: "Favorite"
        case .trash: "Trash"
        }
    }

    var icon: String {
        switch self {
        case .home: "house"
        case .purchase: "cart"
        case .favorite: "star"
        case .trash: "trash"
        }
    }
}
