//
//  View+EXT.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

extension View {
    @ViewBuilder func embedNavigation() -> some View {
        if #available(iOS 16, *) {
            NavigationStack { self }
        } else {
            NavigationView { self }
        }
    }
}
