//
//  PurchaseCardView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

// MARK: - PurchaseCardView
/// A view displaying the user's food cart and its contents.
///
/// `PurchaseCardView` observes a `PurchaseCard` object and displays either
/// an empty basket placeholder or a scrollable list of added food items.
///
/// Each row shows the food item, its quantity, and allows further interaction.
///
/// - Properties:
///   - purchaseCard: The observed cart object managing food items and totals.
///
/// Usage:
/// ```swift
/// PurchaseCardView(purchaseCard: purchaseCard)
/// ```
struct PurchaseCardView: View {
    /// The cart manager observed by this view to display food items and totals.
    @ObservedObject var purchaseCard: PurchaseCard
    
    /// The main view hierarchy of the purchase card.
    ///
    /// Displays a title, checks if the cart is empty, and either shows
    /// an empty placeholder or a scrollable list of `PurchaseCardRow` views.
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
