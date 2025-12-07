//
//  SideViewButton.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/7/25.
//

import SwiftUI

// MARK: - SideViewButton
/// A reusable button view intended for side menus or navigation drawers.
///
/// `SideViewButton` combines an SF Symbol icon and a text label,
/// providing a tappable area with adaptive colors for light and dark mode.
///
/// - Properties:
///   - title: The text displayed on the button.
///   - icon: The SF Symbol name used as the button's icon.
///   - action: Closure executed when the button is tapped.
///   - colorScheme: Automatically adapts the icon color based on light/dark mode.
struct SideViewButton: View {
    /// The text displayed on the button.
    var title: String
    /// The SF Symbol name used as the button's icon.
    var icon: String
    /// The closure executed when the button is tapped.
    var action: () -> Void
    /// The current system color scheme used to adjust icon colors dynamically.
    @Environment(\.colorScheme) private var colorScheme
    
    /// The view hierarchy for the button.
    ///
    /// Displays an HStack with the icon and title, applies padding,
    /// frame constraints, and a rounded rectangle stroke for styling.
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(.gray)
            }
            .font(.system(size: 20))
            .padding(.leading, 10)
            .frame(width: 200, height: 50, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .padding(.leading, 30)
    }
}

#Preview {
    SideViewButton(title: "apple", icon: "applelogo", action: {
        
    })
}
