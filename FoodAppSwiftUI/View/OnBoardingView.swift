//
//  OnBoardingView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

struct OnBoardingView: View {
    let onBoardingItems = OnboardingItemData.onBoardingItems
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
//    OnBoardingView(currentIndex: .constant(1))
//    OnBoardingView(currentIndex: .constant(2))
//        .preferredColorScheme(.dark)
}
