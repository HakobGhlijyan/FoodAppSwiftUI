//
//  OnBoardingView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

struct OnBoardingView: View {
    var onBoardingItems: [OnboardingItem] = [
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
        ),
    ]
    
    @Binding var currentIndex: Int
    
    var body: some View {
        ZStack {
            ForEach(0..<onBoardingItems.count, id: \.self) { index in
                if index == currentIndex {
                    DetailView(
                        data: onBoardingItems[index],
                        items: onBoardingItems.count,
                        currentIndex: currentIndex,
                        imageName: onBoardingItems[index].imageName
                    )
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
            
            GlowGradientButton(title: "Next") {
                withAnimation(.smooth(duration: 0.6)) {
                    if currentIndex < 3 {
                        currentIndex += 1
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    OnBoardingView(currentIndex: .constant(0))
        .preferredColorScheme(.dark)
}

struct OnboardingItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    var details: String
    var imageName: String
}

struct DetailView: View {
    var data: OnboardingItem
    var items: Int
    var currentIndex: Int
    var imageName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("\(currentIndex + 1) of \(items)").font(.title3).bold().foregroundStyle(.primary)
            Text(data.title).font(.system(size: 40)).bold().foregroundStyle(.primary)
            Text(data.details).font(.title3).foregroundStyle(.secondary)
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 40)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
