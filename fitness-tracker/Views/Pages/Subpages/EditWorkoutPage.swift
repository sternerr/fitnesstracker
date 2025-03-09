//
//  EditWorkoutPage.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-03.
//

import SwiftUI

struct EditWorkoutPage: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var viewModel: WorkoutViewModel
    
    @State var workout: WorkoutModel
    
    var body: some View {
        Container  {
            
            Block {
                TopBar(text: self.workout.name) {
                    Image(systemName: "arrow.backward.square.fill")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(.secondarySurfaceContainer)
                        .onTapGesture { self.dismiss() }
                    
                    Spacer()
                }
            }
            
            Block {
                ScrollView {
                    ForEach(workout.exercises, id: \.self) { exercise in
//                        ExerciseCard(viewModel: self.$viewModel, exercise: exercise)
                    }
                }
            }
        }
    }
}
