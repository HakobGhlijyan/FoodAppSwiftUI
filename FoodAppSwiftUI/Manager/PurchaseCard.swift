//
//  PurchaseCard.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI
import Combine

final class PurchaseCard: ObservableObject {
    @Published var allFoodsInCard: [FoodItem] = []
}
