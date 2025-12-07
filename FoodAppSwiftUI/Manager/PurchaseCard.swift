//
//  PurchaseCard.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI
import Combine

final class PurchaseCard: ObservableObject {
    @Published var allFoodsInCardByCount: [FoodItem: Int] = [:]
    @Published var totalPrice: Double = 0.0
    @Published var totalCount: Int = 0
    
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
    
    func removeOne(item: FoodItem) {
        guard let count = allFoodsInCardByCount[item] else { return }
        
        if count > 1 {
            allFoodsInCardByCount[item] = count - 1
        } else {
            allFoodsInCardByCount.removeValue(forKey: item)
        }
        
        reCalculateTotals()
    }
    
    func reCalculateTotals() {
        totalCount = allFoodsInCardByCount.values.reduce(0, +)
        totalPrice = allFoodsInCardByCount.reduce(0) { $0 + ($1.key.price * Double($1.value)) }
    }
}
