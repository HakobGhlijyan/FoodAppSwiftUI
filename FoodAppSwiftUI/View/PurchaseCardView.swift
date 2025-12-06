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
            Group {
                if purchaseCard.allFoodsInCard.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "takeoutbag.and.cup.and.straw")
                            .font(.system(size: 80))
                        Text("Your basket is empty")
                            .font(.title2)
                        Text("Tap the + button add food to your basket")
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                } else {
                    ScrollView {
                        VStack {
                            ForEach(purchaseCard.allFoodsInCard) { food in
                                PurchaseCardRow(food: food)
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
