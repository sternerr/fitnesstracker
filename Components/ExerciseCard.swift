//
//  ExerciseCard.swift
//  fitness-tracker
//
//  Created by Maria Garic on 2025-02-16.
//

import SwiftUI

struct ExerciseCard: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top, 10)
            
            Spacer()
        }
        .frame(width: 300, height: 80)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

#Preview {
    ExerciseCard(title: "Exercise Title")
}
