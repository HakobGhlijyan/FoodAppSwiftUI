//
//  FoodItem.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import Foundation

struct FoodItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var price: Double
    var rating: Double
    var image: String
}

struct FoodItemData {
    static let foodsMock: [FoodItem] = [
        FoodItem(name: "Chinese", price: 7.99, rating: 4.60, image: "chinese"),
        FoodItem(name: "French Fries", price: 3.49, rating: 4.50, image: "french_fries"),
        FoodItem(name: "Fried Chicken", price: 8.99, rating: 4.70, image: "fried_chicken"),
        FoodItem(name: "Fry", price: 2.99, rating: 4.30, image: "fry"),
        FoodItem(name: "Hamburger", price: 5.99, rating: 4.80, image: "hamburger"),
        FoodItem(name: "Hot Dog", price: 4.29, rating: 4.40, image: "hot_dog"),
        FoodItem(name: "McDonalds French Fries", price: 3.99, rating: 4.70, image: "mcdonalds_french_fries"),
        FoodItem(name: "Nachos", price: 6.49, rating: 4.56, image: "nachos"),
        FoodItem(name: "Pizza Five Eighths", price: 9.99, rating: 4.60, image: "pizza_five_eighths"),
        FoodItem(name: "Pizza", price: 8.49, rating: 4.66, image: "pizza"),
        FoodItem(name: "Plastic Food Container", price: 1.99, rating: 4.20, image: "plastic_food_container"),
        FoodItem(name: "Popcorn", price: 2.49, rating: 4.47, image: "popcorn"),
        FoodItem(name: "Quesadilla", price: 6.99, rating: 4.60, image: "quesadilla"),
        FoodItem(name: "Refreshments", price: 1.49, rating: 4.18, image: "refreshments"),
        FoodItem(name: "Sandwich", price: 4.99, rating: 4.65, image: "sandwich"),
        FoodItem(name: "Street Food", price: 7.49, rating: 4.74, image: "street_food"),
        FoodItem(name: "Taco", price: 3.99, rating: 4.64, image: "taco"),
        FoodItem(name: "Take Away Food", price: 5.49, rating: 4.34, image: "take_away_food"),
        FoodItem(name: "Wrap", price: 4.79, rating: 4.54, image: "wrap")
    ]
}
