//
//  GridView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

struct GridRowView: View {
    @ObservedObject var purchaseCard: PurchaseCard
    let food: FoodItem
    var namespace: Namespace.ID

    var body: some View {
        VStack {
            Image(food.image)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .matchedGeometryEffect(id: food.image, in: namespace)

            VStack(alignment: .leading, spacing: 0) {
                Text(food.name)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)

                HStack {
                    Text(String(format: "%.2f $", food.price)) // e.g. 109.95 $
                        .font(.system(size: 14, weight: .medium, design: .monospaced))

                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(String(format: "%.2f", food.rating))
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                        PreciseRatingView(rating: food.rating, starSize: 12)
                    }
                }
            }
            .padding(.bottom, 12)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .frame(height: 195)
        .background(.shapec, in: .rect(cornerRadius: 16, style: .continuous))
        .overlay(alignment: .topTrailing) {
            Button {
                purchaseCard.appendInCard(item: food)
            } label: {
                Image(systemName: "plus")
                    .font(.system(.headline))
                    .padding(10)
                    .background(Color(.systemGray4), in: .roundedCorner(16, corners: [.bottomLeft, .topRight]))
            }
            .foregroundStyle(.primary)
        }
    }
}

struct GridRowView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        GridRowView(purchaseCard: PurchaseCard(), food: FoodItemData.foodsMock[6], namespace: namespace)
            .preferredColorScheme(.dark)
    }
}
