//
//  GridView.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

struct GridRowView: View {
    let food: FoodItem
    var namespace: Namespace.ID

    var body: some View {
        VStack {
            Image(food.image)
                .resizable()
                .scaledToFill()
                .frame(width: 90, height: 90)
                .matchedGeometryEffect(id: food.image, in: namespace)

            VStack(alignment: .leading, spacing: 10) {
                Text(food.name)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .frame(height: 40, alignment: .top)
//                    .matchedGeometryEffect(id: food.name, in: namespace)

                HStack {
                    Text(String(format: "%.2f $", food.price)) // e.g. 109.95 $
                        .font(.system(size: 14, weight: .medium, design: .monospaced))
//                        .matchedGeometryEffect(id: food.price, in: namespace)

                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(String(format: "%.2f", food.rating))
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
//                            .matchedGeometryEffect(id: food.rating, in: namespace)

                        PreciseRatingView(rating: food.rating, starSize: 12)
//                            .matchedGeometryEffect(id: "\(food.rating) \(food.id)", in: namespace)

                    }
                }
            }
            .padding(.bottom, 12)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//        .frame(width: 175, height: 195)
        .frame(height: 195)
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

struct GridRowView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        GridRowView(food: FoodItemData.foodsMock[6], namespace: namespace)
    //        .preferredColorScheme(.dark)
    }
}
