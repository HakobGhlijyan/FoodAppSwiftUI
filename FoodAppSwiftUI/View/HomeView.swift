//
//  HomeView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var purchaseCard = PurchaseCard()
    
    var body: some View {
        ZStack {
            ContentView(purchaseCard: purchaseCard)

//            PurchaseCardView(purchaseCard: purchaseCard)
        }
    }
}

#Preview {
    HomeView()
}
