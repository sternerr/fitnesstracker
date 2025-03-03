//
//  AddExercisePage.swift
//  fitness-tracker
//
//  Created by Noah Sterner on 2025-03-02.
//

import SwiftUI
import SwiftData

struct AddExercisePage: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var viewModel: WorkoutViewModel
    
    @State private var text: String = ""
    
    var body: some View {
        Container {
            Block {
                TopBar(text: "") {
                    Image(systemName: "arrow.backward.square.fill")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(.secondarySurfaceContainer)
                        .onTapGesture { self.dismiss() }
                    
                    
                    TextField("Enter Exercise", text: $text) {}
                        .padding(8)
                        .font(.body)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.secondarySurfaceContainer, lineWidth: 2)
                        )
                }
                
                Button {
                    if(!text.isEmpty) {
                        let exercise = ExerciseModel(name: text)
                        self.viewModel.addExercise(for: self.viewModel.workouts[0], exercise: exercise)
                        self.dismiss()
                    }
                } label: {
                    CustomButton(title: "Create Exercise")
                }
                
                Spacer()
            }
        }
    }
}
