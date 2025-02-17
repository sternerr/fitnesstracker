//
//  TopBar.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-17.
//

import SwiftUI

struct TopBar<Content: View>: View {
    @State var text: String
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        HStack {
                content()
        }
        .overlay(
            Text(text)
                .font(.title3)
                .foregroundStyle(.onSurface)
        )
        .padding(.vertical)
    }
}
