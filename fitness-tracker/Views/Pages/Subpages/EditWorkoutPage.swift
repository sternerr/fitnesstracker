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
    
    var body: some View {
        Container  {
            
            Block {
                TopBar(text: self.viewModel.workout!.name) {
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
                    ForEach(self.viewModel.exerciseViewModels) { evm in
                        ExerciseCard(exerciseViewModel: evm, workoutViewModel: self.$viewModel)
                    }
                }
            }
        }
    }
}
