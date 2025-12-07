//
//  TabViewContentWrapper.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/7/25.
//

import SwiftUI

struct TabViewContentWrapper<Content: View>: View {
    var dragging: CGSize
    var position: CGSize
    var scale: CGFloat
    var content: Content

    init(dragging: CGSize, position: CGSize, scale: CGFloat, @ViewBuilder content: () -> Content) {
        self.dragging = dragging
        self.position = position
        self.scale = scale
        self.content = content()
    }
    
    var body: some View {
        content
            .mask { RoundedRectangle(cornerRadius: min(dragging.width + position.width / 5, 50), style: .continuous) }
            .scaleEffect(scale)
            .offset(x: max(min(dragging.width + position.width, 220), 0))
    }
}
