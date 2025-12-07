//
//  DetailView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

struct DetailView: View {
    var data: OnboardingItem
    var items: Int
    var currentIndex: Int
    var imageName: String

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
