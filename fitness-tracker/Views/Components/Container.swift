//
//  Container.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-17.
//

import SwiftUI

struct Container<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack {
            content()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.surface)
    }
}
