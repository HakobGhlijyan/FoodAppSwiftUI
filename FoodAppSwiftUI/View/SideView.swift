//
//  SideView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/7/25.
//

import SwiftUI

// MARK: - SideView
/// A side menu view containing navigation buttons and a dark mode toggle.
///
/// `SideView` provides navigation between main tabs using `SideViewButton`
/// and allows the user to toggle between light and dark themes.
///
/// - Properties:
///   - darkMode: A boolean stored in AppStorage that controls system theme.
///   - selectionTab: A binding to the currently selected main tab.
///
/// Usage:
/// ```swift
/// SideView(selectionTab: $currentTab)
/// ```
struct SideView: View {
    /// Tracks whether dark mode is enabled and persists the value using AppStorage.
    @AppStorage("darkMode") var darkMode: Bool = false

    /// A binding to the currently selected tab in the main content view.
    @Binding var selectionTab: ContentViewSelection

    /// The view hierarchy for the side menu.
    ///
    /// Displays a vertical stack of navigation buttons for each tab and a toggle
    /// for dark mode at the bottom. Buttons update the `selectionTab` binding
    /// when tapped. The overall width is constrained to 200 points.
    var body: some View {
        VStack {
            Spacer()
            SideViewButton(title: ContentViewSelection.home.title, icon: ContentViewSelection.home.icon, action: {
                selectionTab = .home
            })
            SideViewButton(title: ContentViewSelection.purchase.title, icon: ContentViewSelection.purchase.icon, action: {
                selectionTab = .purchase
            })
            SideViewButton(title: ContentViewSelection.favorite.title, icon: ContentViewSelection.favorite.icon, action: {
                selectionTab = .favorite
            })
            SideViewButton(title: ContentViewSelection.trash.title, icon: ContentViewSelection.trash.icon, action: {
                selectionTab = .trash
            })
            Spacer()
            Toggle(isOn: $darkMode) {
                Text("Dark")
                    .foregroundStyle(.gray)
            }
            .padding(.leading, 30)
            Spacer()
        }
        .frame(width: 200)
        .frame(maxWidth: .infinity, alignment: .leading)
        .preferredColorScheme(darkMode ? .dark : .light)
    }
}

#Preview {
    SideView(selectionTab: .constant(ContentViewSelection.home))
}
