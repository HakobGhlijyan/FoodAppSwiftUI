//
//  PurchaseCard.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI
import Combine

// MARK: - PurchaseCard
/// A central cart manager responsible for storing selected food items,
/// tracking their quantities, and calculating the total price and item count.
///
/// `PurchaseCard` is used as a shared state container (ObservableObject)
/// to synchronize cart updates across the UI.
final class PurchaseCard: ObservableObject {
    // MARK: - Published Properties
    /// Stores each unique `FoodItem` along with its quantity in the cart.
    ///
    /// The dictionary key is the food item itself, while the value represents
    /// how many times it was added.
    @Published var allFoodsInCardByCount: [FoodItem: Int] = [:]
    
    /// The total price of all items in the cart after recalculation.
    @Published var totalPrice: Double = 0.0
    
    /// The total quantity of all food items combined.
    @Published var totalCount: Int = 0
    
    // MARK: - Add Item
    /// Adds a food item to the cart.
    ///
    /// - Parameter item: The `FoodItem` to be added.
    ///
    /// If the item already exists, its quantity increases by 1.
    /// Otherwise, the item is inserted with an initial quantity of 1.
    /// After the update, totals are recalculated.
    func appendInCard(item: FoodItem) {
        // Если товар уже есть → увеличиваем на 1
        if let count = allFoodsInCardByCount[item] {
            allFoodsInCardByCount[item] = count + 1
        } else {
            // Если нет → добавляем
            allFoodsInCardByCount[item] = 1
        }
        
        reCalculateTotals()
    }
    
    // MARK: - Remove One Item
    /// Removes one unit of the specified item from the cart.
    ///
    /// - Parameter item: The `FoodItem` to be decreased or removed.
    ///
    /// If the item's quantity becomes zero, it is removed entirely.
    /// Totals are recalculated automatically.
    func removeOne(item: FoodItem) {
        guard let count = allFoodsInCardByCount[item] else { return }
        
        if count > 1 {
            allFoodsInCardByCount[item] = count - 1
        } else {
            allFoodsInCardByCount.removeValue(forKey: item)
        }
        
        reCalculateTotals()
    }
    
    // MARK: - Totals Calculation
    /// Recalculates the total price and item count for the entire cart.
    ///
    /// This method aggregates all quantities and multiplies each item’s price
    /// by its respective quantity to compute the final total.
    func reCalculateTotals() {
        totalCount = allFoodsInCardByCount.values.reduce(0, +)
        totalPrice = allFoodsInCardByCount.reduce(0) { $0 + ($1.key.price * Double($1.value)) }
    }
}
