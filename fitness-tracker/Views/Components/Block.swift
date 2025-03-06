//
//  Block.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-17.
//

import SwiftUI

struct Block<Content: View> :View {
    @State var fullbleed: Bool = false
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        let padd: CGFloat = fullbleed ? 0 : 16
        
        VStack {
            content()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, padd)
    }
}
