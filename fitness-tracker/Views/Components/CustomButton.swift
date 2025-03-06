//
//  Button.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-17.
//

import SwiftUI

struct CustomButton: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @State var title: String
    @State var isInfinity: Bool = false
    
    var body: some View {
        Text(title)
            .frame(maxWidth: isInfinity ? .infinity : nil)
            .font(.body)
            .fontWeight(.bold)
            .padding()
            .background(
                Color.Primary,
                in: RoundedRectangle(cornerRadius: 8)
            )
            .foregroundStyle(.white)
    }
}

struct CustomButton_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            CustomButton(title: "test")
                .preferredColorScheme(.dark)
            CustomButton(title: "test")
                .preferredColorScheme(.light)
        }
    }
}
