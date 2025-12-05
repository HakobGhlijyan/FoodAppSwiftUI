//
//  ListRowView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

struct ListRowView: View {
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

            VStack(alignment: .leading, spacing: 12) {
                Text(food.name)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .frame(height: 36)
                    .padding(.trailing, 80)
//                    .matchedGeometryEffect(id: food.name, in: namespace)

                HStack {
                    Text(String(format: "%.2f $", food.price)) // e.g. 109.95 $
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
//                        .matchedGeometryEffect(id: food.price, in: namespace)

                    Spacer()
                    HStack(spacing: 4) {
                        PreciseRatingView(rating: food.rating, starSize: 10)
//                            .matchedGeometryEffect(id: "\(food.rating) \(food.id)", in: namespace)

                        Text(String(format: "%.2f", food.rating))
                            .font(.system(size: 10, weight: .medium, design: .monospaced))
//                            .matchedGeometryEffect(id: food.rating, in: namespace)
                    }
                }
                .padding(.trailing, 40)
            }
        }
        .frame(height: 80)
        .background(.shapec, in: .rect(cornerRadius: 16, style: .continuous))
        .overlay(alignment: .topTrailing) {
            Button {
                
            } label: {
                Image(systemName: "plus")
                    .font(.system(.headline))
                    .padding(10)
                    .background(Color(.systemGray5), in: .roundedCorner(16, corners: [.bottomLeft, .topRight]))
//                    .matchedGeometryEffect(id: "\(food.id)", in: namespace)
            }
            .foregroundStyle(.primary)
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        ListRowView(food: FoodItemData.foodsMock[6], namespace: namespace)
    //        .preferredColorScheme(.dark)
    }
}
