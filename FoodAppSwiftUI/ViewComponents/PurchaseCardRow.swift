//
//  PurchaseCardRow.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

// MARK: - PurchaseCardRow
/// A row view representing a single food item in the purchase/cart list.
///
/// `PurchaseCardRow` displays the food image, name, price, rating, and quantity.
/// It is used inside a list or scroll view of the cart to show each added item.
///
/// - Properties:
///   - food: The `FoodItem` model to display.
///   - count: The quantity of this food item in the cart.
struct PurchaseCardRow: View {
    /// The food item displayed in this row.
    let food: FoodItem
    /// The number of this item in the cart.
    var count: Int
    
    /// The view hierarchy for the cart row.
    ///
    /// Displays:
    /// - Food image with fixed size
    /// - Food name with truncation and styling
    /// - Price and rating (with stars)
    /// - Quantity overlay in top trailing corner
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
        .background(.shapec, in: .rect(cornerRadius: 20, style: .continuous))
        .overlay(alignment: .topTrailing) {
            Text("Count: \(count)")
                .font(.system(size: 12, weight: .medium, design: .monospaced))
                .foregroundStyle(.primary)
                .padding(8)
                .padding(.horizontal, 2)
                .background(Color(.systemGray4), in: .roundedCorner(16, corners: [.bottomLeft, .topRight]))
        }
    }
}

struct PurchaseCardRow_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseCardRow(food: FoodItemData.foodsMock[6], count: 2)
            .preferredColorScheme(.dark)
    }
}
