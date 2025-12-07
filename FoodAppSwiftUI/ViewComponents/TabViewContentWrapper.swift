//
//  TabViewContentWrapper.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/7/25.
//

import SwiftUI

// MARK: - TabViewContentWrapper
/// A wrapper view that applies interactive transformations (masking, scaling,
/// and horizontal offset) to its content, typically used for draggable tab transitions.
///
/// `TabViewContentWrapper` allows tabs or full‑screen views to visually shrink,
/// round their corners, and slide horizontally during user interaction.
///
/// - Parameters:
///   - dragging: The live drag translation from a gesture.
///   - position: The accumulated offset after completed gestures.
///   - scale: A scale factor applied to the content during interactions.
///   - content: The underlying view being visually transformed.
struct TabViewContentWrapper<Content: View>: View {
    /// Current drag translation provided by a gesture recognizer.
    ///
    /// Used to calculate the dynamic offset and corner radius during interaction.
    var dragging: CGSize
    
    /// The accumulated horizontal position of the view after drag completions.
    ///
    /// Represents the "resting" position of the wrapper.
    var position: CGSize
    
    /// The scale factor applied to the content.
    ///
    /// Values less than `1.0` visually shrink the view during a drag gesture.
    var scale: CGFloat
    
    /// The wrapped view whose appearance is modified by the transformation logic.
    var content: Content

    /// Creates a new `TabViewContentWrapper` with interactive transformation inputs.
    ///
    /// - Parameters:
    ///   - dragging: The current drag offset.
    ///   - position: The accumulated offset.
    ///   - scale: The scale effect to apply.
    ///   - content: A view builder producing the wrapped content.
    init(dragging: CGSize, position: CGSize, scale: CGFloat, @ViewBuilder content: () -> Content) {
        self.dragging = dragging
        self.position = position
        self.scale = scale
        self.content = content()
    }
    
    /// The transformed content view.
    ///
    /// Applies:
    /// - A dynamic rounded‑rectangle mask based on drag distance
    /// - A scaling transformation
    /// - A horizontal sliding offset with clamping to prevent overshoot
    var body: some View {
        content
            .mask { RoundedRectangle(cornerRadius: min(dragging.width + position.width / 5, 50), style: .continuous) }
            .scaleEffect(scale)
            .offset(x: max(min(dragging.width + position.width, 220), 0))
    }
}
