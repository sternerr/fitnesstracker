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
    @Environment(\.modelContext) private var modelContext
    
    @Query(filter: #Predicate<WorkoutModel> { workout in
        workout.state == ""
    }) var workouts: [WorkoutModel]
    
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
                    if(self.workouts.count > 0 && !text.isEmpty) {
                        let exercise = ExerciseModel(name: text)
                        self.workouts[0].exercises.append(exercise)
                        self.dismiss()
                    }
                    print(self.workouts)
                } label: {
                    CustomButton(title: "Create Exercise")
                }
                
                Spacer()
            }
        }
    }
}
