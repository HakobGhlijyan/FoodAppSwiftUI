//
//  SideView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/7/25.
//

import SwiftUI

struct SideView: View {
    @AppStorage("darkMode") var darkMode: Bool = false
    @Binding var selectionTab: ContentViewSelection

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
