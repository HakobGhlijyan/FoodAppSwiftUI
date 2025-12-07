//
//  SideViewButton.swift
//  FoodAppSwiftUI
//
//  Created by Hakob Ghlijyan on 12/7/25.
//

import SwiftUI

struct SideViewButton: View {
    var title: String
    var icon: String
    var action: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(colorScheme == .dark ? .white.opacity(0.7) : .black.opacity(0.7))
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(.gray)
            }
            .font(.system(size: 20))
            .padding(.leading, 10)
            .frame(width: 200, height: 50, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(.gray.opacity(0.3), lineWidth: 1)
            )
        }
        .padding(.leading, 30)
    }
}

#Preview {
    SideViewButton(title: "apple", icon: "applelogo", action: {
        
    })
}
