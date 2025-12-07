//
//  RoundedCorner.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

//struct RoundedCorner: Shape {
//    var radius: CGFloat = .infinity
//    var corners: UIRectCorner = .allCorners
//
//    func path(in rect: CGRect) -> Path {
//        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        return Path(path.cgPath)
//    }
//}

// UnevenRoundedRectangle() iOS 16+
// Custom RoundedCorner version

// .background(Color(.systemGray5), in: RoundedCorner(radius: 16, corners: [.bottomLeft, .topRight]))
// .background(Color(.systemGray5), in: .rect(cornerRadius: 16))


/*
 ✅ Правильный и рабочий вариант (как делает Apple для .rect())

 Apple делает через InsettableShape.
 Мы сделаем точно так же.

 1. Сначала сделаем RoundedCorner InsettableShape:
 
 struct RoundedCorner: InsettableShape {
     var radius: CGFloat = .infinity
     var corners: UIRectCorner = .allCorners
     var inset: CGFloat = 0

     func inset(by amount: CGFloat) -> some InsettableShape {
         var copy = self
         copy.inset += amount
         return copy
     }

     func path(in rect: CGRect) -> Path {
         let rect = rect.insetBy(dx: inset, dy: inset)
         let path = UIBezierPath(
             roundedRect: rect,
             byRoundingCorners: corners,
             cornerRadii: CGSize(width: radius, height: radius)
         )
         return Path(path.cgPath)
     }
 }
 
 2. Теперь делаем удобный фабричный метод, как .rect(...)

 Расширяем Shape namespace:
 
 extension Shape where Self == RoundedCorner {
     static func roundedCorner(_ radius: CGFloat,
                               corners: UIRectCorner = .allCorners) -> RoundedCorner {
         RoundedCorner(radius: radius, corners: corners)
     }
 }
 
 🎉 Теперь можно использовать точно так же, как .rect:
 .background(.blue, in: .roundedCorner(16))
 .background(.blue, in: .roundedCorner(20, corners: [.topLeft, .bottomRight]))
 ⸻

 🔥 Итог

 Ты получаешь полностью кастомный аналог .rect(cornerRadius:), но поддерживающий НЕравномерные углы, iOS 15+, и работающий внутри .background(_:in:).

 */

// MARK: - RoundedCorner
/// A custom shape that allows rounding specific corners with a given radius.
///
/// `RoundedCorner` behaves similarly to Apple’s `.rect(cornerRadius:)`,
/// but adds support for:
/// - Non-uniform corner selection (`UIRectCorner`)
/// - iOS 15+ compatibility
/// - Rendering inside `.background(_:in:)`
///
/// Conforms to `InsettableShape` to match Apple's internal implementation
/// of shapes used within backgrounds and strokes.
struct RoundedCorner: InsettableShape {
    /// The radius used to round the selected corners.
    var radius: CGFloat = .infinity
    /// The specific corners that should be rounded.
    ///
    /// Uses `UIRectCorner` to enable selective corner rounding.
    var corners: UIRectCorner = .allCorners
    /// The accumulated inset value required for `InsettableShape` conformance.
    ///
    /// Automatically increased when `.inset(by:)` is applied.
    var inset: CGFloat = 0

    /// Returns a copy of the shape inset by the specified amount.
    ///
    /// Required for `InsettableShape`, enabling proper layout when used
    /// inside `.background(_:in:)` and `.strokeBorder(...)`.
    func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.inset += amount
        return copy
    }

    /// Generates the rounded-corner path within the given rectangle.
    ///
    /// The rect is adjusted by the accumulated inset before corners are applied.
    func path(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: inset, dy: inset)
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - RoundedCorner Factory
/// A convenience factory method that mirrors Apple's `.rect(cornerRadius:)`
/// API while supporting custom corner selection.
///
/// - Parameters:
///   - radius: The rounding radius.
///   - corners: The corners to apply rounding to.
/// - Returns: A configured `RoundedCorner` shape.
extension Shape where Self == RoundedCorner {
    static func roundedCorner(_ radius: CGFloat,
                              corners: UIRectCorner = .allCorners) -> RoundedCorner {
        RoundedCorner(radius: radius, corners: corners)
    }
}
