//
//  PurchaseCardView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

struct PurchaseCardView: View {
    @ObservedObject var purchaseCard: PurchaseCard
    
    var body: some View {
        VStack {
            Text("Food Orders")
                .font(.largeTitle).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
                .padding(.top, 20)
                .topPaddingForDevice()
            Group {
                if purchaseCard.allFoodsInCardByCount.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "takeoutbag.and.cup.and.straw")
                            .font(.system(size: 80))
                        Text("Your basket is empty")
                            .font(.title2)
                        Text("Tap the + button add food to your basket")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack {
                            ForEach(Array(purchaseCard.allFoodsInCardByCount), id: \.key) { (food, count) in
                                PurchaseCardRow(food: food, count: count)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .background(.bc)
    }
}

#Preview {
    PurchaseCardView(purchaseCard: PurchaseCard())
}
