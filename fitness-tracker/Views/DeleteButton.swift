//
//  Delete.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-16.
//

import SwiftUI

struct DeleteButton: View {
    var deleteAction: () -> Void
    var body: some View {
        Button(role: .destructive) {
            deleteAction()
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

#Preview {
    DeleteButton(deleteAction: {})
}
