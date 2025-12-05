//
//  RatingViewAnimation.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/5/25.
//

import SwiftUI

#Preview {
//    RatingViewAnimation()
    PreciseRatingView(rating: 2.5)
//    VStack {
//        RatingView(
//            maxRating: 5,
//            rating: .constant(3.5)
//        )
//        RatingView(
//            maxRating: 10,
//            rating: .constant(8),
//            starColor: .yellow,
//            starRounding: .ceilToHalfStar,
//            size: 30
//        )
//        RatingView(
//            maxRating: 3,
//            rating: .constant(2),
//            starColor: .green,
//            starRounding: .roundToFullStar,
//            size: 50
//        )
//    }
}

//1
struct RatingViewAnimation: View {
    @State private var rating: Int = 0
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .font(.largeTitle)
                    .foregroundStyle(index <= rating ? .yellow : Color(.systemGray4))
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}

//2
struct PreciseRatingView: View {
//    @State private var rating: Double = 3.4 // начальное значение
    var rating: Double                        // начальное значение
    let maxRating = 5
    var starSize: CGFloat = 10

    var body: some View {
        ZStack {
            // Серые пустые звезды
            HStack(spacing: 0) {
                ForEach(0..<maxRating, id: \.self) { _ in
                    Image(systemName: "star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(.gray.opacity(0.3))
                }
            }

            // Жёлтая маска со звёздами
            HStack(spacing: 0) {
                ForEach(0..<maxRating, id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(.yellow)
                }
            }
            .mask(
                GeometryReader { geo in
                    let width = geo.size.width * CGFloat(rating / Double(maxRating))
                    Rectangle().frame(width: width)
                }
            )
        }
//        .gesture(
//            DragGesture(minimumDistance: 0)
//                .onChanged { value in
//                    updateRating(from: value.location.x)
//                }
//                .onEnded { value in
//                    updateRating(from: value.location.x)
//                }
//        )
    }

    // обновление рейтинга по позиции
//    private func updateRating(from x: CGFloat) {
//        let totalWidth = starSize * CGFloat(maxRating)
//        let clampedX = min(max(x, 0), totalWidth)
//
//        let rawRating = Double(clampedX / totalWidth) * Double(maxRating)
//
//        rating = (rawRating * 100).rounded() / 100   // округляем до 0.01
//    }
}

//3
enum StarRounding: Int {
    case roundToHalfStar = 0
    case ceilToHalfStar = 1
    case floorToHalfStar = 2
    case roundToFullStar = 3
    case ceilToFullStar = 4
    case floorToFullStar = 5
}

struct StarView: View {
    let isFilled: Bool
    let color: Color
    
    private let fullStarImage: Image = Image(systemName: "star.fill")
    private let halfStarImage: Image = Image(systemName: "star.lefthalf.fill")
    private let emptyStarImage: Image = Image(systemName: "star")
    
    var body: some View {
        isFilled ? fullStarImage : emptyStarImage
    }
}

struct RatingView: View {
    let maxRating: Int
    let rating: Binding<Double>
    let starColor: Color
    let starRounding: StarRounding
    let size: CGFloat
    
    private let fullStarImage: Image = Image(systemName: "star.fill")
    private let halfStarImage: Image = Image(systemName: "star.lefthalf.fill")
    private let emptyStarImage: Image = Image(systemName: "star")
    
    @State private var selectedStar: Int?
    
    init(maxRating: Int, rating: Binding<Double>, starColor: Color = .blue, starRounding: StarRounding = .floorToFullStar, size: CGFloat = 20) {
        self.maxRating = maxRating
        self.rating = rating
        self.starColor = starColor
        self.starRounding = starRounding
        self.size = size
    }
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { index in
                starImageView(index: index)
                    .foregroundColor(starColor)
                    .onTapGesture {
                        rating.wrappedValue = Double(index)
                        withAnimation(.easeInOut(duration: 0.5)) {
                            selectedStar = index
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            selectedStar = nil
                        }
                    }
            }
        }
    }
    
    func starImageView(index: Int) -> some View {
        let iFloat = Double(index)
        let image: Image
        switch starRounding {
        case .roundToHalfStar:
            image = rating.wrappedValue >= iFloat-0.25 ? fullStarImage :
                   (rating.wrappedValue >= iFloat-0.75 ? halfStarImage : emptyStarImage)
        case .ceilToHalfStar:
            image = rating.wrappedValue > iFloat-0.5 ? fullStarImage :
                   (rating.wrappedValue > iFloat-1 ? halfStarImage : emptyStarImage)
        case .floorToHalfStar:
            image = rating.wrappedValue >= iFloat ? fullStarImage :
                   (rating.wrappedValue >= iFloat-0.5 ? halfStarImage : emptyStarImage)
        case .roundToFullStar:
            image = rating.wrappedValue >= iFloat-0.5 ? fullStarImage : emptyStarImage
        case .ceilToFullStar:
            image = rating.wrappedValue > iFloat-1 ? fullStarImage : emptyStarImage
        case .floorToFullStar:
            image = rating.wrappedValue >= iFloat ? fullStarImage : emptyStarImage
        }
        return image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .overlay(
                selectedStar == index ? Circle()
                    .strokeBorder(starColor, lineWidth: 4)
                    .scaleEffect(1.5)
                    .opacity(0)
                    .animation(Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: false), value: 1) : nil
            )
    }
}
