//
//  GlowGradientButton.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/4/25.
//

import SwiftUI

// MARK: - GlowGradientButton
/// A customizable button with a glowing, animated gradient border.
///
/// `GlowGradientButton` displays a title and provides a tappable area
/// with interactive scaling on press and continuous angular gradient animation.
///
/// - Properties:
///   - title: The text displayed on the button.
///   - action: Closure executed when the button is tapped.
///   - gradientColor: The animated gradient colors used for the border.
///   - isAnimation: Tracks the animation state for the gradient rotation.
///   - isPressed: Tracks whether the button is currently pressed for scale effect.
///
/// Usage:
/// ```swift
/// GlowGradientButton(title: "Next") {
///     print("Button tapped")
/// }
/// ```
struct GlowGradientButton: View {
    /// The text displayed on the button.
    var title: String
    /// Closure executed when the button is tapped.
    var action: () -> Void
    
    /// The animated gradient used for the glowing border.
    private let gradientColor: Gradient = Gradient(colors: [.red, .yellow, .blue, .green, .purple, .pink, .red])
    /// Tracks whether the gradient animation is active.
    @State private var isAnimation: Bool = false
    /// Tracks the press state for scaling effect.
    @State private var isPressed: Bool = false
    
    // MARK: - Body
    /// The main view hierarchy of the button, including the glowing gradient,
    /// background, title text, overlay strokes, and animations.
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
    
    // MARK: - Gesture Handling
    /// Handles tap and drag gestures to provide scaling feedback
    /// and trigger the `action` closure when the press ends.
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
    VStack(spacing: 100) {
        GlowGradientButton(title: "Next", action: {
            print("Next \(Date())")
        })
        GlowGradientButtonUniversal(title: "Next", action: {
            print("Next \(Date())")
        })
    }
//    .preferredColorScheme(.dark)
}

struct GlowGradientButtonUniversal: View {
    /// The text displayed on the button.
    var title: String
    /// Closure executed when the button is tapped.
    var action: () -> Void
    
    /// The animated gradient used for the glowing border.
    private let gradientColor: Gradient = Gradient(colors: [.red, .yellow, .blue, .green, .purple, .pink, .red])
    /// Tracks whether the gradient animation is active.
    @State private var isAnimation: Bool = false
    /// Tracks the press state for scaling effect.
    @State private var isPressed: Bool = false
    /// Detect current color scheme
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Glow background
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(AngularGradient(gradient: gradientColor, center: .center, angle: .degrees(isAnimation ? 360 : 0)), lineWidth: 14)
                .blur(radius: 30)
                .offset(y: 30)
                .frame(width: 230, height: 30)
            
            Text(title)
                .font(.system(size: 24))
                .fontWeight(.medium)
                .frame(width: 280, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(colorScheme == .dark ? .appButton : Color.white)
                )
                .foregroundStyle(colorScheme == .dark ? .white : .black)
                .overlay {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(AngularGradient(gradient: gradientColor, center: .center, angle: .degrees(isAnimation ? 360 : 0)), lineWidth: 3)
                        .overlay {
                            let color: Color = colorScheme == .dark ? .black : .white
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(lineWidth: 4)
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [color, color, .clear]), startPoint: .top, endPoint: .bottom))
                                .shadow(radius: 60)
                        }
                }
        }
        .onAppear { withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) { isAnimation = true } }
        .onDisappear { isAnimation = false }
        .scaleEffect(isPressed ? 0.95 : 1)
        .animation(.easeInOut(duration: 0.2), value: isPressed)
        .simultaneousGesture(gesture)
    }
    
    // MARK: - Gesture Handling
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
