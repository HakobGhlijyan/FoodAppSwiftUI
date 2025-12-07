//
//  GlowGradientButton.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

struct GlowGradientButton: View {
    var title: String
    var action: () -> Void
    
    private let gradientColor: Gradient = Gradient(colors: [.red, .yellow, .blue, .green, .purple, .pink, .red])
    @State private var isAnimation: Bool = false
    @State private var isPressed: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(AngularGradient(gradient: gradientColor, center: .center, angle: .degrees(isAnimation ? 360 : 0)), lineWidth: 14)
                .blur(radius: 30)
                .offset(y: 30)
                .frame(width: 230, height: 30)
            
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.medium)
                .frame(width: 280, height: 50)
                .background(.appButton, in: .rect(cornerRadius: 20))
                .foregroundStyle(.white)
                .overlay {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(AngularGradient( gradient: gradientColor, center: .center, angle: .degrees(isAnimation ? 360 : 0)), lineWidth: 3)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(lineWidth: 4)
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
                        }
                }
        }
        .onAppear { withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) { isAnimation = true } }
        .onDisappear { isAnimation = false  }
        .scaleEffect(isPressed ? 0.95 : 1)
        .animation(.easeInOut(duration: 0.2), value: isPressed)
        .simultaneousGesture(gesture)
    }
    
    private var gesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in isPressed = true }
            .onEnded { _ in
                isPressed = false
                withAnimation {
                    action()
                }
            }
    }
}

#Preview {
    GlowGradientButton(title: "Next", action: {
        print("Next \(Date())")
    })
//    .preferredColorScheme(.dark)
}
