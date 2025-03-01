//
//  CustomList.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-27.
//

import SwiftUI

struct CustomList<Content: View>: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ScrollView {
            VStack {
                self.content()
            }
        }
    }
}
