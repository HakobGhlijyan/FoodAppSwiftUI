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

extension Shape where Self == RoundedCorner {
    static func roundedCorner(_ radius: CGFloat,
                              corners: UIRectCorner = .allCorners) -> RoundedCorner {
        RoundedCorner(radius: radius, corners: corners)
    }
}
