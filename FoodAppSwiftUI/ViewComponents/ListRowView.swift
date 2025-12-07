//
//  ListRowView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

// MARK: - ListRowView
/// A single row view representing a food item in a scrollable list.
///
/// `ListRowView` displays the food image, name, price, rating, and a '+' button
/// to add the item to the purchase cart.
///
/// - Properties:
///   - purchaseCard: The shared cart manager (`PurchaseCard`) for adding items.
///   - food: The `FoodItem` to display.
///   - namespace: A `Namespace.ID` for matched geometry animations.
///
/// - Usage:
/// ```swift
/// ListRowView(purchaseCard: purchaseCard, food: foodItem, namespace: namespace)
/// ```
import SwiftUI

struct ListRowView: View {
    /// The cart manager used to add items when the '+' button is tapped.
    @ObservedObject var purchaseCard: PurchaseCard
    /// The food item displayed in this row.
    let food: FoodItem
    /// The namespace used for matched geometry animations.
    var namespace: Namespace.ID

    /// The view hierarchy for the list row.
    ///
    /// Displays:
    /// - Food image with matched geometry animation
    /// - Food name, price, and precise rating
    /// - '+' button overlay to add item to the cart
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
