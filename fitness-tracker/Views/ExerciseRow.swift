//
//  ExerciseRow.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-02-27.
//

import SwiftUI

// Behövs Fixas
struct ExerciseRow: View {
    @State var exercise: Exercise
    
    var body: some View {
        HStack {
            Text(exercise.name)
                .padding()
                .cornerRadius(8)

            Spacer()
            
//            Image(systemName: "plus.app.fill")
//                .resizable()
//                .frame(width: 40.0, height: 40.0)
//                .foregroundStyle(.primary70)
//                .tint(.blue)
        }
        .background(
            .secondarySurfaceContainer
        )
        .clipShape(.rect(cornerRadius: 8))
    }
}
