//
//  ListRowView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

struct ListRowView: View {
    @ObservedObject var purchaseCard: PurchaseCard
    let food: FoodItem
    var namespace: Namespace.ID

    var body: some View {
        HStack {
            Image(food.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .padding(.leading, 10)
                .matchedGeometryEffect(id: food.image, in: namespace)

            VStack(alignment: .leading, spacing: 10) {
                Text(food.name)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .padding(.trailing, 80)

                HStack {
                    Text(String(format: "%.2f $", food.price)) // e.g. 109.95 $
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                    Spacer()
                    HStack(spacing: 4) {
                        PreciseRatingView(rating: food.rating, starSize: 10)
                        Text(String(format: "%.2f", food.rating))
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
                    }
                }
                .padding(.trailing, 40)
            }
        }
        .frame(height: 80)
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

struct ListRowView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ListRowView(purchaseCard: PurchaseCard(), food: FoodItemData.foodsMock[6], namespace: namespace)
            .preferredColorScheme(.dark)
    }
}
