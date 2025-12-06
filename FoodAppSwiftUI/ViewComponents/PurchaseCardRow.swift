//
//  PurchaseCardRow.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

struct PurchaseCardRow: View {
    let food: FoodItem
    
    var body: some View {
        HStack {
            Image(food.image)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .padding(.leading, 10)
            
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
                .padding(.trailing, 10)
            }
        }
        .frame(height: 70)
        .background(.shapec, in: .rect(cornerRadius: 16, style: .continuous))
    }
}

struct PurchaseCardRow_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseCardRow(food: FoodItemData.foodsMock[6])
//            .preferredColorScheme(.dark)
    }
}
